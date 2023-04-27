<%@ page import="java.util.Arrays" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String ordernumber = String.valueOf(request.getAttribute("ordernumber"));
    String productcode = String.valueOf(request.getAttribute("productcode"));
    String quantityordered = String.valueOf(request.getAttribute("quantityordered"));
    String priceeach = String.valueOf(request.getAttribute("priceeach"));
    String orderlinenumber = String.valueOf(request.getAttribute("orderlinenumber"));
%>

<html>
<head>
    <title>Update Order</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css">
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js" integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ" crossorigin="anonymous"></script>
</head>
<body>
<h1 style="text-align: center">Update Order</h1>
<form id="form1" class="container form-container" action="OrderdetailServlet" method="post">
    <input type="hidden" name="action" value="updateOrderdetail"/>
    <table>
        <div class="row mb-3">
            <label class="col-sm-2 col-form-label">Order Number:</label>
            <div class="col input-group">
                <div class="input-group-text">#</div>
                <input readonly type="text" class="form-control" name="ordernumber" placeholder="Order Number" value="<%=ordernumber%>">
            </div>

            <label class="col-sm-2 col-form-label">Product Code:</label>
            <div class="col input-group">
                <div class="input-group-text">#</div>
                <input readonly type="text" class="form-control" name="productcode" placeholder="Product Code" value="<%=productcode%>">
            </div>
        </div>

        <div class="row mb-3">
            <label class="col-sm-2 col-form-label">Quantity Ordered:</label>
            <div class="col input-group">
                <input type="number" class="form-control" name="quantityordered" placeholder="Quantity Ordered" value="<%=quantityordered%>"/>
            </div>
        </div>

        <div class="row mb-3">
            <label class="col-sm-2 col-form-label">Price Each:</label>
            <div class="col input-group">
                <input required type="text" class="form-control" name="priceeach" placeholder="Price Each" value="<%=priceeach%>"/>
            </div>
        </div>

        <div class="row mb-3">
            <label class="col-sm-2 col-form-label">Order Line Number:</label>
            <div class="col input-group">
                <input readonly type="text" class="form-control" name="orderlinenumber" placeholder="Order Line Number" value="<%=orderlinenumber%>"/>
            </div>
        </div>


        <div class="col-md-2" style="flex-basis: content">
            <input type="submit" class="btn btn-primary" value="Update"/>
            <a href="OrderdetailServlet?currentPage=1&recordsPerPage=20&sortBy=ordernumber&direction=asc" class="btn btn-danger">Cancel</a>
        </div>
    </table>
</form>
</body>
</html>
