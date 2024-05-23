<%-- 
    Document   : load_comments
    Created on : 16 Sep, 2023, 3:57:44 PM
    Author     : vishal
--%>

<%@include file="../set_header.jsp"%>
<%@page import="com.techvoyageblog.entities.User"%>
<%@page import="com.techvoyageblog.entities.Post"%>
<%@page import="com.techvoyageblog.dao.PostDao"%>
<%@page import="com.techvoyageblog.dao.CommentDao"%>
<%@page import="com.techvoyageblog.helper.ConnectionProvider"%>
<%@page import="com.techvoyageblog.dao.UserDAO"%>
<%@page import="com.techvoyageblog.entities.Comment"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//    User userx = (User) session.getAttribute("currentUser");
//    if (userx == null) {
//        response.sendRedirect("login_page.jsp");
//        return;
//    }
    int pId = Integer.parseInt(request.getParameter("post_id"));
    PostDao pd1 = new PostDao(ConnectionProvider.getConnection());
    Post post1 = pd1.getPostByPostId(pId);
    CommentDao cd = new CommentDao(ConnectionProvider.getConnection());
    List<Comment> comments = cd.getAllCommentsBypid(post1.getpId());
    if (comments.size() == 0) {
%>
<p class="post-content m-3">No comments yet</p>
<%
} else {
    for (Comment comment : comments) {
%>
<div class="container">
    <%
        UserDAO ud = new UserDAO(ConnectionProvider.getConnection());
    %>
    <div class="row my-2">
        <div class="card">
            <div class="card-body pe-0">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="flex-grow-1 overflow-hidden">
                        <%= ud.getUserNameByid(comment.getUid())%> : <%= comment.getContent().replaceAll("\n", "<br>")%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
        }
    }
%>
