<%@include file="../set_header.jsp"%>
<%@page import="com.techvoyageblog.entities.User"%>
<%@page import="com.techvoyageblog.helper.ConnectionProvider"%>
<%@page import="com.techvoyageblog.dao.UserDAO"%>
<%    int id = Integer.parseInt(request.getParameter("userId"));
    UserDAO dao1 = new UserDAO(ConnectionProvider.getConnection());
    User userDetails = dao1.getUserByUserId(id);
%>
<div class="modal-header primary-background text-white text-center">
    <h5 class="modal-title" id="exampleModalLabel">TechVoageBlog</h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<div class="modal-body">
    <div class="container text-center">

        <img src="../img/<%= userDetails.getProfile()%>" class="img-fluid" style="border-radius: 50%; min-height: 200px;min-width: 200px; max-height: 250px;max-width: 250px;">
        <!--other info-->
        <div id="profile-details">
            <table class="table">
                <tbody>
                    <tr>
                        <th scope="row">Username</th>
                        <td><%= userDetails.getName()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Email</th>
                        <td><%= userDetails.getEmail()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Blogs Posted</th>
                        <td><%= userDetails.getCountBlog()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Gender</th>
                        <td><%= userDetails.getGender()%></td>
                    </tr>
                    <tr>
                        <th scope="row">About</th>
                        <td><%= userDetails.getAbout()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Registered on</th>
                        <td><%= userDetails.getDateTime()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Status</th>
                        <td><%= userDetails.getStatus()%></td>
                    </tr>
                </tbody>
            </table>
        </div>


    </div>
</div>
<div class="modal-footer">
    <%
        String oppStatus = "";
        String icon = "";
        if (userDetails.getStatus().equalsIgnoreCase("active")) {
            oppStatus = "Inactive";
            icon = "fa-lock";
        } else {
            oppStatus = "Active";
            icon = "fa-unlock";
        }

    %>
    <button onclick="changeStatus('<%=oppStatus%>')" class="btn btn-custom btn-small l1" ><i id="" class="fas <%=icon%>" id="like" style="color:white;"></i><span class="ms-1">Set <%=oppStatus%></span></button>
</div>
<script>
    function changeStatus(operation) {
        const id = <%= userDetails.getId()%>;
        const d = {
            id: id,
            operation: operation
        };

        $.ajax({
            url: "../UserStatus",
            data: d,
            success: function (data, textStatus, jqXHR) {
                console.log(data);
                if (data.trim() === 'true') {
                    location.reload();
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
            }
        });
    }
</script>
