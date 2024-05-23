<%-- Document : index Created on : 11 Aug, 2023, 9:33:18 PM Author : vishal --%>
<%@page import="com.techvoyageblog.entities.Message"%>
<%@include file="set_header.jsp" %>
<%--<%@page errorPage="error_500.jsp" %>--%>
<%@page import="com.techvoyageblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="com.techvoyageblog.dao.CommentDao"%>
<%@page import="com.techvoyageblog.dao.LikeDao"%>
<%@page import="com.techvoyageblog.dao.CategoryDao"%>
<%@page import="com.techvoyageblog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.techvoyageblog.dao.PostDao"%>
<%@page import="com.techvoyageblog.helper.ConnectionProvider" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%    User user = (User) session.getAttribute("currentUser");
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
        <link href="css/mystyle.css" rel="stylesheet" type="text/css" />
        <style>
            .banner-background{
                clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 90%, 61% 100%, 19% 91%, 0 100%, 0% 30%);
            }
            
        </style>
    </head>

    <body>
        <!--navbar-->
        <%@include file="navbar.jsp" %>
        <%
            Message msg = (Message) session.getAttribute("msg");
            if (msg != null) {
        %>
        <div class="mb-0 alert <%= msg.getCssClass()%>" role="alert">
            <%= msg.getContent()%>
        </div>

        <%
                session.removeAttribute("msg");
            }
            if (user != null && user.getStatus().equalsIgnoreCase("inactive")) {
        %>
        <div class="mb-0 alert alert-danger" role="alert">
            Hello <%=user.getName()%>, your Account has been set INACTIVE by the admin because you may have posted false or misleading information. You cannot post blogs right now. Please contact us and we will review your Account, if it is good to go we will definitely set it ACTIVE so you can start posting blogs again.
        </div>
        <%
            }

        %>

        <!--banner-->
        <div class="container-fluid m-0 p-0 mb-4">
            <div class="col-md-12 primary-background banner-background">
                <div class="h-100 p-5 border border-top-0 rounded-3">
                    <div class="container p-5">
                        <h3 class="display-3 text-white mb-3">Welcome to TechVoyageBlog</h3>
                        <p class="text-white fs-5">
                            Explore the dynamic world of technology through diverse perspectives at TechVoyageBlog.
                            <br>Empowering tech enthusiasts to share their insights and knowledge.
                            <br>Join our community and start sharing your tech journey today!
                        </p>

                        <%                            if (user == null) {
                        %>

                        <a href="register_page.jsp" class="btn btn-outline-light btn-lg"><span class="fas fa-user-plus"></span>Start its free!</a>
                        <a href="login_page.jsp" class="btn btn-outline-light btn-lg"><i class="fas fa-circle-user"></i>Login</a>
                        <%
                            }%>
                    </div>
                </div>
            </div>
        </div>
        <%
            PostDao dao = new PostDao(ConnectionProvider.getConnection());
            CategoryDao cd = new CategoryDao(ConnectionProvider.getConnection());
            LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
            CommentDao cd1 = new CommentDao(ConnectionProvider.getConnection());

        %>

        <div class="container mt-5">
            <div class="row mb-3">
                <%                    List<Post> posts = dao.getAllPosts();
                    if (posts.size() == 0) {
                %>
                <div class="row">
                    <h3>No blogs has been posted yet</h3>
                </div>
                <%
                } else {
//                    for (Post post : posts) {
                    for (int i = 0; i < posts.size(); i++) {
                        if (i == 12) {
                            break;
                        }
                        Post post = posts.get(i);
                %> 
                <div class="col-sm-4">
                    <div class="card box mb-3">
                        <%

                        %>
                        <div class="card-header primary-background text-center text-white"><%= cd.getCategoryNameBycid(post.getCatId())%></div>
                        <div class="card-body" style="height: 35vh; overflow: hidden;">
                            <h5 class="card-title"><%= post.getpTitle()%></h5>
                            <p class="card-text"><%= post.getpContent()%></p>

                        </div>
                        <div class="card-footer">
                            <a href="show_blog_page.jsp?post_id=<%= post.getpId()%>" class="btn btn-custom">Read more</a>
                            <a href="show_blog_page.jsp?post_id=<%= post.getpId()%>#interaction" class="btn btn-custom"><i class="far fa-heart"></i><span class="ms-1"><%= ld.countLikeOnPost(post.getpId())%></span></a>
                            <a href="show_blog_page.jsp?post_id=<%= post.getpId()%>#interaction" class="btn btn-custom"><i class="far fa-comment"></i><span class="ms-1"><%= cd1.countCommentOnPost(post.getpId())%></span></a>
                        </div>
                    </div>
                </div>
                <%}
                    }%>
            </div>

        </div>
        <footer id="about-us">
            <div class="text-center"><h2>About us</h2></div>
            <section>
                <div class="container">

                    <p class="fs-5">
                        Welcome to TechVoyageBlog, a vibrant community where tech enthusiasts from around the world come together to share, learn, and connect. Our platform is designed with you in mind, offering a range of features to enhance your tech journey.
                    </p>

                    <p>

                    <ul class="list-group list-group-flush">
                        <li class="list-group-item fs-5">At TechVoyageBlog, you can:</li>
                        <li class="list-group-item list-group-item-primary">Write and edit your own tech blogs to share your knowledge and experiences.</li>
                        <li class="list-group-item list-group-item-primary">Read insightful blogs contributed by fellow tech enthusiasts.</li>
                        <li class="list-group-item list-group-item-primary">Engage with the community by liking and commenting on blogs that resonate with you.</li>
                        <li class="list-group-item list-group-item-primary">Explore user profiles to learn more about the creators behind the content.</li>
                        <li class="list-group-item list-group-item-primary">Effortlessly manage your own profile to showcase your skills and interests.</li>
                        <li class="list-group-item list-group-item-primary">Search for specific blogs or topics to discover content tailored to your preferences.</li>
                    </ul>
                    </p>

                    <p>
                        TechVoyageBlog is more than just a platform, it's a dynamic space where your voice matters. Whether you're a seasoned professional or just starting your tech journey, you'll find a supportive community ready to inspire, educate, and connect.
                    </p>

                    <p class="fs-5">
                        Join us today and immerse yourself in the world of technology at TechVoyageBlog!
                    </p>
                </div>
            </section>
            <div class="text-center mt-4">
                <a class="" style="text-decoration: none;" href="https://www.instagram.com/the.other.vishall?igsh=OGQ5ZDc2ODk2ZA==" target="_blank" data-bs-toggle="tooltip" data-bs-placement="top" title="Interact with us on Instagram">
                    <i id="instagram-icon" class="fab fa-instagram" ></i> the.other.vishall
                </a>
            </div>


            <div class="container text-center mt-4">
                <p class="text-muted">Designed and Developed by Vishal Narsinh</p>
            </div>




        </footer>
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




    </body>

</html>