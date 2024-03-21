<%@page import="freshmart.Item"%>
<%@page import="my.com.freshmart.controller.ItemController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int itemId = Integer.parseInt(request.getParameter("itemId"));

    ItemController ic = new ItemController();

    Item item = ic.getItemById(itemId);

    System.out.println(item.toString());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit <%= item.getItemName()%> - 142 Freshmart</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <jsp:include page="jspf/header.jspf"/>

        <!-- Page Content -->
        <div class="container">
            <h2 class="my-4">Edit <%= item.getItemName()%></h2>

            <img style="height: 300px; object-fit: cover;" src="<%= item.getImgURL()%>" alt="">

            <form class="my-4" action="./editItem" method="post">
                <input type="hidden" name=methodType" value="editItem"/>
                <div class="form-group">
                    <label>Name</label>
                    <input name="item_id" value="<%= item.getItemId()%>" type="text" hidden>
                    <input name="item_name" value="<%= item.getItemName()%>" type="text" class="form-control" placeholder="Enter item name" required>
                </div>
                <div class="form-group">
                    <label>Price (RM)</label>
                    <input name="price" value="<%= item.getPrice()%>" min="0.01" step="0.01"  type="number" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <input name="description" value="<%= item.getDescription()%>" type="text" class="form-control" placeholder="Enter description" required>
                </div>
                <div class="form-group">
                    <label>Image URL</label>
                    <input name="img_url" value="<%= item.getImgURL()%>" type="text" class="form-control" placeholder="Enter url" required>
                </div>

                <button class="btn btn-primary" type="submit">Confirm</button>
            </form>
        </div>
        <!-- /.container -->

        <jsp:include page="jspf/footer.jspf"/>

    </body>
</html>
