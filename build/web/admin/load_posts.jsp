<%-- 
    Document   : load_posts
    Created on : 16 Sep, 2023, 3:39:27 PM
    Author     : vishal
--%>
<%@include file="../set_header.jsp"%>
<%@page import="com.techvoyageblog.dao.UserDAO"%>
<%@page import="com.techvoyageblog.dao.CommentDao"%>
<%@page import="com.techvoyageblog.entities.User"%>
<%@page import="com.techvoyageblog.dao.LikeDao"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="com.techvoyageblog.entities.Post"%>
<%@page import="com.techvoyageblog.helper.ConnectionProvider"%>
<%@page import="com.techvoyageblog.admin.PostDao"%>
<style>

    .post-title{
        font-weight: 100;
        font-size: 30px;
    }
    .post-content{
        font-weight: 100;
        font-size: 25px;
    }

    .post-user-info{
        font-size: 20px;
    }
    .row-user{
        border:1px solid #e2e2e2;
        padding-top: 15px;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
    }

</style>
<div class="row">
    <%        UserDAO dao = new UserDAO(ConnectionProvider.getConnection());
        int cid = Integer.parseInt(request.getParameter("cid"));
        PostDao pd = new PostDao(ConnectionProvider.getConnection());
        List<Post> posts = null;
        if (cid == 0) {
            posts = pd.getAllPosts();
        } else {
            posts = pd.getPostByCatId(cid);
        }
        if (posts.size() == 0) {
    %>
    <div class="alert alert-secondary text-center" role="alert">
        <h2 class="display-4">No Post in this category...</h2>
    </div>
    <%
            return;
        }
        for (Post p : posts) {
            User postUser = dao.getUserByUserId(p.getUserId());
    %>
    <div class="col-md-6">
        <div class="card mb-3 box" style="height:20rem;">
            <div class="card-header">
                <h4 class="post-user-info">Posted by <span class="text-primary"><%= postUser.getName()%></span></h4>
            </div>
            <div class="card-body" style="overflow: hidden">

                <h5 class="card-title"><%= p.getpTitle()%></h5>

                <p class="card-text" style="overflow: hidden"><%= p.getpContent()%></p>
            </div>
            <div class="card-footer text-center primary-background">
                <%
                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                    CommentDao cd = new CommentDao(ConnectionProvider.getConnection());
                %>

                <div class="row">
                    <div class="col-md-6">
                        <a href="show_blog_page.jsp?post_id=<%= p.getpId()%>" class="btn btn-outline-light">Read More...</a>
                    </div>
                    <div class="col-md-6 d-flex align-items-center justify-content-end">
                        <div><i class="far fa-heart text-white ms-1"></i><span class="ms-1 text-white like-counter<%=p.getpId()%>"><%= ld.countLikeOnPost(p.getpId())%></span></div>
                        <div class="ms-3"><i class="far fa-comment text-white ms-"></i><span class="ms-1 text-white comment-counter<%=p.getpId()%>"><%= cd.countCommentOnPost(p.getpId())%></span></div>
                    </div>
                </div>
                <!--                
                                <a href="show_blog_page.jsp?post_id=<%= p.getpId()%>#interaction" class="btn btn-outline-light btn-small"><i class="far fa-heart"></i><span class="ms-1 like-counter<%=p.getpId()%>"><%= ld.countLikeOnPost(p.getpId())%></span></a>
                
                                <a href="show_blog_page.jsp?post_id=<%= p.getpId()%>#interaction" class="btn btn-outline-light btn-small"><i class="far fa-comment"></i><span class="ms-1 comment-counter<%=p.getpId()%>"><%= cd.countCommentOnPost(p.getpId())%></span></a>-->

            </div>
        </div>        

    </div>
    <%
        }


    %>
</div>
