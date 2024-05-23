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
    <%
        //    Thread.sleep(500);
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect("login_page.jsp");
        }
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
                <p class="card-text" style="height:22rem;overflow: hidden"><%= p.getpContent()%></p>
                <%
                    }
                %>
            </div>
            <div class="card-footer text-center primary-background">
                <%
                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                    CommentDao cd = new CommentDao(ConnectionProvider.getConnection());
                %>
                <a href="show_blog_page.jsp?post_id=<%= p.getpId()%>" class="btn btn-outline-light">Read More...</a>
                <a href="show_blog_page.jsp?post_id=<%= p.getpId()%>#interaction" class="btn btn-outline-light"><i class="far fa-heart"></i><span class="ms-1 like-counter<%=p.getpId()%>"><%= ld.countLikeOnPost(p.getpId())%></span></a>

                <a href="show_blog_page.jsp?post_id=<%= p.getpId()%>#interaction" class="btn btn-outline-light"><i class="far fa-comment"></i><span class="ms-1 comment-counter<%=p.getpId()%>"><%= cd.countCommentOnPost(p.getpId())%></span></a>

            </div>
        </div>        

    </div>
    <%
        }


    %>
</div>