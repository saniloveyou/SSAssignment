<%@page import="java.util.List" %>
<%@ page import="com.utar.model.entity.Orderdetail" %>
<%@ page import="com.utar.model.entity.Orderdetail" %>
<%@ page import="com.utar.model.entity.Customer" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Insert title here</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
        }

        * {
            box-sizing: border-box;
        }
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


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"
            integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js"
            integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ"
            crossorigin="anonymous"></script>
</head>
<body>
<%
    int nOfPages = (int) request.getAttribute("nOfPages");
    int currentPage = (int) request.getAttribute("currentPage");
    int recordsPerPage = (int) request.getAttribute("recordsPerPage");
    String sortBy = (String) request.getAttribute("sortBy");
    String direction = (String) request.getAttribute("direction");


    String ordernumber = (String) request.getAttribute("ordernumber");
    String productcode = (String) request.getAttribute("productcode");
    String quantityordered = (String) request.getAttribute("quantityordered");
    String priceeach = (String) request.getAttribute("priceeach");
    String orderlinenumber = (String) request.getAttribute("orderlinenumber");



    String query = "";
    try {
        query = request.getQueryString().replaceAll("&sortBy=" + sortBy + "&direction=" + direction, "");
    } catch (Exception e) {
        query = "";
    }
%>
<header class="site-header">
    <div class="top-header">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <div class="top-header-left">
                        <%
                            Customer customer = session.getAttribute("customer") == null ? null : (Customer) session.getAttribute("customer");
                            String username = session.getAttribute("username") == null ? null : (String) session.getAttribute("username");
                            if(username != null){
                        %>
                        <p style="color: black">Welcome, <b><%=username ==  "admin" ? "admin" : customer.getCustomername()%></b></p>
                        <%} else {%>
                        <a href="SignUp">Sign Up</a>
                        <a href="Login.jsp">Log In</a>

                        <%}%>
                    </div> <!-- /.top-header-left -->
                </div> <!-- /.col-md-6 -->
                <div class="col-md-6 col-sm-6">
                    <div class="top-header-left text-right">
                        <a href="Profile?currentPage=1&recordsPerPage=20&direction=asc">Edit Profile</a>
                        <a href="CartServlet">Cart (<%= session.getAttribute("cartcount") == null ? 0 : session.getAttribute("cartcount")%>) </a>
                        <a href="LoginServlet?action=logout">Logout</a>
                    </div> <!-- /.top-header-left -->
                </div> <!-- /.col-md-6 -->
            </div> <!-- /.col-md-6 -->
        </div> <!-- /.row -->
    </div> <!-- /.container -->
    </div> <!-- /.top-header -->
    <div class="main-nav">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="list-menu">
                        <ul>
                            <li><a href="index.html">Shop</a></li>
                            <li><a href="ProductPaginationServlet?currentPage=1&recordsPerPage=12&admin=false&keyword=&sort=ASC">Catalogs</a></li>
                            <li><a href="ProductlineDisplayServlet?currentPage=1&recordsPerPage=12&&keyword=&sort=ASC">Productline</a></li>
                            <li><a href="adminProductPage.html">Product Edit</a></li>
                            <li><a href="OrderServlet?currentPage=1&recordsPerPage=20&sortBy=ordernumber&direction=asc">Order Details</a></li>
                            <li><a href="OrderdetailServlet?currentPage=1&recordsPerPage=20&sortBy=ordernumber&direction=asc">View Order Details</a></li>
                            <li><a href="PaymentServlet?currentPage=1&recordsPerPage=20&direction=asc">Payment Details</a></li>
                            <li><a href="contact.html">Contact</a></li>
                        </ul>
                    </div> <!-- /.list-menu -->
                </div> <!-- /.col-md-6 -->
            </div> <!-- /.row -->
        </div> <!-- /.container -->
    </div> <!-- /.main-nav -->
</header> <!-- /.site-header -->

