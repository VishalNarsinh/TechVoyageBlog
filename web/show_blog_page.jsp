<%-- 
    Document   : show_blog_page
    Created on : 29 Aug, 2023, 3:26:35 PM
    Author     : vishal
--%>
<%@include file="set_header.jsp"%>
<%@page import="com.techvoyageblog.entities.Message"%>
<%@page import="java.util.List"%>
<%@page import="com.techvoyageblog.entities.Comment"%>
<%@page import="com.techvoyageblog.dao.CommentDao"%>
<%@page import="com.techvoyageblog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.techvoyageblog.dao.UserDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.techvoyageblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techvoyageblog.dao.CategoryDao"%>
<%@page import="com.techvoyageblog.helper.ConnectionProvider"%>
<%@page import="com.techvoyageblog.dao.PostDao"%>
<%@page import="com.techvoyageblog.entities.Post"%>
<%@page import="com.techvoyageblog.entities.User"%>
<%--<%@page errorPage="error_page.jsp" %>--%>
<%    User user = (User) session.getAttribute("currentUser");
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
<%
    int pId = Integer.parseInt(request.getParameter("post_id"));
    PostDao pd = new PostDao(ConnectionProvider.getConnection());
    Post post = pd.getPostByPostId(pId);
    if (post.getStatus().equals("inactive")) {
        response.sendRedirect("profile.jsp");
        return;
    }
    if (post == null) {
        response.sendRedirect("profile.jsp");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= post.getpTitle()%> || TechVoyageBlog</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
                integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
              rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="css/mystyle.css" rel="stylesheet" type="text/css" />
        <style>
            .banner-background{
                clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 90%, 61% 100%, 19% 91%, 0 100%, 0% 30%);
            }
            .main-theme{
                color: #fff;
                background-color: #9768D9;
            }
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 25px;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
                font-size: 20px;
            }
            .post-user-info{
                font-size: 20px;
            }
            .row-user{
                border:1px solid #e2e2e2;
                padding-top: 15px;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
            }
            .post-code{
                position: relative;
            }
            .post-link{
                text-decoration: none;
                font-weight: 300;
                font-size: 1.5rem;
                cursor: pointer;
            }


        </style>
    </head>

    <body>
        <!--navbar-->
        <%@include file="navbar.jsp" %>
        <!--End of navbar-->
        <%
            Message msg = (Message) session.getAttribute("msg");
            if (msg != null) {
        %>
        <div class="alert <%= msg.getCssClass()%>" role="alert">
            <%= msg.getContent()%>
        </div>

        <%
                session.removeAttribute("msg");
            }
        %>

        <!--Main content of body-->

        <div class="container">
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header main-theme">
                            <h4 class="post-title"><%= post.getpTitle()%></h4>
                        </div>
                        <div class="card-body">

                            <%if (!post.getpImage().equals("")) {%>
                            <img src="blog_imgs<%= File.separator%><%= post.getpImage()%>" class="card-img-top my-5">
                            <%} else {%>
                            <p class="post-content">No photo has been posted for this blog</p>
                            <%}%>

                            <div class="row my-3 row-user">
                                <div class="col-md-7">
                                    <%
                                        UserDAO dao = new UserDAO(ConnectionProvider.getConnection());
                                        User postUser = dao.getUserByUserId(post.getUserId());
                                    %>
                                    <p class="post-user-info"><a class="post-link" onclick="showUserDetails(<%= postUser.getId()%>)"><%= postUser.getName()%></a> has posted on : </p>
                                </div>

                                <script>
                                    function showUserDetails(id) {
//                                        alert("hello");
                                        const data = {
                                            userId: id
                                        };
                                        $.ajax({
                                            url: 'show_user_details.jsp',
                                            method: 'GET',
                                            data: data,
                                            success: function (data) {
                                                $('#show-user-details').html(data);
                                                $('#userDetailModal').modal('show');
                                            },
                                            error: function (error) {

                                            }
                                        });
                                    }
                                </script>
                                <div class="col-md-5">
                                    <p class="post-date"><%= DateFormat.getDateTimeInstance().format(post.getpDate())%></p>
                                </div>

                                <div class="col-md-7">
                                    <p class="post-user-info">Last edited on : </p>
                                </div>
                                <div class="col-md-5">
                                    <p class="post-date"><%= DateFormat.getDateTimeInstance().format(post.getpLastEdited())%></p>
                                </div>
                            </div>

                            <p class="post-content"><%= post.getpContent()%></p>
                            <%
                                if (!post.getpCode().equals("")) {
                            %>
                            <div style="position: relative">
                                <button id="copy-button" onclick="copyCode()" class="btn btn-outline-light btn-sm" style="position: absolute;top:10px;right:10px;">Copy</button>
                                <pre class="bg-dark text-white" id="code" style="font-size: 1.5rem;"><%= post.getpCode()%></pre>
                            </div>
                            <script>
                                function copyCode() {
                                    var codeElement = $("#code");
                                    var codeText = codeElement.text();

                                    var tempTextarea = $('<textarea>'); // Create a new textarea element
                                    tempTextarea.addClass('temp-textarea'); // Add the class to the textarea
                                    tempTextarea.val(codeText);
                                    $('body').append(tempTextarea);

                                    tempTextarea.select();
                                    tempTextarea[0].setSelectionRange(0, 99999); // For mobile devices

                                    document.execCommand('copy');

                                    tempTextarea.remove();

                                    var copyButton = $("#copy-button"); // Find the sibling button
                                    copyButton.text('Copied'); // Change the button text to "Copied"
                                    copyButton.prop('disabled', true); // Disable the button

                                    setTimeout(function () {
                                        copyButton.text('Copy'); // Reset the button text
                                        copyButton.prop('disabled', false); // Re-enable the button
                                    }, 3000); // Reset after 3 seconds
                                }
                            </script>
                            <%}%>
                            <%
                                if (!post.getpExternalLink().equals("")) {
                            %>
                            <a class="post-link" id="before-edit-link"><%= post.getpExternalLink()%></a>
                            <%
                                }
                            %>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-center main-theme" id="interaction">
                            <%
                                LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                                CommentDao cd = new CommentDao(ConnectionProvider.getConnection());
                            %>
                            <button onclick="doLike(<%=post.getpId()%>,<%= user.getId()%>)" class="btn btn-custom" id="like" style="display: none;"><i class="far fa-heart" style="color:white;"></i><span class="like-counter1"></span></button>
                            <button onclick="deleteLike(<%=post.getpId()%>,<%= user.getId()%>)" class="btn btn-custom" id="liked" style="display: none;"><i class="fas fa-heart"  style="color:red;"></i><span class="like-counter1"></span></button>
                            <button id="show-comment-btn" href="#!" class="btn ms-2 btn-custom btn-small"><i class="far fa-comment"></i><span class="ms-1" id="comment-counter"></span></button>
                            <script>
                                function loadLikesNo(post_id){
    const data = {
        post_id : post_id
    };
    $.ajax({
       url:'no_of_likes.jsp',
        data: data,
        success: function (data, textStatus, jqXHR) {
            $(".like-counter1").text(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(errorThrown);
        }
    });
}
                                function checkLike() {
                                    const uid = <%= user.getId()%>;
                                    const pid = <%= post.getpId()%>;
                                    const d = {
                                        uid: uid,
                                        pid: pid,
                                        operation: 'isLiked'
                                    };
                                    $.ajax({
                                        url: "LikeServlet",
                                        data: d,
                                        success: function (data, textStatus, jqXHR) {
//                                            console.log(data);
                                            if (data.trim() === 'true') {
                                                $("#like").hide();
                                                $("#liked").show();
                                            } else {
                                                $("#liked").hide();
                                                $("#like").show();
                                            }
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            console.log(jqXHR);
                                        }
                                    });
                                }
                                function doLike(pid, uid) {
                                    const d = {
                                        uid: uid,
                                        pid: pid,
                                        operation: 'like'
                                    }
                                    $.ajax({
                                        url: "LikeServlet",
                                        data: d,
                                        success: function (data, textStatus, jqXHR) {
//                                            console.log(data);
                                            if (data.trim() == 'true') {
                                                loadLikesNo(pid);
                                                checkLike();
                                            }
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            console.log(jqXHR);
                                        }
                                    });
                                }

                                function deleteLike(pid, uid) {
                                    const d = {
                                        uid: uid,
                                        pid: pid,
                                        operation: 'delete'
                                    }
                                    $.ajax({
                                        url: "LikeServlet",
                                        data: d,
                                        success: function (data, textStatus, jqXHR) {
//                                            console.log(data);
                                            if (data.trim() == 'true') {
                                                loadLikesNo(pid);
                                                checkLike();
                                            }
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            console.log(jqXHR);
                                        }
                                    });
                                }



                                $(document).ready(function () {
                                    checkLike();
                                    let flag = false;
                                    $("#show-comment-btn").on("click", function () {
                                        if (flag == true) {
                                            $("#comment-section").hide();
                                            flag = false;
                                        } else {
                                            $("#comment-section").show();
                                            flag = true;
                                        }
                                    });
                                });
                            </script>
                        </div>    
                        <div id="comment-section" style="display:none;">


                            <div class="card-footer">
                                <div class="row mt-2">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="flex-grow-1 overflow-hidden">
                                            <textarea rows="2" class="form-control" placeholder="Write your Comment here" id="comment-content"></textarea>
                                        </div>
                                        <div class="text-right">
                                            <button onclick="doComment(<%=post.getpId()%>,<%= user.getId()%>)" class="btn ms-2 btn-custom btn-small">Comment</button>
                                        </div>

                                    </div>

                                    <script>
                                        function doComment(pid, uid) {
                                            const d = {
                                                pid: pid,
                                                uid: uid,
                                                operation: 'doComment',
                                                content: document.getElementById("comment-content").value
                                            };
                                            if (/^\s*$/.test(d.content)) {
                                                swal("Comment must not be empty");
                                                return;
                                            }

                                            // Store the scroll position before refreshing
//                                            const scrollPosition = window.scrollY;
//                                            localStorage.setItem('scrollPosition', scrollPosition);

                                            $.ajax({
                                                url: "CommentServlet",
                                                data: d,
                                                success: function (data, textStatus, jqXHR) {
                                                    console.log(data);
                                                    if (data.trim() == 'true') {
                                                        loadCommentNo(<%=post.getpId()%>);
                                                        loadComments(<%=post.getpId()%>,<%= user.getId()%>);
                                                        let a = $("#comment-content");
                                                        a.val(""); // Clear the input field
                                                    }
                                                },
                                                error: function (jqXHR, textStatus, errorThrown) {
                                                    console.log(jqXHR);
                                                }
                                            });
                                        }


                                        $(document).ready(function () {
                                            loadLikesNo(<%=post.getpId()%>);
                                            loadCommentNo(<%=post.getpId()%>);
                                            loadComments(<%=post.getpId()%>,<%= user.getId()%>);
                                        });
                                    </script>

                                </div>

                            </div>
                            <div id="load-comments-here"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!--End of body-->





            
            <!--User Detail Modal-->
            <div class="modal fade" id="userDetailModal" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content" id="show-user-details">

                    </div>
                </div>
            </div>
            <!--End of user detail modal-->

            <!--javascript-->

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
