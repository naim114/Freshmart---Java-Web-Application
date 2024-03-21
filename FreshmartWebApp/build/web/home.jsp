<%@page import="freshmart.Item"%>
<%@page import="java.util.List"%>
<%@page import="my.com.freshmart.controller.ItemController"%>
<%@page import="freshmart.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Home - 142 Freshmart</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <%
            System.out.println("Inside Welcome page...........");

            User user = (User) session.getAttribute("user");

            if (user != null) {
                System.out.println("User: " + user.toString());
            } else {
                System.out.println("User is null in the session.");
                // Handle the case where the user is null, e.g., redirect to the login page
                response.sendRedirect("index.jsp?error=user_not_found");
            }

            ItemController ic = new ItemController();

            List<Item> items = ic.getAllItems();
        %>

        <jsp:include page="jspf/header.jspf"/>

        <!-- Page Content -->
        <div class="container">

            <!-- Page Heading -->
            <h2 class="my-4">Welcome <%= user.getUserName()%> to 142 Freshmart!</h2>

            <%
                if (user.isIsAdmin()) {
            %>
            <div class="mb-4">
                <a href="users.jsp">Manage Users</a> |
                <a href="items.jsp">Manage Items</a> |
                <a href="purchases.jsp">Manage Purchase</a>
            </div>
            <%
                }
            %>
            <div class="row">
                <%
                    for (Item item : items) {
                %>
                <div class="col-lg-4 col-sm-6 mb-4">
                    <div class="card h-100">
                        <a href="item.jsp?itemId=<%= item.getItemId()%>"><img class="card-img-top" style="height: 200px; object-fit: cover;" src="<%= item.getImgURL()%>" alt=""></a>
                        <div class="card-body">
                            <h4 class="card-title">
                                <a href="item.jsp?itemId=<%= item.getItemId()%>">
                                    <%= item.getItemName()%> (RM<%= item.getPrice()%>)
                                </a>
                            </h4>
                            <p class="card-text">
                                <%= item.getDescription()%>
                            </p>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            <!-- /.row -->

        </div>
        <!-- /.container -->

        <jsp:include page="jspf/footer.jspf"/>
    </body>
</html>