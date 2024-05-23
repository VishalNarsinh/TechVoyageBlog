<%-- 
    Document   : show_queries
    Created on : 14 Oct, 2023, 9:58:57 AM
    Author     : vishal
--%>

<%@page import="com.techvoyageblog.helper.ConnectionProvider"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.techvoyageblog.entities.ContactMessage"%>
<%@page import="java.util.List"%>
<%@page import="com.techvoyageblog.entities.Message"%>
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
<%@page import="com.techvoyageblog.dao.MessageDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Queries</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
              rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="../css/mystyle.css" rel="stylesheet" type="text/css" />
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

        %>



        <%            MessageDao dao = new MessageDao(ConnectionProvider.getConnection());
            List<ContactMessage> list = dao.getAllMessages();
            if (list.size() == 0) {
        %>
        <div class="alert alert-success" role="alert">
            There is no query yet
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
                                <div class="row">
                                    <div class="col-11">
                                        <h6 class="title"><%=message.getSubject()%></h6>        
                                    </div>
                                    <div class="col-1 d-flex justify-content-center align-items-center">
                                        <button onclick="reply('<%=message.getEmail()%>', '<%=message.getSubject()%>')" data-bs-toggle="modal" data-bs-target="#replyModal" class="btn btn-custom">Reply</button>
                                    </div>
                                </div>


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

        <!--Add Category modal-->

        <!-- Modal -->
        <div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white text-center">
                        <h5 class="modal-title" id="exampleModalLabel">TechVoageBlog</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                        <div class="card">
                            <div class="card-header"><h3>Write your response</h3></div>
                            <div class="card-body">
                                <form autocomplete="off" action="../SendResponseToQuery" method="post" id="response-form">
                                    <table class="table">
                                        <tr>
                                            <th>Email</th>
                                            <td><input type="text" id="email" name="email" class="form-control" required></td>
                                        </tr>
                                        <tr>
                                            <th>Subject</th>
                                            <td><input type="text" id="subject" name="subject" class="form-control" required></td>
                                        </tr>
                                        <tr>
                                            <th>Enter Response</th>
                                            <td><textarea rows="4" name="response" id="response" class="form-control"></textarea></td>
                                        </tr>
                                    </table>
                                    <div class="container text-center">
                                        <button type="submit" id="send-response-btn" class="btn btn-custom">Send</button>
                                        <div class="container text-center" id="loader" style="display:none">  
                                            <span class="fa fa-refresh fa-spin fa-3x"></span>
                                            <h4>Please wait</h4>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!--end of Add Category modal-->





        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
                integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
                integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="../js/myjs.js" type="text/javascript"></script>
        <script>
                                            function reply(email, subject) {
                                                let emailTextBox = $("#email");
                                                emailTextBox.val(email);
                                                let subjectTextBox = $("#subject");
                                                subjectTextBox.val("Reply to your query '" + subject + "'");

                                            }
        </script>
        <script>
            $(document).ready(function () {
                $("#response-form").on('submit', function () {
                    event.preventDefault();
                    let submitBtn = $("#send-response-btn");
                    let loader = $("#loader");
                    submitBtn.hide();
                    loader.show();
                    const data = {
                        email: $("#email").val(),
                        subject: $("#subject").val(),
                        text: $("#response").val()
                    };
                    $.ajax({
                        url: '../SendResponseToQuery',
                        data: data,
                        method: 'POST',
                        success: function (data, textStatus, jqXHR) {

                            if (data.trim() == 'true') {
                                swal("Good job!", "Response sent successfully!", "success");
                                submitBtn.show();
                                loader.hide();
                                $('#replyModal').modal('hide');
                                $("#response-form")[0].reset();
                            } else {
                                swal("Sorry", "Can't send resposne!", "error");
                                submitBtn.show();
                                loader.hide();
//                                 $('#replyModal').modal('hide');

                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {

                        }
                    });
                });
            });
        </script>
    </body>
</html>

