<%@include file="set_header.jsp"%>
<%@page import="com.techvoyageblog.entities.User"%>
<%@page import="com.techvoyageblog.entities.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%    User user = (User) session.getAttribute("currentUser");
    if (user != null) {
        response.sendRedirect("profile.jsp");
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot Password </title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
              rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="css/mystyle.css" rel="stylesheet" type="text/css" />
        <style>
            .banner-background{
                clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 90%, 61% 100%, 19% 91%, 0 100%, 0% 30%);
            }
            #togglePassword:focus{
                outline: none;
            }
        </style>
    </head>
    <body>
        <!-- navbar -->
        <%@include file="navbar.jsp" %>


        <main class="d-flex align-items-center primary-background banner-background" style="height: 80vh;">
            <div class="container">
                <div class="row">
                    <div class="col-sm-4 offset-sm-4">
                        <div class="card">
                            <div class="card-header primary-background text-white text-center">
                                <span class="fa fa-user-circle fa-3x"></span>
                                <br>
                                <p>Forgot Password</p>
                            </div>
                            <%
                                Message msg = (Message) session.getAttribute("msgUserSide");

                                System.out.println("Message in login_page.jsp: " + msg);
                                if (msg != null) {
                            %>
                            <div class="alert <%= msg.getCssClass()%>" role="alert">
                                <%= msg.getContent()%>
                            </div>

                            <%
                                    session.removeAttribute("msgUserSide");
                                }

                            %>
                            <div class="card-body">
                                <form autocomplete="off" action="" method="post">
                                    <div class="mb-3">
                                        <label for="user_email" class="form-label">Enter registered Email address</label>
                                        <input name="email" required type="email" class="form-control" id="email" placeholder="peterparker@gmail.com">
                                    </div>
                                    <div class="mb-1 text-center">
                                        <button type="button" class="btn btn-custom" id="otp-btn">Generate OTP</button>
                                    </div>
                                    <div class="container text-center" id="loader" style="display:none">  
                                        <span class="fa fa-refresh fa-spin fa-3x"></span>
                                        <h4>Please wait</h4>
                                    </div>

                                    <div class="mb-3" id="enter-otp-div"> 
                                        <label for="otp" class="form-label">Enter OTP</label>
                                        <input name="otp" id="otp" type="text" class="form-control" placeholder="Enter OTP here">
                                        <div class="mt-3 text-center">
                                            <button type="button" id="verify-otp-btn" class="btn btn-custom">Verify</button>
                                        </div>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>


        <!--javascript-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
                integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
                integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
                integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script>
            $(document).ready(function () {


                $("#otp-btn").on('click', function () {
                    let email = $("#email").val();
                    var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
                    let loader = $("#loader");
                    let otpDiv = $("#enter-otp-div");
                    let otpBtn = $("#otp-btn");
                    if (email !== '' && emailRegex.test(email)) {

                        $.ajax({
                            url: 'CheckEmailServlet',
                            method: 'POST',
                            data: {email: email},
                            success: function (data, textStatus, jqXHR) {
                                if (data.trim() == 'true') {
                                    $(otpBtn).hide();
                                    console.log(otpBtn);
                                    $(loader).show();
                                    console.log(loader);
                                    $.ajax({
                                        url: 'ForgotPassword',
                                        method: 'POST',
                                        data: {
                                            email: email
                                        },
                                        success: function (data, textStatus, jqXHR) {
                                            if (data.trim() == 'true') {
                                                swal("OTP has been sent to your registered email address");
                                                loader.hide();
                                                otpBtn.show();
                                                otpDiv.show();
                                            }

                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {

                                        }
                                    });

                                } else {
                                    swal("Email address does not exists");
                                    loader.hide();
                                    otpBtn.show();
                                    otpDiv.show();
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {

                            }
                        });
                    } else {
                        swal("Please enter valid email address");
                    }

                });


                $("#verify-otp-btn").on('click', function () {
                    let otp = $("#otp").val();
                    let email = $("#email").val();
                    if (otp.trim() == '' || otp == undefined || email.trim()=='' || email == undefined) {
                        swal("Email and OTP must not be empty");
                    } else {
                        $.ajax({
                            url: 'VerifyOTPForPasswordUpdate',
                            method: 'POST',
                            data: {
                                email : email,
                                otp : otp
                            },
                            success: function (data, textStatus, jqXHR) {
                                if(data.trim()=='true'){
                                    window.location = "change_password.jsp";
                                }
                                else{
                                    swal("Invalid OTP, Please recheck the OTP you entered")
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {

                            }
                        });
                    }
                });
            });
        </script>
    </body>
</html>
