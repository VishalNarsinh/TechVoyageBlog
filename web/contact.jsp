<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="set_header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact us</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
              rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="css/mystyle.css" rel="stylesheet" type="text/css" />        


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
        <style>
            .get_in_touch{
                max-width: 1000px;   
                margin: 20vh auto;
                position: relative;
                box-shadow: 0 10px 30px 0px rgba(0,0,0,0.1);
                padding: 30px;
            }
            .title{
                text-transform: uppercase;
                text-align: center;
                letter-spacing: 0.25rem;
                font-size: 3em;
                line-height: 48px;
                padding-bottom: 20px; 
                color:#5543ca;
                background: linear-gradient(to right,#f452dd 0%,#5543ca 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }
            .form-field{
                position: relative;
                margin: 2rem 0;
            }
            .input-text{
                display: block;
                width: 100%;
                height:36px;
                border-width: 0 0 2px 0;
                border-color: #5543ca;
                font-size: 1.25rem;
                line-height: 26px;
                font-weight: 400;
            }
            .input-text:focus + .label,
            .input-text.not-empty + .label{
                transform: translateY(-24px);
            }
            .input-text:focus,#content:focus{
                outline: none;
            }
            .label{
                position: absolute;
                left:20px;
                bottom: 11px;
                font-size: 18px;
                line-height: 26px;
                font-weight: 400;
                color:#5543ca;
                cursor: text;
                transition: transform 0.2s ease;
            }
            .submit-btn{
                display: inline-block;
                background-image: linear-gradient(125deg, #a72879,#064497);
                color:#fff;
                text-transform: uppercase;
                letter-spacing: 2px;
                font-size: 16px;
                padding: 8px 16px;
                border : none;
                width: 200px;
                cursor: pointer;
            }
            #content {
                display: block;
                width: 100%;
                height: 72px; /* Set the desired height for the specific textarea */
                border-width: 0 0 2px 0;
                border-color: #5543ca;
                font-size: 1.25rem;
                line-height: 26px;
                font-weight: 400;
                resize: none; /* Disable textarea resizing if needed */
            }

            #content-label {
                position: absolute;
                left: 20px;
                bottom: 11px; /* Adjust the top position as needed */
                font-size: 18px;
                line-height: 26px;
                font-weight: 400;
                color: #5543ca;
                cursor: text;
                transition: transform 0.2s ease;
            }
            #content:focus + #content-label,
            #content.not-empty + #content-label{
                transform: translateY(-60px);
            }
            .r1{
                height:80px;
            }
            .icon {
                font-size: 1.5rem;
                color:#5543ca;
                background: linear-gradient(to right,#f452dd 0%,#5543ca 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }
            .email-link {
                color: #007bff; /* Change to the desired link color */
                text-decoration: none;
                font-size: 1.1rem;
            }
            .address{
                font-size: 1.1rem;
                font-weight: 400; 

            }
            .details{
                display: flex;
                justify-content: center;
                align-items: center;
            }
        </style>
    </head>
    <body>
        <%@ include file="navbar.jsp" %>
        <section class="get_in_touch"> 
            <div class="container">
                <div class="row">
                    <div class="col-md-4 reach-out-us">
                        <h1 class="title" style="font-size:34px;padding: 0">reach out us</h1>
                        <div class="container">
                            <div class="row r1 mb-1">
                                <div class="col-4 details">
                                    <i class="fa-regular fa-envelope icon"></i>
                                </div>
                                <div class="col-8 details">
                                    <a href="mailto:techvoyageblog@gmail.com" class="email-link">techvoyageblog@gmail.com</a>
                                </div>
                            </div>
                            <div class="row mb-2" style="height: 100px;">
                                <div class="col-4 details">
                                    <i class="fa-solid fa-location-dot icon"></i>
                                </div>
                                <div class="col-8 details d-flex align-items-center justify-content-start">
                                    <p class="address"> 198 West 21th Street, Suite 721 New York NY 10016</p>
                                </div>
                            </div>
                            <div class="row r1">
                                <div class="col-4 details">
                                    <i class="fa-solid fa-phone icon"></i>
                                </div>
                                <div class="col-8 d-flex align-items-center justify-content-start">
                                    <p class="phone">+91 98798 79319</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <h1 class="title">get in touch</h1>
                        <div class="container">
                            <form autocomplete="off" novalidate="" action="SendMessageFromUser" method="post" id="form">
                                <div class="row contact-form">

                                    <div class="col-md-6 form-field">
                                        <input required="" type="email" class="input-text" id="email" name="email">
                                        <label for="email" class="label">Email</label>
                                    </div>
                                    <div class="col-md-6 form-field">
                                        <input type="text" class="input-text" id="subject" name="subject">
                                        <label for="subject" class="label">Subject</label>
                                    </div>
                                    <div class="col-md-12 form-field">
                                        <textarea required="" class="" id="content" name="content"></textarea>
                                        <label for="content" class="" id="content-label">Write Here..</label>
                                    </div>
                                    <div class="container text-center" id="loader" style="display:none">  
                                        <span class="fa fa-refresh fa-spin fa-3x"></span>
                                        <h4>Please wait</h4>
                                    </div>
                                    <div class="col-md-12 form-field text-center" id="submit-btn-div">
                                        <input type="submit" class="submit-btn" id="Send" value="send">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
            $(document).ready(function () {
                $(".input-text").on("input", function () {
                    if ($(this).val().trim() !== "") {
                        $(this).addClass("not-empty");
                    } else {
                        $(this).removeClass("not-empty");
                    }
                });

                $(".input-text").on("blur", function () {
                    if (!$(this).hasClass("not-empty")) {
                        $(this).next(".label").css("transform", "translateY(0)");
                    }
                });

                $(".input-text").on("focus", function () {
                    $(this).next(".label").css("transform", "translateY(-24px)");
                });



                $("#content").on("input", function () {
                    if ($(this).val().trim() !== "") {
                        $(this).addClass("not-empty");
                    } else {
                        $(this).removeClass("not-empty");
                    }
                });

                $("#content").on("blur", function () {
                    if (!$(this).hasClass("not-empty")) {
                        $(this).next("#content-label").css("transform", "translateY(0)");
                    }
                });

                $("#content").on("focus", function () {
                    $(this).next("#content-label").css("transform", "translateY(-60px)");
                });
            });

        </script>
        <script>
            $(document).ready(function () {
                $("#form").on('submit', function () {
                    event.preventDefault();
                    const data = {
                        email: $("#email").val(),
                        subject: $("#subject").val(),
                        content: $("#content").val()
                    };
                    if (data.content.trim() === '' || data.email.trim()==='') {
                        swal("Email or Message must not be empty");
                        return;
                    }
                    var loader = $("#loader");
                    var submitDiv = $("#submit-btn-div");
                    loader.show();
                    submitDiv.hide();
                    
                    $.ajax({
                        url: 'ContactEmail',
                        method: 'POST',
                        data: data,
                        success: function (data, textStatus, jqXHR) {
                            if (data.trim() === 'true') {
                                swal("Your response is saved.We'll reply you as soon as possible");
                                loader.hide();
                                submitDiv.show();
                                $("#form")[0].reset();
                            } else {
                                swal("Something went wrong, Please try again later");
                                loader.hide();
                                submitDiv.show();
                            }
                        }
                    });

                });
            });
        </script>
    </body>
</html>
