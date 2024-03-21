<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Item - 142 Freshmart</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <jsp:include page="jspf/header.jspf"/>

        <!-- Page Content -->
        <div class="container">
            <h2 class="my-4">Add Item</h2>

            <form class="my-4" action="./addItem" method="post">
                <input type="hidden" name=methodType" value="addItem"/>
                <div class="form-group">
                    <label>Name</label>
                    <input name="item_name" type="text" class="form-control" placeholder="Enter item name" required>
                </div>
                <div class="form-group">
                    <label>Price (RM)</label>
                    <input name="price" type="number" class="form-control" min="0.01" step="0.01"  required>
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <input name="description" type="text" class="form-control" placeholder="Enter description" required>
                </div>
                <div class="form-group">
                    <label>Image URL</label>
                    <input name="img_url"type="text" class="form-control" placeholder="Enter url" required>
                </div>

                <button class="btn btn-primary" type="submit">Confirm</button>
            </form>
        </div>
        <!-- /.container -->

        <jsp:include page="jspf/footer.jspf"/>
    </body>
</html>
