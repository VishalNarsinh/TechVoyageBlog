<%-- 
    Document   : search_blog
    Created on : 5 Sep, 2023, 11:15:01 AM
    Author     : vishal
--%>
<%@include file="../set_header.jsp"%>
<%@page import="com.techvoyageblog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.techvoyageblog.helper.ConnectionProvider"%>
<%@page import="com.techvoyageblog.dao.PostDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <div class="list-group">
            <%
                String input = request.getParameter("pTitle");
                PostDao dao1 = new PostDao(ConnectionProvider.getConnection());
                List<Post> list2 = dao1.findBypTitleContaining(input);
                if(list2.size()==0){
                    out.print("No results found");
                }
                for (Post postByTitle : list2) {

            %>
            <a href="show_blog_page.jsp?post_id=<%= postByTitle.getpId()%>" class="list-group-item list-group-action"><%= postByTitle.getpTitle()%></a>
            <%}%>
        </div>