<div class="content-section">
    <div class="container">
        <h1 class="text-center"><b>Order Details</b></h1>

        <form id="form1" class="container form-container" action="OrderdetailServlet" method="get">
            <input type="hidden" name="currentPage" value="<%=currentPage%>">
            <input type="hidden" name="sortBy" value="<%=sortBy%>">
            <input type="hidden" name="direction" value="<%=direction%>">
            <input type="hidden" name="nOfPages" value="<%=nOfPages%>">
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Order Number:</label>
                <div class="col input-group">
                    <div class="input-group-text" style="height: 34px;">#</div>
                    <input type="number" class="form-control" name="ordernumber" placeholder="Order Number" value="<%=ordernumber%>">
                </div>
                <label class="col-sm-2 col-form-label">Product Code:</label>
                <div class="col input-group">
                    <div class="input-group-text" style="height: 34px;">#</div>
                    <input type="text" class="form-control" name="productcode" placeholder="Product Code" value=<%=productcode%>>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-2"></div>
                <div class="col"></div>
                <div class="col-sm-3 input-group" style="flex-basis: content; height: 34px;" >
                    <div class="input-group-text" style="flex-basis: content; height: 34px;">Records per page</div>
                    <input type="number" class="form-control" name="recordsPerPage" value="<%=recordsPerPage%>" min="1" required>
                </div>
                <div class="col-md-2" style="flex-basis: content">
                    <input type="submit" class="btn btn-primary" value="Search"/>
                    <a href="OrderdetailServlet" class="btn btn-danger">Reset</a>
                </div>
            </div>
        </form>

        <form id="OrderdetailSearchForm" action="OrderdetailServlet" method="get">
            <input type="hidden" name="currentPage" id="currentPage" value="<%=currentPage%>"/>
            <input type="hidden" name="sortBy" value="<%=sortBy%>"/>
            <input type="hidden" name="direction" value="<%=direction%>"/>
            <input type="hidden" name="nOfPages" value="<%=nOfPages%>"/>
            <input type="hidden" name="recordsPerPage" value="<%=recordsPerPage%>"/>
            <input type="hidden" name="ordernumber" value="<%=ordernumber%>"/>
            <input type="hidden" name="productcode" value="<%=productcode%>"/>


            <div class="container table-responsive">
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th class="text-center">
                            <a href="OrderdetailServlet?<%=query%>&sortBy=ordernumber&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                                Order Number
                            </a>
                        </th>
                        <th class="text-center">
                            <a href="OrderdetailServlet?<%=query%>&sortBy=productcode&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                                Product Code
                            </a>
                        </th>
                        <th class="text-center">
                            <a href="OrderdetailServlet?<%=query%>&sortBy=quantityordered&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                                Quantity Ordered
                            </a>
                        </th>
                        <th class="text-center">
                            <a href="OrderdetailServlet?<%=query%>&sortBy=priceeach&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                                Price Each
                            </a>
                        </th>
                        <th class="text-center">
                            <a href="OrderdetailServlet?<%=query%>&sortBy=orderlinenumber&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                                Order Line Number
                            </a>
                        </th>
                        <th>
                            Product Details
                        </th>
                        <th>
                            Update
                        </th>
                        <th>
                            Delete
                        </th>
                    </tr>
                    <%
                        List<Orderdetail> orders = (List<Orderdetail>) request.getAttribute("orders");
                        if (orders.size() != 0) {
                            for (Orderdetail o : orders) {%>
                                <tr>
                                    <td><%=o.getOrdernumber().getId()%></td>
                                    <td><%=o.getProductcode().getId()%></td>
                                    <td><%=o.getQuantityordered()%></td>
                                    <td><%=o.getPriceeach()%></td>
                                    <td><%=o.getOrderlinenumber()%></td>
                                    <td id="view" ><a href="ProductController?display=product&id=<%=o.getProductcode().getId()%>">View</a></td>
                                    <td id="update" ><a href="OrderdetailServlet?action=update&ordernumber=<%=o.getOrdernumber().getId()%>&productcode=<%=o.getProductcode().getId()%>">Update</a></td>
                                    <td id="delete" ><a style='color: red;' href="#" onclick="deleteOrder(<%=o.getOrdernumber().getId()%>, '<%=o.getProductcode().getId()%>')">Delete</a></td>
                                </tr>
                    <%}
                        } else {
                            out.println("<tr>");
                            for (int i = 0; i < 7; i++) out.println("<td>No records</td>");
                            out.println("</tr>");
                        }
                    %>
                </table>
            </div>

            <nav class="container" aria-label="Navigation for staffs">
                <ul class="pagination justify-content-center">
                    <% if (currentPage != 1 && nOfPages != 0) {%>
                    <li class="page-item"><a class="page-link" onclick="pagination('first')">First</a></li>
                    <li class="page-item"><a class="page-link" onclick="pagination('previous')">Previous</a></li>
                    <%}%>
                    <% if (currentPage < nOfPages) {%>
                    <li class="page-item"><a class="page-link" onclick="pagination('next')">Next</a></li>
                    <li class="page-item"><a class="page-link" onclick="pagination('last')">Last</a></li>
                    <%}%>
                </ul>
            </nav>

            <div class="container text-center">
                <%if (nOfPages != 0) {%>
                <p class="pageref"><%=currentPage%> of <%=nOfPages%>
                </p>
                <%}%>
            </div>

        </form>
    </div>
</div>

<script>
    function pagination(action) {
        if (action == "first")
            document.getElementById("currentPage").value = 1;
        else if (action == "last")
            document.getElementById("currentPage").value = <%=nOfPages%>;
        else if (action == "next")
            document.getElementById("currentPage").value = <%=currentPage%> +1;
        else if (action == "previous")
            document.getElementById("currentPage").value = <%=currentPage%> -1;
        document.getElementById("OrderdetailSearchForm").submit();
    }

    function deleteOrder(id, productcode) {
        var r = confirm('Are you sure you want to delete Order Number: '+id+'?');
        if (r == true) {
            window.location.href = 'OrderdetailServlet?action=delete&ordernumber=' + id + '&productcode=' + productcode;
        } else {
            return false;
        }
    }
</script>
</body>
</html>