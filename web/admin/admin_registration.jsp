<%@page import="com.techvoyageblog.entities.Message"%>
<%@include file="../set_header.jsp"%>
<%    Admin admin = (Admin) session.getAttribute("admin");
    if (admin != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    Boolean isKeyEntered = false;
    Object obj = session.getAttribute("isKeyEntered");
    if(obj!=null){
        isKeyEntered = (Boolean)obj;
    }
    if(!isKeyEntered){
        Message msg1 = new Message("Please Enter License Key for Admin Registration", "error", "alert-danger");
        session.setAttribute("msgAdminSide", msg1);
        response.sendRedirect("enter_key.jsp");
        return;
    }
    else{
        session.removeAttribute("isKeyEntered");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Registration</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
              rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
                integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link href="../css/mystyle.css" rel="stylesheet" type="text/css" />
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
        <%@include file="navbar.jsp" %>
        <main class="primary-background banner-background" style="padding: 40px 0px 80px;">
            <div class="container">
                <div class="col-sm-6 offset-sm-3">
                    <div class="card">
                        <div class="card-header text-center primary-background text-white">
                            <span class="fa fa-user-plus fa-2x"></span>
                            <br>
                            Register here
                        </div>
                        <div class="card-body">
                            <form autocomplete="off" action="../AdminRegister" method="post" id="reg-form">

                                <div class="mb-1">
                                    <label for="userName" class="form-label">Username</label>
                                    <input type="text" name="user_name" class="form-control" id="userName" placeholder="Enter name">
                                    <small class="ms-1 text-danger" id="userName-msg"></small>
                                </div>


                                <div class="mb-1" style="position: relative;">
                                    <label for="user_email" class="form-label">Email</label>
                                    <input type="email" name="user_email" class="form-control" id="user_email" placeholder="Enter email">
                                    <i class="fas fa-spinner fa-spin loading" style="display: none; position: absolute; top: 60%; right: 10px; transform: translateY(-50%);"></i>
                                    <i class="fas fa-check-circle tick" style="display: none; color: green; position: absolute; top: 75%; right: 10px; transform: translateY(-50%);"></i>
                                    <i class="fas fa-times-circle cross" style="display: none; color: red; position: absolute; top: 75%; right: 10px; transform: translateY(-50%);"></i>
                                </div>
                                <div class="mb-1">
                                    <small class="ms-1" id="email-msg"></small>
                                </div>
                                <div class="mb-1 text-center" style="position: relative;"> 
                                    <button type="button" class="btn form-control btn-custom mb-2" id="otp-btn">Generate OTP</button>
                                </div>
                                <div class="container text-center" id="loading" style="display:none">  
                                    <span class="fa fa-refresh fa-spin fa-3x"></span>
                                    <h4>Please wait</h4>
                                </div>
                                <div class="mb-1" id="otp-div"  style="display: none;">
                                    <input type="text" name="otp" class="form-control" id="otp-textfield" placeholder="Enter otp">
                                </div>
                                <script>
                                    $(document).ready(function () {
                                        $('#user_email').on('input', function () {
                                            var email = $(this).val();
                                            var loading = $('.loading');
                                            var tick = $('.tick');
                                            var cross = $('.cross');
                                            loading.hide();
                                            tick.hide();
                                            cross.hide();
                                            if (email !== '') {
                                                loading.show();
                                                $.ajax({
                                                    url: '../CheckEmailAdmin',
                                                    method: 'POST',
                                                    data: {email: email},
                                                    success: function (response) {
                                                        loading.hide();
                                                        if (response === 'true') {
                                                            cross.show();
                                                            $("#otp-btn").hide();
                                                            swal("Username already exists");
                                                        } else {
                                                            tick.show();
                                                            $("#otp-btn").show();
                                                        }
                                                    },
                                                    error: function () {
                                                        loading.hide();
                                                    }
                                                });
                                            }
                                        });
                                        $("#otp-btn").on('click', function () {
                                            var email = $("#user_email").val();
                                            var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

                                            if (!emailRegex.test(email)) {
                                                swal("Invalid email format. Please enter a valid email address.");
                                                return;
                                            }
                                            var loading = $('#loading');
                                            loading.hide();
                                            $("#otp-btn").hide();
                                            loading.show();
                                            $.ajax({
                                                url: '../SendEmailForAdminVerification',
                                                method: 'POST',
                                                data: {email: email, userName: $("#userName").val()},
                                                success: function (data, textStatus, jqXHR) {
                                                    if (data.trim() === 'true') {
                                                        swal("OTP sent successfully to the provided email address.");
                                                        $("#otp-btn").show();
                                                        $("#otp-div").show();
                                                        loading.hide();
                                                    } else {
                                                        swal("Failed to send OTP. Please check the email address and try again.");
                                                        $("#otp-btn").show();
                                                        $("#otp-div").hide();
                                                        loading.hide();
                                                    }
                                                },
                                                error: function (jqXHR, textStatus, errorThrown) {

                                                }
                                            });
                                        });
                                    });
                                </script>



                                <div class="" style="position: relative;"> 
                                    <label for="user_password" class="form-label">Password</label>
                                    <input type="password" name="user_password" class="form-control" id="user_password" placeholder="Set password">
                                    <button type="button" id="togglePassword" class="" style="background: #fff;position: absolute;top:55%;right:10px;border:0px;">
                                        <i id="icon" class="fa-regular fa-eye"></i>
                                    </button>
                                </div>
                                <div class="mb-1">
                                    <small class="ms-1" id="password-msg"></small>
                                </div>


                                <div class="mb-3 form-check">
                                    <input type="checkbox" name="check" class="form-check-input" id="check">
                                    <label class="form-check-label" for="check">Agree to our Terms & Conditions</label>
                                </div>
                                <div class="container text-center" id="loader" style="display:none">  
                                    <span class="fa fa-refresh fa-spin fa-3x"></span>
                                    <h4>Please wait</h4>
                                </div>
                                <div class="text-center">
                                    <button id="submit-btn" type="submit" class="btn btn-custom">Register</button>
                                </div>
                            </form>
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
        <script>
                                    $(document).ready(function () {
                                        
                                         let flag = true;
                                        $("#togglePassword").on('click', function () {

                                            let icon = $("#icon");
                                            let passField = $("#user_password");

                                            if (flag) {
                                                console.log("true")
                                                icon.removeClass("fa-eye");
                                                icon.addClass("fa-eye-slash");
                                                passField.attr("type", "text");
                                                flag = false;
                                            } else {
                                                console.log("false;")
                                                icon.removeClass("fa-eye-slash");
                                                icon.addClass("fa-eye");
                                                passField.attr("type", "password");
                                                flag = true;
                                            }
                                        });
                                        
                                        
                                        $("#reg-form").on('submit', function (event) {
                                            event.preventDefault();
                                            if(validateAdmin()==false){
                                                return;
                                            }
                                            $("#loader").show();
                                            $("#submit-btn").hide();
                                            let form = new FormData(this);

                                            $.ajax({
                                                url: "../AdminRegister",
                                                type: 'POST',
                                                data: form,
                                                success: function (data, textStatus, jqXHR) {
//                                                    console.log(data);
                                                    $("#loader").hide();
                                                    $("#submit-btn").show();
                                                    if (data.trim() == 'done') {
                                                        swal("Registered successfully ...We're going to redirect to Login page")
                                                                .then((value) => {
                                                                    window.location = "admin_login.jsp";
                                                                });
                                                    } else {
                                                        swal(data);
                                                    }
                                                },
                                                error: function (jqXHR, textStatus, errorThrown) {
                                                    console.log(data);
                                                    $("#loader").hide();
                                                    $("#submit-btn").show();
                                                    swal("Something went wrong try again");
                                                },
                                                processData: false,
                                                contentType: false
                                            });
                                        });
                                    });
        </script>
    </body>
</html>
