<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="Cart.Cart" %>
<%@ page import="com.utar.model.entity.Orderdetail" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
    DecimalFormat priceFormatter = new DecimalFormat("$#0.00");

//    User auth = (User) request.getSession().getAttribute("auth");
//    if (auth != null) {request.setAttribute("person", auth);}
    List<Orderdetail> cart_list = (List<Orderdetail>) request.getAttribute("orderdetails");

    double total = 0;
    if (cart_list != null) {
        for (Orderdetail o : cart_list) {
            total += (o.getQuantityordered() * o.getPriceeach().doubleValue());
        }
    }

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>E-Commerce Cart</title>
    <style>

        .table tbody td{
            vertical-align: middle;
        }
        .btn-incre, .btn-decre{
            box-shadow: none;
            font-size: 25px;
        }
    </style>
    <style>
        body {font-family: Arial, Helvetica, sans-serif;}
        * {box-sizing: border-box;}
    </style>

    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800" rel="stylesheet">

    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/normalize.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/templatemo-misc.css">
    <link rel="stylesheet" href="css/templatemo-style.css">

    <script src="js/vendor/modernizr-2.6.2.min.js"></script>
    <style>
        .product-content h5 {
            text-transform: none;
        }
    </style>


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js" integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ" crossorigin="anonymous"></script>
</head>
<body>

<div class="container my-3">
    <div class="d-flex py-3"><h3>Total Price: <%=priceFormatter.format(total)%> </h3> <a class="mx-3 btn btn-primary" href="#">Check Out</a></div>
    <table class="table table-light">
        <thead>
        <tr>
            <th scope="col">Order Number</th>
            <th scope="col">Product Code</th>
            <th scope="col">Name</th>
            <th scope="col">Price</th>
            <th scope="col">Quantity</th>
            <th scope="col">Update</th>
            <th scope="col">Delete</th>
        </tr>
        </thead>
        <form action="PaymentCart" method="get" class="form-inline">
        <tbody>
        <%
            if (cart_list != null) {
                for (Orderdetail c : cart_list) {

        %>
        <tr>
            <td><%=c.getOrdernumber().getId()%></td>
            <td><%=c.getProductcode().getId()%></td>
            <td><%=c.getProductcode().getProductname()%></td>
            <td><%=priceFormatter.format(c.getPriceeach().doubleValue())%></td>
            <td><%=c.getQuantityordered()%></td>
            <td id="update" ><a href="OrderdetailServlet?action=update&only=quantity&ordernumber=<%=c.getOrdernumber().getId()%>&productcode=<%=c.getProductcode().getId()%>">Update</a></td>
            <td id="delete" ><a style='color: red;' href="#" onclick="deleteCart(<%=c.getOrdernumber().getId()%>, '<%=c.getProductcode().getId()%>')">Delete</a></td>
        </tr>

        <%}
            } else {
            out.println("<tr>");
            for (int i = 0; i < 6; i++) out.println("<td>No records</td>");
            out.println("</tr>");
            }
        %>

        </tbody>
        </form>
    </table>
</div>

<script>
    function deleteCart(id, productcode) {
        var r = confirm('Are you sure you want to delete Order Number: '+id+'?');
        if (r == true) {
            window.location.href = 'OrderdetailServlet?action=delete&only=quantity&ordernumber=' + id + '&productcode=' + productcode;
        } else {
            return false;
        }
    }
</script>
</body>
</html>