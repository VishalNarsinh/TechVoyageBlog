<%@include file="../set_header.jsp"%>
<%@page import="com.techvoyageblog.admin.Admin"%>
<%    Admin admin1 = (Admin) session.getAttribute("admin");
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <style>
        .search-result::-webkit-scrollbar {
            width: 8px; /* Adjust the width as needed */
        }

        .search-result::-webkit-scrollbar-thumb {
            background-color: transparent; /* Should match the background color */
        }
    </style>
</head>
<nav class="navbar navbar-expand-lg navbar-dark primary-background sticky-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="admin_index.jsp"><span class="fa fa-asterisk"></span>TechVoyageBlog</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="dashboard.jsp"><span class="fas fa-house me-1"></span>Home</a>
                </li>
                <%
                    if (admin1 == null) {
                %>
                <li class="nav-item">
                    <a class="nav-link active" href="admin_login.jsp"><span class="fa fa-user-circle me-1"></span>Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="admin_registration.jsp"><span class="fa fa-user-plus me-1"></span>Registration</a>
                </li>
                <%
                } else {
                %>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="show_users.jsp"><span class="fas fa-users me-1"></span>Show Users</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="show_categories.jsp"><span class="fas fa-list me-1"></span>Show Categories</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="show_queries.jsp"><i class="fas fa-message me-1"></i>Show Queries</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="#!" data-bs-toggle="modal" data-bs-target="#addCategoryModal"><span class="far fa-square-plus me-1"></span>Add Category</a>
                </li>
                <%
                    }
                %>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="../index.jsp"><span class="fas fa-user-friends me-1"></span>Users Side</a>
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
            <%if (admin1 != null) {%>
            <ul class="navbar-nav">

                <li class="nav-item">
                    <a class="nav-link active" href="#!" data-bs-toggle="modal" data-bs-target="#profileModal"><span class="fa fa-user-circle me-1"></span><%= admin1.getUsername()%></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active me-1" href="../AdminLogout"><span class=" d-inline fa fa-sign-out me-1"></span>Logout</a>
                </li>
            </ul>
            <%}%>

        </div>
    </div>
</nav>
<%
    if (admin1 != null) {
%>
<!--profile modal-->

<!-- Modal -->
<div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header primary-background text-white text-center">
                <h5 class="modal-title" id="exampleModalLabel">TechVoageBlog</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container text-center">
                    <img src="img/<%= admin1.getProfile()%>" class="img-fluid" style="border-radius: 50%;  height: 250px;width: 250px;">
                    <h5 class="mt-2 display-6"><%= admin1.getUsername()%></h5>
                    <!--other info-->
                    <div id="profile-details">
                        <table class="table">
                            <tbody>
                                <tr>
                                    <th scope="row">Username</th>
                                    <td><%= admin1.getUsername()%></td>
                                </tr>
                                <tr>
                                    <th scope="row">Email</th>
                                    <td><%= admin1.getEmail()%></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!--edit profle-->
                    <div id="profile-edit" style="display: none">
                        <h3 class="mt-2">You can edit your details here</h3>
                        <form autocomplete="off" action="../AdminEdit" id="form-edit" method="post" enctype="multipart/form-data">
                            <table class="table">
                                <tr>
                                    <th>ID</th>
                                    <td><%= admin1.getId()%></td>
                                </tr>
                                <tr>
                                    <th>Enter Email</th>
                                    <td><%= admin1.getEmail()%></td>
                                </tr>
                                <tr>
                                    <th>Enter Name</th>
                                    <td>
                                        <input type="text" name="user_name" value="<%= admin1.getUsername()%>" class="form-control" id="userName">
                                        <small class="ms-1 text-danger" id="userName-msg"></small>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Enter Password</th>
                                    <td>
                                        <div class="mb-3" style="position: relative;"> 
                                            <input name="user_password" value="<%= admin1.getPassword()%>" id="user_password" required="" type="password" class="form-control" placeholder="Enter password here">
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

                                <tr>
                                    <th><div class="mt-2">Profile Picture</div></th>
                                    <td><input type="file" class="form-control" name="user_photo"></td>
                                </tr>
                            </table>
                            <div class="container">
                                <button type="submit" class="btn btn-custom" id="">Save Changes</button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button id="edit-profile-btn" type="button" class="btn btn-custom">EDIT</button>
                <a href="../DeleteAdmin?id=<%= admin1.getId()%>" id="delete-profile-btn" type="button" class="btn btn-custom">DELETE Account</a>
            </div>
        </div>
    </div>
</div>
<!--end of profile modal-->            


<!--Add Category modal-->

<!-- Modal -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header primary-background text-white text-center">
                <h5 class="modal-title" id="exampleModalLabel">TechVoageBlog</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">

                <div class="card">
                    <div class="card-header"><h3>Add new Category</h3></div>
                    <div class="card-body">
                        <form autocomplete="off" action="../CategoryAdd" method="post" id="cat-add-form">
                            <table class="table">
                                <tr>
                                    <th>Enter Name</th>
                                    <td><input type="text" id="catName" name="name" class="form-control"></td>
                                </tr>
                                <tr>
                                    <th>Enter Description</th>
                                    <td><textarea name="description" id="desc" class="form-control"></textarea></td>
                                </tr>
                            </table>
                            <div class="container text-center">
                                <button type="submit" id="add-category-btn" class="btn btn-custom">Add Category</button>
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
<%}%>


<script>
    $(document).ready(function () {
        let editStatus = false;
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


        $("#cat-add-form").on('submit', function () {
            let name = $("#catName").val();
            let desc = $("#desc").val();
            if (name.trim() === "") {
                event.preventDefault();
                swal("Name must not be empty");
            }
            if (desc.trim() === "") {
                event.preventDefault();
                swal("Description must not be empty");
            }
        });

        $("#form-edit").on("submit", function (event) {
            if (updateTimeValidation() == false) {
                event.preventDefault();
            }
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
    });



</script>