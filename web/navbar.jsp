<%@page import="com.techvoyageblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techvoyageblog.helper.ConnectionProvider"%>
<%@page import="com.techvoyageblog.dao.CategoryDao"%>
<%@page import="java.io.File"%>
<%@include file="set_header.jsp"%>
<%@page import="com.techvoyageblog.admin.Admin"%>
<%@page import="com.techvoyageblog.entities.User"%>
<%    User user1 = (User) session.getAttribute("currentUser");
%>
<head>
    <meta charset="UTF-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <style>
        #modalAddPost {
            max-width: 50vw;
            margin: 2rem auto;
        }
        .search-result::-webkit-scrollbar {
            width: 8px; /* Adjust the width as needed */
        }

        .search-result::-webkit-scrollbar-thumb {
            background-color: transparent; /* Should match the background color */
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<nav class="navbar navbar-expand-lg navbar-dark primary-background sticky-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span>TechVoyageBlog</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="profile.jsp"><span class="fas fa-house me-1"></span>Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="contact.jsp"><i class="far fa-address-card me-1"></i>Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="show_past_messages.jsp"><i class="fas fa-message me-1"></i>Past Response</a>
                </li>
                <%
                    if (user1 == null) {
                %>
                <li class="nav-item">
                    <a class="nav-link active" href="login_page.jsp"><span class="fa fa-user-circle me-1"></span>Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="register_page.jsp"><span class="fa fa-user-plus me-1"></span>Sign up</a>
                </li>
                <%
                    }
                %>

                <%
                    if (user1 != null && user1.getStatus().equalsIgnoreCase("active")) {
                %>
                <li class="nav-item">
                    <a class="nav-link active" href="#" data-bs-toggle="modal" data-bs-target="#add-post-modal"><span class="fa fa-pencil me-1"></span>Post a Blog</a>
                </li>
                <%}%>
                <%
                    if(request.getRequestURL().toString().contains("index.jsp") || request.getRequestURL().toString().endsWith("/") ){
                %>
                <li class="nav-item">
                    <a class="nav-link active" href="#about-us"><span class="fas fa-user-shield me-1"></span>About us</a>
                </li>
                <%}%>
                <li class="nav-item">
                    <a class="nav-link active" href="admin/admin_index.jsp"><span class="fas fa-user-shield me-1"></span>Admin Side</a>
                </li>

            </ul>
            <form class="d-flex">

                <div class="serach-container me-2" style="position: relative;">
                    <script>
                        function search() {
                            let pTitle = $("#search-input").val();
                            if (pTitle === '') {
                                $(".search-result").hide();
                            } else {
                                const data = {
                                    pTitle: pTitle
                                };
                                $.ajax({
                                    url: 'search_blog.jsp',
                                    data: data,
                                    success: function (data, textStatus, jqXHR) {
                                        $(".search-result").html(data);
                                        $(".search-result").show();
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        console.log(textStatus);
                                    }
                                });
                            }
                        }
                        $(document).ready(function () {
                            const searchResult = $(".search-result");
                            const inputBox = $("#search-input");
                            const body = $("body");

                            $(body).on("click", function () {
                                searchResult.hide();
                            });

                            $(inputBox).on('click', function () {
                                search();
                            });
                            $(inputBox).on('mousemove', function () {
//                                  inputBox.focus();
                                search();
                            });
                        });
                    </script>

                    <input autocomplete="off" onkeyup="search()" id="search-input" class="form-control me-2" type="text" name="search_blog" placeholder="Search here" aria-label="Search">
                    <div class="search-result" style="position: absolute;background: white;width: 100%;padding: 10px;border: 1px solid gray;display: none;z-index: 1;min-height: 50px;max-height: 46vh; overflow: auto;opacity: 0.8;">

                    </div>
                </div>
            </form>
            <%if (user1 != null) {%>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link active" href="#!" data-bs-toggle="modal" data-bs-target="#profileModal"><span class="fa fa-user-circle me-1"></span><%= user1.getName()%></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="Logout"><span class="fa fa-sign-out me-1"></span>Logout</a>
                </li>
            </ul>
            <%}%>

        </div>
    </div>
</nav>
<%
    if (user1 != null) {
%>
<!--profile modal-->
<div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header primary-background text-white text-center">
                <h5 class="modal-title" id="exampleModalLabel">TechVoageBlog</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid text-center">
                    <img src="img<%=File.separator%><%= user1.getProfile()%>" class="img-fluid" style="border-radius: 50%;  height: 220px;width: 220px;">
                    <h5 class="mt-2 display-6"><%= user1.getName()%></h5>
                    <!--other info-->
                    <div id="profile-details">
                        <table class="table">
                            <tbody>
                                <tr>
                                    <th scope="row">ID</th>
                                    <td><%= user1.getId()%></td>
                                </tr>
                                <tr>
                                    <th scope="row">Email</th>
                                    <td><%= user1.getEmail()%></td>
                                </tr>
                                <tr>
                                    <th scope="row">Gender</th>
                                    <td><%= user1.getGender()%></td>
                                </tr>
                                <tr>
                                    <th scope="row">About</th>
                                    <td><%= user1.getAbout()%></td>
                                </tr>
                                <tr>
                                    <th scope="row">No. of Blogs posted</th>
                                    <td><%= user1.getCountBlog()%></td>
                                </tr>
                                <tr>
                                    <th scope="row">Registration on</th>
                                    <td><%= user1.getDateTime().toString()%></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!--edit profle-->
                    <div id="profile-edit" style="display: none">
                        <h3 class="mt-2">You can edit your details here</h3>
                        <form novalidate="" autocomplete="off" id="form-edit" action="EditServlet" method="post" enctype="multipart/form-data">
                            <table class="table">
                                <tr>
                                    <th>ID</th>
                                    <td><%= user1.getId()%></td>
                                </tr>
                                <tr>
                                    <th>Enter Email</th>
                                    <td><%= user1.getEmail()%></td>
                                </tr>
                                <tr>
                                    <th>Enter Name</th>
                                    <td>
                                        <input type="text" name="user_name" value="<%= user1.getName()%>" class="form-control" id="userName">
                                        <small class="ms-1 text-danger" id="userName-msg"></small>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Enter Password</th>
                                    <td>
                                        <div class="mb-3" style="position: relative;"> 
                                            <input name="user_password" value="<%= user1.getPassword()%>" id="user_password" required="" type="password" class="form-control" placeholder="Enter password here">
                                            <button type="button" id="togglePassword" class="" style="background: #fff;position: absolute;top:28%;right:10px;border:0px;">
                                                <i id="icon" class="fa-regular fa-eye"></i>
                                            </button>

                                        </div>
                                        <small class="ms-1" id="password-msg"></small>
                                    </td>
                                <script>
                                    $(document).ready(function () {

                                        let flag = true;
                                        $("#togglePassword").on('click', function () {

                                            let icon = $("#icon");
                                            let passField = $("#user_password");

                                            if (flag) {
                                                icon.removeClass("fa-eye");
                                                icon.addClass("fa-eye-slash");
                                                passField.attr("type", "text");
                                                flag = false;
                                            } else {
                                                icon.removeClass("fa-eye-slash");
                                                icon.addClass("fa-eye");
                                                passField.attr("type", "password");
                                                flag = true;
                                            }
                                        });
                                    })
                                </script>         


                                </tr>
                                <tr>
                                    <th>Gender</th>
                                    <td><%= user1.getGender().toUpperCase()%></td>
                                </tr>
                                <tr>
                                    <th><div class="mt-3">Tell us about Yourself</div></th>
                                    <td>
                                        <textarea name="user_about" class="form-control" rows="3" id="floatingTextarea2"><%= user1.getAbout()%></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th><div class="mt-2">Profile Picture</div></th>
                                    <td><input type="file" class="form-control" name="user_photo"></td>
                                </tr>
                            </table>
                            <div class="container">
                                <button type="submit" class="btn btn-custom" id="save-btn">Save Changes</button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button id="edit-profile-btn" type="button" class="btn btn-custom">EDIT</button>
                <a href="DeleteUser?id=<%= user1.getId()%>" id="delete-profile-btn" type="button" class="btn btn-custom">DELETE</a>
            </div>
        </div>
    </div>
</div>
<!--end of profile modal-->

<!--add post modal-->
<!-- Modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" id="modalAddPost">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Provide the Post Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form novalidate="" autocomplete="off" action="AddPostServlet" method="post" id="add-post-form">
                    <select class="form-select mb-3" name="cid" aria-label="Default select example" id="category-select">
                        <option selected disabled value="disabled">Select a category</option>
                        <%
                            CategoryDao catd1 = new CategoryDao(ConnectionProvider.getConnection());
                            ArrayList<Category> list1 = catd1.getAllCategories();
                            for (Category c : list1) {
                        %>
                        <option value="<%= c.getCid()%>"><%= c.getName()%></option>
                        <%
                            }
                        %>
                    </select>
                    <div class="form">
                        <div class="mb-3">
                            <input type="text" name="pTitle" class="form-control" id="post-title" placeholder="Post Title" required>

                        </div>
                        <div class="mb-3">
                            <textarea class="form-control" name="pContent" placeholder="Post Content" id="post-content" style="height:200px;" required></textarea>
                        </div>
                        <div class="mb-3">
                            <textarea class="form-control" name="pCode" placeholder="Code(if any)" id="code-area" style="height:200px;"></textarea>
                        </div>
                        <script>
                            document.getElementById('code-area').addEventListener('keydown', function (event) {
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

                        <div class="mb-3">
                            <label for="post-image" class="form-label">Select a Image</label>
                            <input class="form-control" name="pImage" type="file" id="post-image">
                        </div>

                        <div class="mb-3">
                            <input type="text" name="pExternalLink" class="form-control" id="post-external-link" placeholder="External link if any">
                        </div>
                        <div class="text-center">
                            <button class="btn btn-custom" type="submit">Post</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<!--end of post modal-->

<%}%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
                            $(document).ready(function () {
                                
                                let editStatus = false;
//                              TO toggle between profile details and profile edit
                                $("#edit-profile-btn").on('click', function () {
                                    if (editStatus == false) {
                                        $("#profile-details").hide();
                                        $("#profile-edit").show();
                                        $(this).text("BACK");
                                        editStatus = true;
                                    } else {
                                        $("#profile-details").show();
                                        $("#profile-edit").hide();
                                        $(this).text("EDIT");
                                        editStatus = false;
                                    }
                                });
                                $("#add-post-form").on("submit", function (event) {
//                              when form submitted
                                    event.preventDefault();
                                    var firstOption = document.getElementById("category-select").value;
                                    if (firstOption === "disabled") {
                                        swal("Please select a category");
                                        return;
                                    }
                                    let title = $("#post-title").val();
                                    let content = $("#post-content").val();
                                    if (title.trim() == '' || content.trim() == '') {
                                        swal("Title or Blog content must not be empty");
                                        return;
                                    }
                                    let form = new FormData(this);
//                                  server call
                                    $.ajax({
                                        url: "AddPostServlet",
                                        type: 'POST',
                                        data: form,
                                        success: function (data, textStatus, jqXHR) {
                                            if (data.trim() == 'done') {
                                                swal("Good job!", "You posted a blog successfully!", "success");
                                                $('#add-post-modal').modal('hide');
                                              let allPost = $(".c-link")[0];
                                              getPosts(0, allPost);
                                                $("#add-post-form")[0].reset();
                                            } else {
                                                swal("Error!", "Something went wrong try again!!!", "error");
                                            }
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {

                                        },
                                        processData: false,
                                        contentType: false
                                    });
                                });
                                $("#delete-profile-btn").on('click', function () {
                                    event.preventDefault();
                                    swal({
                                        title: "Are you sure?",
                                        text: "Do you want to delete your Account?",
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
                                $("#form-edit").on("submit", function (event) {
                                    if (updateTimeValidation() == false) {
                                        event.preventDefault();
                                    }
                                });


                            });
</script>