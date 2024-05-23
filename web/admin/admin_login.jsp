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
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if(admin!=null){
        response.sendRedirect("dashboard.jsp");
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="../css/mystyle.css" rel="stylesheet" type="text/css" />
        <style>
            .banner-background{
                clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 90%, 61% 100%, 19% 91%, 0 100%, 0% 30%);
            }
            #togglePassword:focus{
                outline: none;
            }
        </style>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
                integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <main class="d-flex align-items-center primary-background banner-background" style="height: 80vh;">
            <div class="container">
                <div class="row">
                    <div class="col-sm-4 offset-sm-4">
                        <div class="card">
                            <div class="card-header primary-background text-white text-center">
                                <span class="fa fa-user-circle fa-3x"></span>
                                <br>
                                <p>Admin Login</p>
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
                                <form autocomplete="off" action="../AdminLogin" method="post">
                                    <div class="mb-3">
                                        <label for="exampleInputEmail1" class="form-label">Email address</label>
                                        <input name="email" required type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="peterparker@gmail.com">
                                        <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                                    </div>
                                    <div class="mb-3" style="position: relative;"> 
                                        <label for="user_password" class="form-label">Password</label>
                                        <input name="password" id="user_password" required="" type="password" class="form-control" placeholder="Enter password here">
                                        <button type="button" id="togglePassword" class="" style="background: #fff;position: absolute;top:55%;right:10px;border:0px;">
                                            <i id="icon" class="fa-regular fa-eye"></i>
                                        </button>

                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-custom">Login</button>
                                    </div>
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
        <script src="../js/myjs.js" type="text/javascript"></script>
         <script>
            $(document).ready(function () { 
                let flag = true;
                $("#togglePassword").on('click', function () {

                    let icon = $("#icon");
                    let passField = $("#user_password");

                    if (flag) {
                        icon.removeClass("fa-eye");
                        icon.addClass("fa-eye-slash");
                        passField.attr("type", "text");
                        flag = false;
                    } else {
                        icon.removeClass("fa-eye-slash");
                        icon.addClass("fa-eye");
                        passField.attr("type", "password");
                        flag = true;
                    }
                });
            })
        </script>
    </body>
</html>

