<%-- 
    Document   : dashboard
    Created on : 16 Sep, 2023, 12:08:18 PM
    Author     : vishal
--%>
<%@include file="../set_header.jsp"%>
<%@page import="com.techvoyageblog.helper.ConnectionProvider"%>
<%@page import="com.techvoyageblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techvoyageblog.dao.CategoryDao"%>
<%@page import="java.io.File"%>
<%@page import="com.techvoyageblog.entities.Message"%>
<%@page import="com.techvoyageblog.admin.Admin"%>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        Message msg1 = new Message("You have to Login first", "error", "alert-danger");
        session.setAttribute("msgAdminSide", msg1);
        response.sendRedirect("admin_login.jsp");
        return;
    }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
              rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="../css/mystyle.css" rel="stylesheet" type="text/css" />
        <style>
            .banner-background{
                clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 90%, 61% 100%, 19% 91%, 0 100%, 0% 30%);
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
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
        


        <main>
            <div class="container">
                <div class="row mt-4">
                    <div class="col-md-4 order-first order-md-last" style="z-index: 0;">
                        <!--categories-->
                        <div class="list-group">
                            <a onclick="getPosts(0, this)" class="c-link list-group-item list-group-item-action active-primary" aria-current="true">
                                All Posts
                            </a>
                            <%
                                CategoryDao cd = new CategoryDao(ConnectionProvider.getConnection());
                                ArrayList<Category> clist = cd.getAllCategories();
                                for (Category cl : clist) {
                            %>
                            <a onclick="getPosts(<%= cl.getCid()%>, this)" class="c-link list-group-item list-group-item-action"><%= cl.getName()%></a>
                            <%
                                }
                            %>
                        </div>
                        
                    </div>
                   
                    <div class="col-md-8 order-last order-md-first" style="">
                        <!--posts-->
                        <div class="container text-center" id="loader">
                            <i class="fa fa-refresh fa-3x fa-spin"></i>
                            <h3 class="mt-2">Loading...</h3>
                        </div>


                        <div class="container-fluid" id="post-container"></div>
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


                            function getPosts(catId, ref) {
                                $(".c-link").removeClass('btn-custom');
                                $("#loader").show();
                                $("#post-container").hide();
                                $.ajax({
                                    url: "load_posts.jsp",
                                    data: {
                                        cid: catId
                                    },
                                    success: function (data, textStatus, jqXHR) {
                        //                        console.log(data);
                                        $("#loader").hide();
                                        $("#post-container").show();
                                        $("#post-container").html(data);
                                        $(ref).addClass('btn-custom');
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        console.log("AJAX request failed:", textStatus, errorThrown);
                                    }
                                });
                            }

                            
                            $(document).ready(function (e) {
                                let allPost = $(".c-link")[0];
                                getPosts(0, allPost);

                            });
                        </script>
    </body>
</html>
