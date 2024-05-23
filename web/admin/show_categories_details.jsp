<%-- 
    Document   : show_categories_details
    Created on : 18 Sep, 2023, 1:16:49 PM
    Author     : vishal
--%>
<%@include file="../set_header.jsp"%>
<%@page import="com.techvoyageblog.admin.Admin"%>
<%@page import="com.techvoyageblog.entities.Message"%>
<%@page import="com.techvoyageblog.entities.Category"%>
<%@page import="com.techvoyageblog.helper.ConnectionProvider"%>
<%@page import="com.techvoyageblog.dao.CategoryDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        Message msg1 = new Message("You have to Login first", "error", "alert-danger");
        session.setAttribute("msgAdminSide", msg1);
        response.sendRedirect("admin_login.jsp");
        return;
    }
    int cid = Integer.parseInt(request.getParameter("cid"));
    CategoryDao cd = new CategoryDao(ConnectionProvider.getConnection());
    Category category = cd.getCategoryBycid(cid);
    if (category == null) {
        response.sendRedirect("show_categories.jsp");
        return;
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Category Details</title>
        <style>
            .banner-background{
                clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 90%, 61% 100%, 19% 91%, 0 100%, 0% 30%);
            }
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
              rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="../css/mystyle.css" rel="stylesheet" type="text/css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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

        %>
        <main>
            <div class="container mt-5">
                <div class="row">
                    <div class="col-md-8 offset-md-2">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="mt-2">You can edit Category details here</h3> 
                            </div>
                            <div class="card-body">
                                <div id="category-edit">
                                    
                                    <form action="../CategoryEdit" id="cat-edit-form" method="post" autocomplete="off">
                                        <table class="table">
                                            <tr>
                                                <th>ID</th>
                                                <td>
                                                    <%= category.getCid()%>
                                                    <input type="hidden" name="cid" value="<%= category.getCid()%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Enter Name</th>
                                                <td><input type="text" name="name" id="catName" value="<%= category.getName()%>" class="form-control"></td>
                                            </tr>
                                            <tr>
                                                <th>Enter Description</th>
                                                <td><textarea rows="4" name="description" id="desc" class="form-control"><%= category.getDescription()%></textarea></td>
                                            </tr>
                                        </table>

                                </div>
                                <div class="card-footer mt-3 d-flex justify-content-around">
                                    <button type="submit" class="btn btn-custom" id="edit-category-btn">Save Changes</button>
                                    <a id="delete-category-btn" href="../CategoryEdit?operation=delete&cId=<%= category.getCid()%>" class="btn btn-custom" onclick="deleteCategory()">Delete</a>
                                </div>
                                </form>
                            </div>
                        </div>

                    </div>
                </div>
        </main>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="../js/myjs.js" type="text/javascript"></script>


        <script>
            $("#delete-category-btn").on('click', function () {
                event.preventDefault();
                swal({
                    title: "Are you sure?",
                    text: "Do you want to delete this post?",
                    icon: "warning",
                    buttons: {
                        cancel: "Cancel",
                        confirm: "Confirm",
                    },
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                window.location.href = $(this).attr('href');
                            } else {
                            }
                        });
            });
            
          
        </script>
    </body>
</html>
