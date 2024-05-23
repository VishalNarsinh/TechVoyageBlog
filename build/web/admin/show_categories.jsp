<%-- 
    Document   : show_categroies
    Created on : 17 Sep, 2023, 11:12:28 AM
    Author     : vishal
--%>
<%@include file="../set_header.jsp"%>
<%@page import="com.techvoyageblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techvoyageblog.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.techvoyageblog.entities.User"%>
<%@page import="com.techvoyageblog.helper.ConnectionProvider"%>
<%@page import="com.techvoyageblog.dao.UserDAO"%>
<%@page import="com.techvoyageblog.entities.Message"%>
<%@page import="com.techvoyageblog.admin.Admin"%>
<%    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        Message msg1 = new Message("You have to Login first", "error", "alert-danger");
        session.setAttribute("msgAdminSide", msg1);
        String originalRefererAdminSide = request.getRequestURL().toString();
        String queryString = request.getQueryString();
        if (queryString != null && !queryString.isEmpty()) {
            originalRefererAdminSide += "?" + queryString;
        }
        session.setAttribute("originalRefererAdminSide", originalRefererAdminSide);
        response.sendRedirect("admin_login.jsp");
        return;
    } else {
        session.removeAttribute("originalRefererAdminSide");
    }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
              rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="../css/mystyle.css" rel="stylesheet" type="text/css" />
        <style>
            *{
                margin:0px;
                padding: 0px;
                box-sizing: border-box;
            }
            .banner-background{
                clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 90%, 61% 100%, 19% 91%, 0 100%, 0% 30%);
            }
            main{
                /*margin-top: 100px;*/
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Category Management</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="crossorigin="anonymous" referrerpolicy="no-referrer"></script>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
                integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
                integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>
    </head>
    <body>

        <!--navbar-->
        <%@include file="navbar.jsp" %>
        <!--End of navbar-->
        <%
            Message msg = (Message) session.getAttribute("msgAdminSide");
            if (msg != null) {
        %>
        <div class="mb-0 alert <%= msg.getCssClass()%>" role="alert">
            <%= msg.getContent()%>
        </div>

        <%
                session.removeAttribute("msgAdminSide");
            }
            CategoryDao cd = new CategoryDao(ConnectionProvider.getConnection());
            ArrayList<Category> catgories = cd.getAllCategories();
            if (catgories.size() == 0) {
        %>
        <div class="alert alert-secondary text-center" role="alert">
            <h2>No categories found.</h2>
        </div>
        <%}%>
        <main>
            <div class="container mt-5">
                <div class="row">


                    <%      if (catgories.size() == 0) {
                            return;
                        }
                        for (Category category : catgories) {
                    %>
                    <div class="col-md-4 mb-3">
                        <div class="card" style="max-height:30vh;">
                            <div class="card-body p-0 overflow-hidden">
                                <table class="table table-primary mb-0">
                                    <tbody>
                                        <tr class="table-primary">
                                            <th scope="row">Category ID</th>
                                            <td><%=category.getCid()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Name</th>
                                            <td><%=category.getName()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Description</th>
                                            <td><%=category.getDescription()%></td>
                                        </tr>
                                    </tbody>
                                </table>

                            </div>
                            <div class="card-footer primary-background text-center">
                                <a href="show_categories_details.jsp?cid=<%=category.getCid()%>" class="btn btn-outline-light">Edit</a>
                            </div>
                        </div>
                    </div>
                    <%}%>

                </div>
            </div>
        </main>

      



       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="../js/myjs.js" type="text/javascript"></script>
    </body>
</html>
