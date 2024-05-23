<%@page import="com.techvoyageblog.helper.ConnectionProvider"%>
<%@page import="com.techvoyageblog.dao.LikeDao"%>
<%@include file="set_header.jsp"%>
<%
    int post_id = Integer.parseInt(request.getParameter("post_id"));
    LikeDao ldo = new LikeDao(ConnectionProvider.getConnection());
    
%>
<%= ldo.countLikeOnPost(post_id)%>