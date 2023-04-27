<%@ page import="com.utar.model.entity.Productline" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 4/18/2023
  Time: 9:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Product Line Information</title>

    <!-- CSS links -->
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          rel="stylesheet">
    <style>
        .form-wrapper {
            width: 40%;
            margin: 1rem auto 10rem;

        }

        .right {
            float: right;
        }
    </style>

    <script src="js/vendor/modernizr-2.6.2.min.js"></script>
</head>
<body>
<%
    Productline productline = (Productline) request.getAttribute("productline");
%>
<div class="form-wrapper">
    <form action="ProductlineController" method="post">
        <div class="row justify-content-center">
            <h3>Update Product Line Form</h3>
        </div>
        <div class="form-group row">
            <label class="col-sm-4 col-form-label">Product Line: </label>
            <%
                out.println("<textarea name=\"productline\" id=\"productline\" cols=\"50\" >" + productline.getId() + "</textarea>");
            %>
        </div>

        <div class="form-group row">
            <label class="col-sm-4 col-form-label">Text Description: </label>
            <%
                out.println("<textarea name=\"textDescription\" id=\"textDescription\" cols=\"50\" >" + productline.getTextdescription() + "</textarea>");
            %>
        </div>
        <div class="form-group row">
            <label class="col-sm-4 col-form-label">HTML Description: </label>
            <%
                out.println("<textarea name=\"htmlDescription\" id=\"htmlDescription\" cols=\"50\" >" + productline.getHtmldescription() + "</textarea>");
            %>
        </div>
        <div class="form-group row">
            <label class="col-sm-4 col-form-label">Image: </label>
            <%
                out.println("<input type=\"text\" name=\"image\" id=\"image\" " + productline.getImage() + ">");
            %>
        </div>
        <div class="right">
            <button class="btn btn-primary" type="update">Update</button>
        </div>
    </form>
</div>
</body>
</html>
