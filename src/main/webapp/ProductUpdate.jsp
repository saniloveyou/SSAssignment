<%@ page import="com.utar.model.entity.Product" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Product Information</title>
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
    Product product = (Product) request.getAttribute("product");
%>
<div class="form-wrapper">
    <form action="ProductController" method="post">
        <div class="row justify-content-center">
            <h3>Update Product Form</h3>
        </div>
        <div class="form-group row">
            <label class="col-sm-4 col-form-label">Product Code: </label>
            <%
                out.println("<input class=\"col-sm form-control\" name=\"productId\" id=\"productId\" readonly value=" + product.getId() + ">");
            %>
        </div>

        <div class="form-group row">
            <label class="col-sm-4 col-form-label">Product Name: </label>
            <%
                out.println("  <textarea name=\"productName\" id=\"productName\" cols=\"50\" >" + product.getProductname() + "</textarea>");
            %>
        </div>
        <div class="form-group row">
            <label class="col-sm-4 col-form-label">Product Line: </label>
            <%
                out.println("  <textarea name=\"productline\" id=\"productline\" cols=\"50\" >" + product.getProductline().getId() + "</textarea>");
            %>
        </div>
        <div class="form-group row">
            <label class="col-sm-4 col-form-label">Product Scale: </label>
            <%
                out.println("  <input required class=\"col-sm form-control\" name=\"productScale\" id=\"productScale\" value=" + product.getProductscale() + ">");
            %>
        </div>
        <div class="form-group row">
            <label class="col-sm-4 col-form-label">Product Vendor: </label>
            <%
                out.println("  <textarea name=\"productVendor\" id=\"productVendor\" cols=\"50\" >" + product.getProductvendor() + "</textarea>");
            %>
        </div>
        <div class="form-group row">
            <label class="col-sm-4 col-form-label">Product Description: </label>
            <%
                out.println("  <textarea name=\"productDescription\" id=\"productDescription\" rows =\"10\" cols=\"100\" >" + product.getProductdescription() + "</textarea>");
            %>
        </div>
        <div class="form-group row">
            <label class="col-sm-4 col-form-label">Quantity in Stock: </label>
            <%
                out.println("  <input  class=\"col-sm form-control\" name=\"productInStock\" id=\"productInStock\" value=" + product.getQuantityinstock() + ">");
            %>
        </div>
        <div class="form-group row">
            <label class="col-sm-4 col-form-label">Buy Price: </label>
            <%
                out.println("  <input required class=\"col-sm form-control\" name=\"buyPrice\" id=\"buyPrice\" value=" + product.getBuyprice() + ">");
            %>
        </div>
        <div class="form-group row">
            <label class="col-sm-4 col-form-label">MSRP: </label>
            <%
                out.println("  <input required class=\"col-sm form-control\" name=\"msrp\" id=\"msrp\" value=" + product.getMsrp() + ">");
            %>
        </div>
        <div class="right">
            <button class="btn btn-primary" type="update">Update</button>
        </div>
    </form>
</div>
</body>
</html>