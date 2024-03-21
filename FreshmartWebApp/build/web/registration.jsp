<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Registration</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <style>
            body {
                background: #007bff;
                background: linear-gradient(to right, #0062E6, #33AEFF);
            }

            .card-img-left {
                width: 45%;
                /* Link to your background image using in the property below! */
                background: scroll center url('images/wp2.jpg');
                background-size: cover;
            }

            .btn-login {
                font-size: 0.9rem;
                letter-spacing: 0.05rem;
                padding: 0.75rem 1rem;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-lg-10 col-xl-9 mx-auto">
                    <div class="card flex-row my-5 border-0 shadow rounded-3 overflow-hidden">
                        <div class="card-img-left d-none d-md-flex">
                            <!-- Background image for card set in CSS! -->
                        </div>
                        <div class="card-body p-4 p-sm-5">
                            <h5 class="card-title text-center mb-5 fw-light fs-5">Register</h5>
                            <form action="./addUser" method="post">
                                <input type="hidden" name=methodType" value="addUser"/>

                                <div class="form-floating mb-3">
                                    <label for="inputEmail">Email</label>
                                    <input id="inputEmail" name="email" type="email" class="form-control" placeholder="Enter email" required="true">
                                </div>

                                <div class="form-floating mb-3">
                                    <label for="inputName">Name</label>
                                    <input id="inputName" name="user_name" type="text" class="form-control" placeholder="Enter name" required="true">
                                </div>

                                <div class="form-floating mb-3">
                                    <label for="inputPhone">Phone Number</label>
                                    <input id="inputPhone" name="tel_no" type="text" class="form-control" placeholder="Enter phone number" required="true">
                                </div>

                                <div class="form-floating mb-3">
                                    <label for="inputAdd">Address</label>
                                    <input id="inputAdd" name="address" type="text" class="form-control" placeholder="Enter address" required="true">
                                </div>

                                <hr>

                                <div class="form-floating mb-3">
                                    <label for="inputPwd">Password</label>
                                    <input id="inputPwd" name="password" type="password" class="form-control" placeholder="Enter password" required="true">
                                </div>

                                <div class="d-grid mb-2">
                                    <button class="btn btn-lg btn-primary btn-login fw-bold text-uppercase btn-block" type="submit">Register</button>
                                </div>

                                <a class="d-block text-center mt-2 small" href="index.jsp">Have an account? Sign In</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>