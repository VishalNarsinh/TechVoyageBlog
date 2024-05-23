<%-- 
    Document   : load_comments
    Created on : 6 Sep, 2023, 7:53:19 AM
    Author     : vishal
--%>
<%@include file="set_header.jsp" %>
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
    
    int pId = Integer.parseInt(request.getParameter("post_id"));
    int userId = Integer.parseInt(request.getParameter("user_id"));
    CommentDao cd = new CommentDao(ConnectionProvider.getConnection());
    List<Comment> comments = cd.getAllCommentsBypid(pId);
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
                    <div class="text-right">
                        <% if (userId == comment.getUid()) {%>
                        <button onclick="deleteComment(<%= comment.getCom_id()%>)" class="btn"><i class="text-danger fa-solid fa-trash"></i></button>
                        <script>
                            function deleteComment(com_id) {
                                const d = {
                                    com_id: com_id,
                                    operation: 'deleteComment'
                                };

                                $.ajax({
                                    url: "CommentServlet",
                                    data: d,
                                    success: function (data, textStatus, jqXHR) {
                                        console.log(data);
                                        if (data.trim() == 'true') {
                                            loadCommentNo(<%= pId%>);
                                            loadComments(<%= pId%>,<%= userId%>);
                                        }
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        console.log(jqXHR);
                                    }
                                });
                            }
                        </script>
                        <% } %>
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
