<%@page import="java.text.DecimalFormat"%>
<%@page import="freshmart.Cart"%>
<%@page import="my.com.freshmart.controller.CartController"%>
<%@page import="freshmart.Item"%>
<%@page import="my.com.freshmart.controller.ItemController"%>
<%@page import="java.util.List"%>
<%@page import="freshmart.User"%>
<%@page import="my.com.freshmart.controller.UserController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart - 142 Freshmart</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");

            if (user != null) {
                System.out.println("User: " + user.toString());
            } else {
                System.out.println("User is null in the session.");
                // Handle the case where the user is null, e.g., redirect to the login page
                response.sendRedirect("index.jsp?error=user_not_found");
            }

            CartController cc = new CartController();

            List<Cart> carts = cc.getCartByUserId(user.getUserId());

            DecimalFormat df = new DecimalFormat("0.##");
            df.setMinimumFractionDigits(2);
            df.setMaximumFractionDigits(2);
        %>

        <jsp:include page="jspf/header.jspf"/>

        <!-- Page Content -->
        <div class="container mb-5">

            <h2 class="my-4">My Cart</h2>

            <%
                String success_msg = (String) request.getAttribute("success_msg");

                if (success_msg != null) {
            %>
            <div class="alert alert-success" role="alert">
                <%= success_msg%>
            </div>
            <%
                }
            %>

            <table class="table table-hover mb-4">
                <thead>
                    <tr>
                        <th scope="col">Item</th>
                        <th scope="col">Price (RM)</th>
                        <th scope="col">Image</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Item Total (RM)</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Cart cart : carts) {
                    %>
                    <tr>
                        <td><%= cart.getItem().getItemName()%></td>
                        <td><%= cart.getItem().getPrice()%></td>
                        <td>
                            <img style="height: 200px; object-fit: cover;" src="<%= cart.getItem().getImgURL()%>" alt="..." class="img-thumbnail">
                        </td>
                        <td><%= cart.getQuantity()%></td>
                        <td><%= df.format(cart.getItem().getPrice() * cart.getQuantity())%></td>
                        <td>
                            <div class="mb-2" >
                                <form action="./addPurchase" method="post">
                                    <input type="hidden" name=methodType" value="addPurchase"/>

                                    <input name="user_id" type="text" value="<%= user.getUserId()%>" required hidden/>
                                    <input name="item_id" type="text" value="<%= cart.getItem().getItemId()%>" required hidden/>
                                    <input name="item_name" type="text" value="<%= cart.getItem().getItemName()%>" required hidden/>
                                    <input name="price" type="number" value="<%= cart.getItem().getPrice()%>" required hidden/>
                                    <input name="img_url" type="text" value="<%= cart.getItem().getImgURL()%>" required hidden/>
                                    <input name="quantity" type="number" value="<%= cart.getQuantity()%>" required hidden/>

                                    <button type="submit" class="btn btn-primary">Confirm Purchase</a>
                                </form>
                            </div>

                            <a href="#deleteModal" data-name="<%= cart.getItem().getItemName()%>" data-id="<%= cart.getItem().getItemId()%>" class="btn btn-danger open-delete-dialog" data-toggle="modal">Remove</a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

        </div>
        <!-- /.container -->

        <!-- Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <form class="my-4" action="./deleteCart" method="post">
                        <input type="hidden" name=methodType" value="deleteCart"/>
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Remove item from cart?</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <input name="user_id" type="text" value="<%= user.getUserId()%>" required hidden/>
                            <input name="item_id" type="text" id="itemId" required hidden/>
                            <p id="desc"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-danger">Confirm Delete</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="/jspf/footer.jspf"/>

        <script>
            $(document).on("click", ".open-delete-dialog", function () {
                var id = $(this).data('id');
                var name = $(this).data('name');
                $(".modal-body #itemId").val(id);
                $(".modal-body #itemName").val(name);
                $(".modal-body #desc").text("Are you sure you want to remove " + name + " from cart?");
            });
        </script>
    </body>
</html>
