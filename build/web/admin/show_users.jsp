<%-- 
    Document   : show_users
    Created on : 17 Sep, 2023, 11:12:28 AM
    Author     : vishal
--%>
<%@include file="../set_header.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.techvoyageblog.entities.User"%>
<%@page import="com.techvoyageblog.helper.ConnectionProvider"%>
<%@page import="com.techvoyageblog.dao.UserDAO"%>
<%@page import="com.techvoyageblog.entities.Message"%>
<%@page import="com.techvoyageblog.admin.Admin"%>
<%
    Admin admin = (Admin) session.getAttribute("admin");
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
            .banner-background{
                clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 90%, 61% 100%, 19% 91%, 0 100%, 0% 30%);
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Management</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="crossorigin="anonymous" referrerpolicy="no-referrer"></script>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
                integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
                integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>
        <script src="../js/myjs.js" type="text/javascript"></script>
    </head>
    <body>

        <%@include file="navbar.jsp" %>
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

        %>
        
        
        
        <%
            UserDAO ud = new UserDAO(ConnectionProvider.getConnection());
            List<User> userList = ud.getAllUser();

            if (userList.size() == 0) {
        %>
        <div class="alert alert-secondary text-center" role="alert">
            <h2>No users found in the database....</h2>
        </div>
        <%
                return;
            }
        %>
        <main>
            <div class="container-fluid p-0">
                <div class="row">
                    <div class="col-md-12">
                        <table class="table table-hover table-striped table-primary text-center">
                            <thead>
                                <tr class="table-primary">
                                    <th scope="col">#</th>
                                    <th scope="col">Email</th>
                                    <th scope="col">UserName</th>
                                    <th scope="col">No of Blogs posted</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Manage</th>
                                </tr>
                            </thead>
                            <tbody>

                                <%
                                    for (User user : userList) {

                                %>
                                <tr>
                                    <th scope="row"><%= user.getId()%></th>
                                    <td><%= user.getEmail()%></td>
                                    <td><%= user.getName()%></td>
                                    <td><%= user.getCountBlog()%></td>
                                    <td><%= user.getStatus()%></td>
                                    <td><button onclick="showUserDetails(<%= user.getId()%>)" class="btn btn-outline-secondary">More</button></td>
                                    <%
//If status is being changed from modal the page will be refreshed and any user who have currenlty loggedin,
// User object is stored in session, this session holding user type of object will have old status,
//we have to update it manually or it will be updated when user login again.
                                        User user1 = (User) session.getAttribute("currentUser");
                                        if (user1 != null && user1.getId() == user.getId()) {
                                            user1.setStatus(user.getStatus());
                                        }
                                    %>                                    
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                        <script>
                            function showUserDetails(id) {
//                                alert("hello");
                                const data = {
                                    userId: id
                                };
                                $.ajax({
                                    url: 'show_user_details.jsp',
                                    method: 'POST',
                                    data: data,
                                    success: function (data) {
                                        $('#show-user-details').html(data);
                                        $('#userDetailModal').modal('show');
                                    },
                                    error: function (error) {
//                                        console.error('Error fetching user data:', error);
                                    }
                                });
                            }
                        </script>
                    </div>
                </div>
            </div>
        </main>
                            
        <!--User Details model-->
        <div class="modal fade" id="userDetailModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" id="show-user-details">

                </div>
            </div>
        </div>
        <!--End of user detail model-->
        
    
    </body>
</html>
