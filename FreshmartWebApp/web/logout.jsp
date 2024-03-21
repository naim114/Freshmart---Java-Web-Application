<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Logout</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <% session.invalidate();%>
        <div class="container d-flex align-items-center justify-content-center vh-100">
            <div class="alert alert-primary text-center" role="alert">
                You have been successfully logged out.
                <br>Back to <a href="index.jsp">Login Page</a>
            </div>
        </div>

    </body>
</html>