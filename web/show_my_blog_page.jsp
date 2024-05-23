<%-- 
    Document   : show_blog_page
    Created on : 31 Aug, 2023, 07:08:35 PM
    Author     : vishal
--%>
<%@page import="com.techvoyageblog.entities.Message"%>
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
<%@page errorPage="error_500.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        Message msg = new Message("You need to Login first", "error", "alert-danger");
        session.setAttribute("msgUserSide", msg);
        response.sendRedirect("login_page.jsp");
        return;
    }
%>
<%
    int pId = Integer.parseInt(request.getParameter("post_id"));
    PostDao pd = new PostDao(ConnectionProvider.getConnection());
    Post post = pd.getPostByPostId(pId);
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
        <title>Edit your blog here</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
                integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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

            .post-link{
                text-decoration: none;
                font-weight: 300;
                font-size: 1.5rem;
                cursor: pointer;
            }

        </style>
        <script>
            // Restore the scroll position when the page loads
            window.addEventListener('load', function () {
                var savedScrollPosition = localStorage.getItem('scrollPosition');
                if (savedScrollPosition !== null) {
                    window.scrollTo(0, savedScrollPosition);
                    localStorage.removeItem('scrollPosition'); // Remove the stored position
                }
            });
     

        </script>
    </head>
    <body>
        <!--navbar-->
        <%@include file="navbar.jsp" %>
        <!--End of navbar-->

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

            if (post.getStatus().equals("inactive")) {

        %>
        <div class="alert alert-danger" role="alert">
            Hello <%=user.getName()%>, your post has been set INACTIVE by the admin because it may contain false or misleading information. It cannot be accessed at the moment by everyone. Please update it and we will review your post, if it is good to go we will definitely set it ACTIVE so everyone can see this post.
        </div>
        <%
            }

        %>
        <!--Main content of body-->
        <form class="form">
            <div class="container">
                <div class="row my-4">
                    <div class="col-md-8 offset-md-2">
                        <div class="card">
                            <div class="card-header main-theme">
                                <div class="row" style="position: relative;">
                                    <script>
                                        function updateTitle(event) {
                                            let textOfButton = $("#change-control-heading").text();
                                            if (textOfButton == 'Edit') {
                                                $("#before-edit-heading").hide();
                                                $("#after-edit-heading").show();
                                                $("#change-control-heading").text("Update");

                                            } else {
                                                let pTitle = document.getElementById("after-edit-heading").value;
                                                //                                               console.log(pTitle);
                                                const data = {
                                                    operation: 'editTitle',
                                                    pId: <%= post.getpId()%>,
                                                    pTitle: pTitle
                                                };

                                                $.ajax({
                                                    url: "EditBlog",
                                                    data: data,
                                                    success: function (data, textStatus, jqXHR) {
                                                        console.log(data);

                                                        if (data.trim() == 'true') {
                                                            localStorage.setItem('scrollPosition', window.scrollY);
                                                            location.reload();
                                                        } else {
                                                            swal("Error!", "Something went wrong try again!!!", "error");
                                                        }
                                                    }
                                                });
                                                $("#before-edit-heading").show();
                                                $("#after-edit-heading").hide();
                                                $("#change-control-heading").text("Edit");
                                            }
                                        }
                                    </script>
                                    <div class="col-md-10">
                                        <h4 class="post-title" id="before-edit-heading"><%= post.getpTitle()%></h4>
                                        <input class="form-control form-control-lg" id="after-edit-heading" value="<%= post.getpTitle()%>" style="display: none;">
                                    </div>
                                    <div class="col-md-2">
                                        <button id="change-control-heading" type="button" onclick="updateTitle()" class="btn btn-custom" style="position: absolute; top: 5px; right: 10px;">Edit</button>
                                    </div>
                                </div>

                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <% if (!post.getpImage().equals("")) {%>
                                    <img id="" src="blog_imgs<%= File.separator%><%= post.getpImage()%>" class="card-img-top my-5">
                                    <% } else { %>
                                    <p class="post-content" id="before-edit-image">You haven't posted any photo for this blog</p>
                                    <% }%>
                                    <input type="file" class="form-control mb-3 form-control-lg" id="after-edit-image" value="<%= post.getpImage()%>" style="display: none;">
                                    <button id="change-control-image" type="button" onclick="updateImage()" class="btn btn-custom" style="">Edit Image</button>
                                    <script>

                                        function isValidImageType(fileType) {
                                            // Define the list of valid image MIME types
                                            const validImageTypes = ["image/jpeg", "image/png", "image/gif", "image/jpeg", "image/webp"];

                                            // Check if the fileType is in the list of valid image types
                                            return validImageTypes.includes(fileType);
                                        }
                                        function updateImage() {
                                            let textOfButton = $("#change-control-image").text();
                                            if (textOfButton == 'Edit Image') {
                                                $("#before-edit-image").hide();
                                                $("#after-edit-image").show();
                                                $("#change-control-image").text("Update");
                                            } else if (textOfButton == 'Update') {
                                                const imageInput = document.getElementById("after-edit-image");
                                                if (imageInput.files.length === 0) {
                                                    console.log("Not image");
                                                    swal("Please select an image to upload.");
                                                    return;
                                                }
                                                const selectedFile = imageInput.files[0];
                                                // Check if the selected file is an image based on its file type
                                                if (isValidImageType(selectedFile.type)) {
                                                    // It's an image; proceed with the upload
                                                    const formData = new FormData();
                                                    formData.append("pImage", selectedFile);
                                                    formData.append("operation", "editImage"); // You can add other data as needed
                                                    formData.append("pId", <%= post.getpId()%>)
                                                    // Send the image data to the server using Ajax
                                                    $.ajax({
                                                        url: "EditBlog", // Update with your server endpoint
                                                        type: "POST",
                                                        data: formData,
                                                        processData: false, // Prevent jQuery from processing the data
                                                        contentType: false, // Set the content type to false for multipart/form-data
                                                        success: function (response) {
                                                            // Handle the server response here
                                                            console.log(response);
                                                            if (response.trim() == 'true') {
                                                                localStorage.setItem('scrollPosition', window.scrollY);
                                                                location.reload();
                                                            } else {
                                                                swal("Error!", "Upload successful, but not a valid image!", "error");
                                                            }
                                                        },
                                                        error: function (error) {
                                                            // Handle errors here
                                                            console.error("Error uploading image:", error);
                                                        }
                                                    });
                                                } else {
                                                    // It's not an image; display an error message
                                                    swal("Please select a valid image file.");
                                                }
                                                $("#before-edit-heading").show();
                                                $("#after-edit-image").hide();
                                                $("#change-control-image").text("Edit Image");
                                            }
                                        }



                                    </script>

                                </div>

                                <div class="row my-3 row-user">
                                    <div class="col-md-7">
                                        <%
                                            UserDAO dao = new UserDAO(ConnectionProvider.getConnection());
                                            User postUser = dao.getUserByUserId(post.getUserId());
                                        %>
                                        <p class="post-user-info">Posted on :</p>
                                    </div>
                                    <div class="col-md-5">
                                        <p class="post-date"><%= DateFormat.getDateTimeInstance().format(post.getpDate())%></p>
                                    </div>
                                </div>
                                <div class="row" style="position: relative;">
                                    <script>
                                        function updateContent() {
                                            let textOfButton = $("#change-control-content").text();
                                            if (textOfButton == 'Edit') {
                                                $("#before-edit-content").hide();
                                                $("#after-edit-content").show();
                                                $("#change-control-content").text("Update");
                                            } else {
                                                let pContent = document.getElementById("after-edit-content").value;

                                                //                                               console.log(pTitle);
                                                const data = {
                                                    operation: 'editContent',
                                                    pId: <%= post.getpId()%>,
                                                    pContent: pContent
                                                };

                                                $.ajax({
                                                    url: "EditBlog",
                                                    data: data,
                                                    success: function (data, textStatus, jqXHR) {
                                                        console.log(data);

                                                        if (data.trim() == 'true') {
                                                            localStorage.setItem('scrollPosition', window.scrollY);
                                                            location.reload();
                                                        } else {
                                                            swal("Error!", "Something went wrong try again!!!", "error");
                                                        }
                                                    }
                                                });
                                                $("#before-edit-content").show();
                                                $("#after-edit-content").hide();
                                                $("#change-control-content").text("Edit");
                                            }
                                        }

                                    </script>
                                    <div class="col-md-11">
                                        <p class="post-content" id="before-edit-content"><%= post.getpContent()%></p>
                                        <textarea rows="50" class="form-control" id="after-edit-content" style="display: none;width: 98% "><%= post.getpContent().replaceAll("<br>", "\n")%></textarea>
                                    </div>
                                    <div class="col-md-1">
                                        <button id="change-control-content" type="button" onclick="updateContent()" class="btn btn-custom" style="position: absolute; top: 5px; right: 10px;">Edit</button>
                                    </div>
                                </div>


                                <div class="row mb-1" style="position: relative">

                                    <script>
                                        function updateCode(event) {
                                            let textOfButton = $("#change-control-code").text();
                                            if (textOfButton == 'Edit') {
                                                $("#before-edit-code").hide();
                                                $("#after-edit-code").show();
                                                $("#change-control-code").text("Update");
                                            } else {
                                                let pCode = document.getElementById("after-edit-code").value;
                                                //                                               console.log(pTitle);
                                                const data = {
                                                    operation: 'editCode',
                                                    pId: <%= post.getpId()%>,
                                                    pCode: pCode
                                                };

                                                $.ajax({
                                                    url: "EditBlog",
                                                    data: data,
                                                    success: function (data, textStatus, jqXHR) {
                                                        console.log(data);

                                                        if (data.trim() == 'true') {
                                                            localStorage.setItem('scrollPosition', window.scrollY);
                                                            location.reload();
                                                        } else {
                                                            swal("Error!", "Something went wrong try again!!!", "error");
                                                        }
                                                    }
                                                });
                                                $("#before-edit-code").show();
                                                $("#after-edit-code").hide();
                                                $("#change-control-code").text("Edit");
                                            }
                                        }

                                    </script>

                                    <div class="col-md-11">
                                        <%
                                            if (!post.getpCode().equals("")) {
                                        %>
                                        <pre class="bg-dark text-white" id="before-edit-code" style="font-size: 1.5rem;"><%= post.getpCode()%></pre>
                                        <%
                                        } else {
                                        %>
                                        <p class="post-content" id="before-edit-code">You haven't posted code for this post</p>
                                        <%  }
                                        %>
                                        <textarea rows="50" class="form-control" id="after-edit-code" style="display: none;width: 98%;background: black;color: white;font-size: 1.5rem; "><%= post.getpCode()%></textarea>


                                        <script>
                                            document.getElementById('after-edit-code').addEventListener('keydown', function (event) {
                                                if (event.key === "Tab") {
                                                    event.preventDefault(); // Prevent default Tab behavior

                                                    // Insert a tab character at the current cursor position
                                                    var textarea = event.target;
                                                    var start = textarea.selectionStart;
                                                    var end = textarea.selectionEnd;

                                                    // Add the tab character at the cursor position
                                                    var tabCharacter = "\t";
                                                    textarea.value = textarea.value.substring(0, start) + tabCharacter + textarea.value.substring(end);

                                                    // Move the cursor position after the inserted tab
                                                    textarea.selectionStart = textarea.selectionEnd = start + tabCharacter.length;
                                                }
                                            });
                                        </script>

                                    </div>
                                    <div class="col-md-1">
                                        <button id="change-control-code" type="button" onclick="updateCode()" class="btn btn-custom" style="position: absolute; top: 5px; right: 10px;">Edit</button>
                                    </div>
                                </div>


                                <div class="row" style="position: relative">

                                    <script>
                                        function updateLink(event) {
                                            let textOfButton = $("#change-control-link").text();
                                            if (textOfButton == 'Edit') {
                                                $("#before-edit-link").hide();
                                                $("#after-edit-link").show();
                                                $("#change-control-link").text("Update");
                                            } else {
                                                let pExternalLink = document.getElementById("after-edit-link").value;
                                                //                                               console.log(pExternalLink);
                                                const data = {
                                                    operation: 'editLink',
                                                    pId: <%= post.getpId()%>,
                                                    pExternalLink: pExternalLink
                                                };

                                                $.ajax({
                                                    url: "EditBlog",
                                                    data: data,
                                                    success: function (data, textStatus, jqXHR) {
                                                        console.log(data);

                                                        if (data.trim() == 'true') {
                                                            localStorage.setItem('scrollPosition', window.scrollY);
                                                            location.reload();
                                                        } else {
                                                            swal("Error!", "Something went wrong try again!!!", "error");
                                                        }
                                                    }
                                                });
                                                $("#before-edit-link").show();
                                                $("#after-edit-link").hide();
                                                $("#change-control-link").text("Edit");
                                            }
                                        }

                                    </script>

                                    <div class="col-md-10">
                                        <%
                                            if (!post.getpExternalLink().equals("")) {
                                        %>
                                        <a class="post-link" id="before-edit-link" href="<%= post.getpExternalLink()%>"><%= post.getpExternalLink()%></a>

                                        <%
                                        } else {
                                        %>
                                        <p class="post-content" id="before-edit-link">You haven't posted External Link for this post</p>
                                        <%  }
                                        %>
                                        <input class="form-control form-control-lg" id="after-edit-link" value="<%= post.getpExternalLink()%>" style="display: none;">
                                    </div>
                                    <div class="col-md-2">
                                        <button id="change-control-link" type="button" onclick="updateLink()" class="btn btn-custom" style="position: absolute; top: 5px; right: 10px;">Edit</button>
                                    </div>
                                </div>


                            </div>

                            <div class="card-footer d-flex align-items-center justify-content-center main-theme">
                                <%
                                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                                %>
                                <button type="button" id="show-comment-btn" href="#!" class="btn ms-2 btn-custom btn-small"><i class="far fa-comment"></i><span class="ms-1" id="comment-counter"></span></button>
                                <a id="delete-post-btn" href="DeleteBlog?pId=<%= post.getpId()%>" class="btn ms-2 btn-outline-danger btn-small text-white" style="border-color:  white"><i class="fas fa-trash me-1"></i><span class="text-white">Delete</span></a>

                            </div>
                            <script>

                                $(document).ready(function () {
                                    manageComments(<%= post.getpId()%>);
                                    loadCommentNo(<%= post.getpId()%>);
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
                            <div id="comment-section" style="display:none;">
                                <div id="load-comments-here"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>                                 

        <!--End of body-->



        <!--javascript-->

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
                integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
                integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="js/myjs.js" type="text/javascript"></script>


        <script>
                                $("#delete-post-btn").on('click', function () {
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
