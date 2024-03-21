<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="freshmart.User"%>
<%@page import="freshmart.Item"%>
<%@page import="my.com.freshmart.controller.ItemController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    System.out.println("...Item page");
    int itemId = Integer.parseInt(request.getParameter("itemId"));

    ItemController ic = new ItemController();

    Item item = ic.getItemById(itemId);

    System.out.println(item.toString());

    User user = (User) session.getAttribute("user");

    if (user != null) {
        System.out.println("User: " + user.toString());
    } else {
        System.out.println("User is null in the session.");
        // Handle the case where the user is null, e.g., redirect to the login page
        response.sendRedirect("index.jsp?error=user_not_found");
    }

    List<Item> items = ic.getAllItems();
    List<Item> suggested = new ArrayList<Item>(items.subList(0, Math.min(items.size(), 4)));
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= item.getItemName()%> - 142 Freshmart</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <jsp:include page="jspf/header.jspf"/>

        <!-- Page Content -->
        <div class="container">

            <!-- Portfolio Item Heading -->
            <h1 class="my-4"><%= item.getItemName()%>
                <small>RM<%= item.getPrice()%></small>
            </h1>

            <!-- Portfolio Item Row -->
            <div class="row">

                <div class="col-md-8">
                    <img style="height: 400px; width: 700px; object-fit: cover;" src="<%= item.getImgURL()%>" alt="">
                </div>

                <div class="col-md-4">
                    <h3 class="my-3">Item Description</h3>
                    <p><%= item.getDescription()%></p>

                    <form class="my-4" action="./addCart" method="post">
                        <input type="hidden" name=methodType" value="addCart"/>
                        <input name="user_id" value="<%= user.getUserId()%>" type="text" hidden/>
                        <input name="item_id" value="<%= item.getItemId()%>" type="text" hidden/>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Quantity: </label>
                            <div class="mx-3 col-sm-4">
                                <input name="quantity" type="number"class="form-control" value="1" min="1">
                            </div>
                        </div>

                        <button class="btn btn-primary">Add to cart</button>
                    </form>
                </div>

            </div>
            <!-- /.row -->

            <!-- Related Projects Row -->
            <h5 class="my-4">View other item</h5>

            <div class="row">
                <%
                    for (Item suggestedItem : suggested) {
                %>
                <div class="col-md-3 col-sm-6 mb-4">
                    <div class="card h-100">
                        <a href="item.jsp?itemId=<%= suggestedItem.getItemId()%>"><img class="card-img-top" style="height: 200px; object-fit: cover;" src="<%= suggestedItem.getImgURL()%>" alt=""></a>
                        <div class="card-body">
                            <h4 class="card-title">
                                <a href="item.jsp?itemId=<%= suggestedItem.getItemId()%>">
                                    <%= suggestedItem.getItemName()%> (RM<%= suggestedItem.getPrice()%>)
                                </a>
                            </h4>
                            <p class="card-text">
                                <%= suggestedItem.getDescription()%>
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
