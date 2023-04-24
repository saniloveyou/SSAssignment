<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="Cart.Cart" %>
<%@ page import="com.utar.model.entity.Orderdetail" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
    DecimalFormat priceFormatter = new DecimalFormat("$#0.00");

//    User auth = (User) request.getSession().getAttribute("auth");
//    if (auth != null) {request.setAttribute("person", auth);}
    List<Orderdetail> cart_list = (List<Orderdetail>) session.getAttribute("cart_list");

    if (cart_list != null)
    for ( Orderdetail o: cart_list) {
     //   System.out.println(o.getProductcode().getId());
    }

    double total = 0;
    if (cart_list != null) {
        for (Orderdetail o : cart_list) {
            total += (o.getQuantityordered() * o.getPriceeach().doubleValue());
        }
    }

//    List<Cart> cartProduct = null;
//    if (cart_list != null) {
//        ProductDao pDao = new ProductDao(DbCon.getConnection());
//        cartProduct = pDao.getCartProducts(cart_list);
//        double total = pDao.getTotalCartPrice(cart_list);
//        request.setAttribute("total", total);
//        request.setAttribute("cart_list", cart_list);
//    }
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
            <th scope="col">Product Coded</th>
            <th scope="col">Name</th>
            <th scope="col">Price</th>
            <th scope="col">Quantity</th>
            <th scope="col">Cancel</th>
        </tr>
        </thead>
        <form action="PaymentCart" method="get" class="form-inline">
        <tbody>
        <%
            if (cart_list != null) {
                for (Orderdetail c : cart_list) {

        %>
        <tr>
            <td><%=c.getProductcode().getId()%></td>
            <td><%=c.getProductcode().getId()%></td>
            <%System.out.println(c.getProductcode().getId());%>
            <td><%=priceFormatter.format(c.getPriceeach().doubleValue())%></td>
            <td>
                <div class="form-group d-flex justify-content-between">
                    <a class="btn bnt-sm btn-incre" href="quantity-inc-dec?action=dec&id=<%=c.getProductcode().getId()%>"><i class="glyphicon glyphicon-minus"></i></a>
                    <input type="text" name="quantity" class="form-control"  value="<%=c.getQuantityordered()%>" >
                    <a class="btn bnt-sm btn-incre" href="quantity-inc-dec?action=inc&id=<%=c.getProductcode().getId()%>"><i class="glyphicon glyphicon-plus"></i></a>
                </div>
            </td>
            <td>
                    <input type="hidden" name="productid" value="<%= c.getProductcode().getId()%>" class="form-input">
                <input type="hidden" name="productid" value="<%= c.getProductcode().getId()%>" class="form-input">
                    <button type="button"  class="btn btn-primary btn-sm"><a href="PaymentCart?quantity=<%="2"%>&productid=<%=c.getProductcode().getId()%>" >Buy</a></button>
            </td>
            <td><a href="remove-from-cart?id=<%=c.getProductcode().getId() %>" class="btn btn-sm btn-danger">Remove</a></td>
        </tr>

        <%}}%>
        </tbody>
        </form>
    </table>
</div>
</body>
</html>