<%-- 
    Document   : show_past_messages
    Created on : 11 Oct, 2023, 10:47:15 AM
    Author     : vishal
--%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.techvoyageblog.entities.ContactMessage"%>
<%@page import="java.util.List"%>
<%@page import="com.techvoyageblog.entities.Message"%>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        Message msg1 = new Message("You have to Login first", "error", "alert-danger");
        session.setAttribute("msgUserSide", msg1);

        String originalReferer = request.getRequestURL().toString();
        String queryString = request.getQueryString();
        if (queryString != null && !queryString.isEmpty()) {
            originalReferer += "?" + queryString;
        }
        session.setAttribute("originalReferer", originalReferer);
        response.sendRedirect("login_page.jsp");
        return;
    } else {
        session.removeAttribute("originalReferer");
    }
%>
<%@page import="com.techvoyageblog.dao.MessageDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Past Queries</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
              rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="css/mystyle.css" rel="stylesheet" type="text/css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
                integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <style>
            .title{
                font-size: 2rem;
                font-weight: 400;
                letter-spacing: 2px;
            }
            .content{
                font-size:1.5rem;
            }
        </style>
    </head>
    <body>
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

        
        
        <%
            MessageDao dao = new MessageDao(ConnectionProvider.getConnection());
            List<ContactMessage> list = dao.getMessagesByEmail(user.getEmail());
            if (list.size() == 0) {
        %>
        <div class="alert alert-success" role="alert">
            Hello <%=user.getName()%>, you haven't contact us yet. If you have any query feel free to contact us 
        </div>
        <%
            }
        %>
        <main>
            <div class="container">
                <div class="row">
                    <%
                        for (ContactMessage message : list) {
                    %>
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h6 class="title"><%=message.getSubject()%></h6>
                            </div>
                            <div class="card-body content">
                                <%=message.getContent().replaceAll("\n", "<br>")%>
                            </div>
                            <div class="text-end me-3">
                                <p><%=DateFormat.getDateTimeInstance().format(message.getTime())%></p>
                            </div>
                        </div> 
                    </div>
                    <%
                        }
                    %>

                </div>
            </div>
        </main>







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
