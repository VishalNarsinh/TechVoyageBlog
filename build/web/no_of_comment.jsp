<%@include file="set_header.jsp"%>
<%@page import="com.techvoyageblog.helper.ConnectionProvider"%>
<%@page import="com.techvoyageblog.dao.CommentDao"%>
<%
    int pId = Integer.parseInt(request.getParameter("post_id"));
    CommentDao cd1 = new CommentDao(ConnectionProvider.getConnection());
%>
<%= cd1.countCommentOnPost(pId)%>