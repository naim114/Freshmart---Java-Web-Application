<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Home</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <style>
            .login {
                min-height: 100vh;
            }

            .bg-image {
                background-image: url('images/wp.jpg');
                background-size: cover;
                background-position: center;
            }

            .login-heading {
                font-weight: 300;
            }

            .btn-login {
                font-size: 0.9rem;
                letter-spacing: 0.05rem;
                padding: 0.75rem 1rem;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid ps-md-0">
            <div class="row g-0">
                <div class="d-none d-md-flex col-md-4 col-lg-6 bg-image"></div>
                <div class="col-md-8 col-lg-6">
                    <div class="login d-flex align-items-center py-5">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-9 col-lg-8 mx-auto">
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

                                    <h3 class="login-heading mb-4">Welcome back!</h3>

                                    <!-- Sign In Form -->
                                    <form method="post" action="./login">
                                        <input type="hidden" name=methodType" value="login"/>
                                        <div class="form-floating mb-3">
                                            <label>Email</label>
                                            <input name="email" type="email" class="form-control" placeholder="Enter email">
                                        </div>
                                        <div class="form-floating mb-3">
                                            <label>Password</label>
                                            <input name="password" type="password" class="form-control" placeholder="Enter password">
                                        </div>

                                        <div class="d-grid">
                                            <button class="btn btn-lg btn-primary btn-login text-uppercase fw-bold mb-2 btn-block" type="submit">Sign in</button>
                                            <div class="text-center">
                                                <a class="small" href="registration.jsp">Don't have an account? Register here</a>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>