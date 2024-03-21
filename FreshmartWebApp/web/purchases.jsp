<%@page import="java.text.DecimalFormat"%>
<%@page import="freshmart.Purchase"%>
<%@page import="java.util.List"%>
<%@page import="my.com.freshmart.controller.PurchaseController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Purchases - 142 Freshmart</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <%
            PurchaseController pc = new PurchaseController();

            List<Purchase> purchases = pc.getAllPurchases();

            DecimalFormat df = new DecimalFormat("0.##");
            df.setMinimumFractionDigits(2);
            df.setMaximumFractionDigits(2);
        %>

        <jsp:include page="jspf/header.jspf"/>

        <!-- Page Content -->
        <div class="container">

            <h2 class="my-4">Manage Purchases</h2>

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
                        <th scope="col">Image</th>
                        <th scope="col">Item</th>
                        <th scope="col">Price (RM)</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Order Total (RM)</th>
                        <th scope="col">User</th>
                        <th scope="col">Rating</th>
                        <th scope="col">Comment</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Purchase purchase : purchases) {
                    %>
                    <tr>
                        <td>
                            <img style="height: 200px; object-fit: cover;" src="<%= purchase.getImgURL()%>" alt="..." class="img-thumbnail">
                        </td>
                        <td><%= purchase.getItemName()%></td>
                        <td><%= purchase.getPrice()%></td>
                        <td><%= purchase.getQuantity()%></td>
                        <td><%= df.format(purchase.getPrice() * purchase.getQuantity())%></td>
                        <td><%= purchase.getUser().getUserName()%> (<%= purchase.getUser().getEmail()%>)</td>
                        <td><%= purchase.getRate() == 0 ? "None" : purchase.getRate()%></td>
                        <td><%= purchase.getComment() == null ? "None" : purchase.getComment()%></td>
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
                    <form class="my-4" action="./deleteItem" method="post">
                        <input type="hidden" name=methodType" value="deleteItem"/>
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Delete item?</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <input name="item_id" type="text" id="itemId" required hidden/>
                            <input type="text" id="itemName" required hidden/>
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
                $(".modal-body #desc").text("Are you sure you want to delete " + name + "? Deleted item can't be retrieved back.");
            });
        </script>
    </body>
</html>
