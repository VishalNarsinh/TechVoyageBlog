<%-- Document : index Created on : 11 Aug, 2023, 9:33:18 PM Author : vishal --%>
<%@include file="../set_header.jsp"%>
<%@page import="com.techvoyageblog.entities.Message"%>
<%@page import="com.techvoyageblog.dao.CommentDao"%>
<%@page import="com.techvoyageblog.dao.LikeDao"%>
<%@page import="com.techvoyageblog.dao.CategoryDao"%>
<%@page import="com.techvoyageblog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.techvoyageblog.dao.PostDao"%>
<%@page import="com.techvoyageblog.helper.ConnectionProvider" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%    Admin admin = (Admin) session.getAttribute("admin");
%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to TechVoyageBlog</title>
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
            .box{
                box-shadow:
                    inset 0 -3em 3em rgba(0, 0, 0, 0.1),
                    0 0 0 2px rgb(255, 255, 255),
                    0.3em 0.3em 1em rgba(0, 0, 0, 0.3);
            }
        </style>
    </head>

    <body>
        <!--navbar-->
        <%@include file="navbar.jsp" %>

        <!--banner-->
        <div class="container-fluid m-0 p-0 mb-4">
            <div class="col-md-12 primary-background banner-background">
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
                <div class="h-100 p-5 border border-top-0 rounded-3">
                    <div class="container p-5">
                        <h3 class="display-3 text-white mb-3">Welcome to TechVoyageBlog</h3>
                        <p class="text-white fs-5">
                            Manage the dynamic world of technology content at TechVoyageBlog.
                            <br>As an admin, you have the power to oversee and organize the community.
                            <br>Explore your administrative capabilities and ensure a smooth tech journey for all users.
                        </p>

                        <%                            if (admin == null) {
                        %>
                        <a href="admin_registration.jsp" class="btn btn-outline-light btn-lg"><span class="fas fa-user-plus"></span>Register</a>
                        <a href="admin_login.jsp" class="btn btn-outline-light btn-lg"><i class="fas fa-circle-user"></i>Login</a>
                        <%
                            }%>
                    </div>
                </div>
            </div>
        </div>
        <div class="container mt-5">

            <div class="row mb-3">
                <%
                    CategoryDao cd = new CategoryDao(ConnectionProvider.getConnection());
                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                    CommentDao cd1 = new CommentDao(ConnectionProvider.getConnection());

                    PostDao dao = new PostDao(ConnectionProvider.getConnection());
                    List<Post> posts = dao.getAllPosts();
                    if (posts.size() == 0) {
                %>
                <div class="row">
                    <h3>No blogs has been posted yet</h3>
                </div>
                <%
                } else {
                    for (int i = 0; i < posts.size(); i++) {
                        if (i == 12) {
                            break;
                        }
                        Post post = posts.get(i);
                %> 
                <div class="col-sm-4">
                    <div class="card box mb-3">

                        <div class="card-header primary-background text-center text-white"><%= cd.getCategoryNameBycid(post.getCatId())%></div>
                        <div class="card-body" style="height: 35vh; overflow: hidden;">
                            <h5 class="card-title"><%= post.getpTitle()%></h5>
                            <p class="card-text"><%= post.getpContent()%></p>

                        </div>
                        <div class="card-footer">
                            <a href="show_blog_page.jsp?post_id=<%= post.getpId()%>" class="btn btn-custom">Read more</a>
                            <a href="show_blog_page.jsp?post_id=<%= post.getpId()%>#interaction" class="btn btn-custom btn-small"><i class="far fa-heart"></i><span class="ms-1 like-counter<%=post.getpId()%>"><%= ld.countLikeOnPost(post.getpId())%></span></a>
                            <a href="show_blog_page.jsp?post_id=<%= post.getpId()%>#interaction" class="btn btn-custom btn-small"><i class="far fa-comment"></i><span class="ms-1 comment-counter<%=post.getpId()%>"><%= cd1.countCommentOnPost(post.getpId())%></span></a>
                        </div>
                    </div>
                </div>
                <%}
                    }%>
            </div>

        </div>

        <!--javascript-->

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
                integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
                integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>
        <script src="../js/myjs.js" type="text/javascript"></script>


    </body>

</html>