<%@page import="java.util.List"%>
<%@page import="freshmart.User"%>
<%@page import="my.com.freshmart.controller.UserController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Users - 142 Freshmart</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <%
            UserController uc = new UserController();

            List<User> users = uc.getAllUsers();
        %>

        <jsp:include page="jspf/header.jspf"/>

        <!-- Page Content -->
        <div class="container">

            <h2 class="my-4">Manage Users</h2>
            <table class="table table-hover mb-4">
                <thead>
                    <tr>
                        <th scope="col">Email</th>
                        <th scope="col">Name</th>
                        <th scope="col">Tel No.</th>
                        <th scope="col">Address</th>
                        <!--<th scope="col">Action</th>-->
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (User user : users) {
                    %>
                    <tr>
                        <td><%= user.getEmail()%></td>
                        <td><%= user.getUserName()%></td>
                        <td><%= user.getTelNo()%></td>
                        <td><%= user.getAddress()%></td>
                        <!--<td></td>-->
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

        </div>
        <!-- /.container -->

        <jsp:include page="jspf/footer.jspf"/>
    </body>
</html>
