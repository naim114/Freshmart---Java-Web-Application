<%@page import="freshmart.Purchase"%>
<%@page import="my.com.freshmart.controller.PurchaseController"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="freshmart.Cart"%>
<%@page import="my.com.freshmart.controller.CartController"%>
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
        <title>Purchase - 142 Freshmart</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");

            if (user != null) {
                System.out.println("User: " + user.toString());
            } else {
                System.out.println("User is null in the session.");
                // Handle the case where the user is null, e.g., redirect to the login page
                response.sendRedirect("index.jsp?error=user_not_found");
            }

            PurchaseController pc = new PurchaseController();

            List<Purchase> purchases = pc.getPurchaseByUserId(user.getUserId());

            DecimalFormat df = new DecimalFormat("0.##");
            df.setMinimumFractionDigits(2);
            df.setMaximumFractionDigits(2);
        %>

        <jsp:include page="jspf/header.jspf"/>

        <!-- Page Content -->
        <div class="container mb-5">

            <h2 class="my-4">My Purchases</h2>

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

            <%
                for (Purchase purchase : purchases) {
            %>
            <div class="card mb-4">
                <div class="card-body">
                    <div class="row">
                        <div class="col-6">
                            <img style="height: 200px; object-fit: cover;" src="<%= purchase.getImgURL()%>" alt="..." class="img-thumbnail">
                        </div>
                        <div class="col-6 d-flex align-items-end flex-column">
                            <h3><%= purchase.getItemName()%></h3>
                            <h5>x<%= purchase.getQuantity()%></h5>
                            <h5 class="text-primary">RM<%= purchase.getPrice()%></h5>
                        </div>
                    </div>
                    <hr>
                    <div class="d-flex flex-row-reverse">
                        <h5>Order Total: RM<%= df.format(purchase.getPrice() * purchase.getQuantity())%></h5>
                    </div>
                </div>
                <div class="card-footer d-flex flex-row-reverse">
                    <%
                        if (purchase.getRate() == 0) {
                    %>
                    <a href="#rateModal" data-toggle="modal" data-name="<%= purchase.getItemName()%>"  data-id="<%= purchase.getPurchaseId()%>" class="btn btn-primary open-rate-dialog">Rate</a>
                    <%
                    } else {
                    %>
                    <a href="#viewRateModal" data-toggle="modal" data-name="<%= purchase.getItemName()%>" data-rating="<%= purchase.getRate()%>" data-comment="<%= purchase.getComment()%>" class="btn btn-primary open-view-rate-dialog">View Your Rating</a>
                    <%
                        }
                    %>
                </div>
            </div>
            <%
                }
            %>

        </div>
        <!-- /.container -->

        <!-- Rate Modal -->
        <div class="modal fade" id="rateModal" tabindex="-1" role="dialog" aria-labelledby="rateModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <form class="my-4" action="./ratePurchase" method="post">
                        <input type="hidden" name=methodType" value="ratePurchase"/>
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Give Rating & Review</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p id="desc"></p>

                            <div>
                                <label>Rate</label>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="rating" value="1" checked>
                                    <label class="form-check-label" for="exampleRadios1">
                                        1
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="rating" value="2">
                                    <label class="form-check-label" for="exampleRadios2">
                                        2
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="rating" value="3">
                                    <label class="form-check-label" for="exampleRadios3">
                                        3
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="rating" value="4">
                                    <label class="form-check-label" for="exampleRadios4">
                                        4
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="rating" value="5">
                                    <label class="form-check-label" for="exampleRadios5">
                                        5
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label >Comment</label>
                                <textarea name="comment" class="form-control" rows="3"></textarea>
                            </div>

                            <input name="purchase_id" type="text" id="purchaseId" required hidden/>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Rate Now</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- View Rate Modal -->
        <div class="modal fade" id="viewRateModal" tabindex="-1" role="dialog" aria-labelledby="viewRateModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 id="desc" class="modal-title"></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group row">
                            <label class="col-sm-1 col-form-label">Rate:</label>
                            <div class="col-sm-4">
                                <input type="text" readonly class="form-control-plaintext" id="purchaseRating">
                            </div>
                        </div>

                        <div class="form-group">
                            <label >Comment:</label>
                            <textarea id="purchaseComment" readonly class="form-control" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/jspf/footer.jspf"/>

        <script>
            $(document).on("click", ".open-rate-dialog", function () {
                var name = $(this).data('name');
                var id = $(this).data('id');
                $(".modal-body #purchaseId").val(id);
                $(".modal-body #desc").text("Leave a rating and comment for " + name + ".");
            });

            $(document).on("click", ".open-view-rate-dialog", function () {
                var name = $(this).data('name');
                var rating = $(this).data('rating');
                var comment = $(this).data('comment');

                $(".modal-body #purchaseRating").val(rating);
                $(".modal-body #purchaseComment").val(comment);
                $(".modal-header #desc").text(name + " Rating & Comment");
            });

        </script>
    </body>
</html>
