<%-- 
    Document   : error_page
    Created on : 13 Aug, 2023, 7:48:24 PM
    Author     : vishal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorry ! something went wrong</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
              rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css" />
        <style>
            .banner-background{
                clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 90%, 61% 100%, 19% 91%, 0 100%, 0% 30%);
            }
            
        </style>
    </head>
    <body>
        <div class="container text-center">
            <img src="img/error.png" alt="" class="img-fluid">
            <h3 class="display-3 text-danger">Sorry ! Something went wrong</h3>
            <%= exception %>
            <a href="index.jsp" class="btn primary-background text-white mt-0">Home</a>
        </div>
    </body>
</html>
