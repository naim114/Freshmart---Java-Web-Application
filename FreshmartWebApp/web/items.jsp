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
        <title>Manage Items - 142 Freshmart</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <%
            ItemController ic = new ItemController();

            List<Item> items = ic.getAllItems();
        %>

        <jsp:include page="jspf/header.jspf"/>

        <!-- Page Content -->
        <div class="container">

            <h2 class="my-4">Manage Items</h2>

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

            <a class="btn btn-primary mb-4" href="item_add.jsp">Add Item</a>

            <table class="table table-hover mb-4">
                <thead>
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Price (RM)</th>
                        <th scope="col">Description</th>
                        <th scope="col">Image</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Item item : items) {
                    %>
                    <tr>
                        <td><%= item.getItemName()%></td>
                        <td><%= item.getPrice()%></td>
                        <td><%= item.getDescription()%></td>
                        <td>
                            <img style="height: 200px; object-fit: cover;" src="<%= item.getImgURL()%>" alt="..." class="img-thumbnail">
                        </td>
                        <td>
                            <a href="item_edit.jsp?itemId=<%= item.getItemId()%>" class="btn btn-primary">Edit</a>
                            <a href="#deleteModal" data-name="<%= item.getItemName()%>" data-id="<%= item.getItemId()%>" class="btn btn-danger open-delete-dialog" data-toggle="modal">Delete</a>
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
