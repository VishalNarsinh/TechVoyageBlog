<%-- 
    Document   : admin_login
    Created on : 16 Sep, 2023, 8:20:58 AM
    Author     : vishal
--%>
<%@include file="../set_header.jsp"%>
<%@page import="com.techvoyageblog.admin.Admin"%>
<%@page import="com.techvoyageblog.entities.User"%>
<%@page import="com.techvoyageblog.entities.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%    Admin admin = (Admin) session.getAttribute("admin");
    if (admin != null) {
        response.sendRedirect("dashboard.jsp");
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Enter License key</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
                integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link href="../css/mystyle.css" rel="stylesheet" type="text/css" />
        <style>
            .banner-background{
                clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 90%, 61% 100%, 19% 91%, 0 100%, 0% 30%);
            }
            .contact-links {
                text-decoration: none;
                color: black;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <main class="d-flex align-items-center primary-background" style="height: 93vh;">
            <div class="container">
                <div class="row">
                    <div class="col-sm-4 offset-sm-4">
                        <div class="card">
                            <div class="card-header primary-background text-white d-flex align-items-center justify-content-center">
                                <span class="fas fa-key fa-3x"></span>
                                <br>
                                <p></p>
                            </div>
                            <%
                                Message msg = (Message) session.getAttribute("msgAdminSide");
                                if (msg != null) {
                            %>
                            <div class="mb-0 alert <%= msg.getCssClass()%>" role="alert">
                                <%= msg.getContent()%>
                            </div>

                            <%
                                    session.removeAttribute("msgAdminSide");
                                }

                            %>
                            <div class="card-body">
                                <form autocomplete="off" action="../VerifyLicenseKey" id="key-form" method="post">
                                    <div class="mb-3">
                                        <label for="keyInput" class="form-label">License key</label>
                                        <input autocomplete="off" name="text" required type="text" class="form-control" id="keyInput" aria-describedby="keyHelp" placeholder="Enter License Key here">
                                        <div id="keyHelp" class="form-text mt-2">
                                            <div class="mb-2">Never share License Key with anyone else.</div>
                                            <div>Contact <a class="contact-links" href="mailto:techvoyageblog@gmail.com">techvoyageblog@gmail.com</a> for getting License Key</div>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" id="verify-btn" class="btn btn-custom">Verfiy</button>
                                    </div>
                                    <script>
                                        $(document).ready(function () {
                                            $("#key-form").on('submit', function () {
                                                event.preventDefault();
                                                $.ajax({
                                                    url: '../VerifyLicenseKey',
                                                    method: 'POST',
                                                    data: {key: $("#keyInput").val()},
                                                    success: function (data, textStatus, jqXHR) {
                                                        if (data.trim() === 'true') {
                                                            console.log()
                                                            swal("Key Verified ...We're going to redirect to Registration page")
                                                                    .then(() => {
                                                                        window.location = "admin_registration.jsp";
                                                                    });
                                                        } else {
                                                            swal(data);
                                                        }
                                                    }

                                                });

                                            });
                                        });
                                    </script>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>


        <!--javascript-->

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
                integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
                integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="../js/myjs.js" type="text/javascript"></script>
    </body>
</html>

