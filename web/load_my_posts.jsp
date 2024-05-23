<%@include file="set_header.jsp"%>
<%@page import="com.techvoyageblog.dao.CommentDao"%>
<%@page import="com.techvoyageblog.entities.User"%>
<%@page import="com.techvoyageblog.dao.LikeDao"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="com.techvoyageblog.entities.Post"%>
<%@page import="com.techvoyageblog.helper.ConnectionProvider"%>
<%@page import="com.techvoyageblog.dao.PostDao"%>
<div class="row">
    <%        User user = (User) session.getAttribute("currentUser");
        int userId = Integer.parseInt(request.getParameter("uid"));
        PostDao pd = new PostDao(ConnectionProvider.getConnection());
        List<Post> posts = null;
        posts = pd.getAllPostsByUId(userId);
        if (posts.size() == 0) {
    %>
    <div class="alert alert-secondary text-center" role="alert">
        <h2 class="display-4">You haven't posted anything yet...</h2>
    </div>
    <%
            return;
        }
        for (Post p : posts) {
    %>
    <div class="col-md-6">
        <div class="card mb-3 box" style="height:22rem;">
            <div class="card-body" style="overflow: hidden">
                <h5 class="card-title"><%= p.getpTitle()%></h5>
                <%
                    if (!p.getpImage().equals("")) {
                %>
                <img src="blog_imgs<%= File.separator%><%= p.getpImage()%>" class="card-img-top image-fluid" alt="not found" style="max-height: 50%;">
                <p class="card-text" style="overflow: hidden"><%= p.getpContent()%></p>

                <%
                } else {
                %>
                <p class="card-text" style="max-height:50rem;overflow: hidden"><%= p.getpContent()%></p>
                <%
                    }
                %>
            </div>
            <div class="card-footer text-center primary-background">
                <%
                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                    CommentDao cd = new CommentDao(ConnectionProvider.getConnection());
                %>
                <div class="row">
                    <div class="col-md-4">
                        <a href="show_my_blog_page.jsp?post_id=<%= p.getpId()%>" class="btn btn-outline-light">Edit</a>
                    </div>
                    <div class="col-md-8 d-flex align-items-center justify-content-end">
                        <div><i class="far fa-heart text-white ms-1"></i><span class="ms-1 text-white"><%= ld.countLikeOnPost(p.getpId())%></span></div>
                        <div class="ms-3"><i class="far fa-comment text-white ms-"></i><span class="ms-1 text-white"><%= cd.countCommentOnPost(p.getpId())%></span></div>
                    </div>
                </div>
            </div>
        </div>        

    </div>
    <%
        }


    %>
</div>