<%@page import="java.util.List"%>
<%@ page import="com.utar.model.entity.Order" %>
<%@ page import="com.utar.model.sessionbean.OrderSessionBean" %>
<%@ page import="javax.ejb.EJB" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.utar.model.entity.Customer" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Insert title here</title>
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
<%

    Customer cust = session.getAttribute("customer") == null ? null : (Customer) session.getAttribute("customer");
    String user = session.getAttribute("username") == null ? null : (String) session.getAttribute("username");

    if(cust == null){
        response.sendRedirect("Login.jsp");
        return;
    }

    if (!user.equals("admin")){
        response.sendRedirect("adminprompt.jsp");
        return;
    }



    int nOfPages = (int) request.getAttribute("nOfPages");
    int currentPage = (int) request.getAttribute("currentPage");
    int recordsPerPage = (int) request.getAttribute("recordsPerPage");
    String sortBy = (String) request.getAttribute("sortBy");
    String direction = (String) request.getAttribute("direction");

    String[] status = (String[]) request.getAttribute("status");
    String ordernumber = (String) request.getAttribute("ordernumber");
    String customernumber = (String) request.getAttribute("customernumber");
    String fromOrderDate = (String) request.getAttribute("fromOrderDate");
    String toOrderDate = (String) request.getAttribute("toOrderDate");
    String fromRequiredDate = (String) request.getAttribute("fromRequiredDate");
    String toRequiredDate = (String) request.getAttribute("toRequiredDate");
    String fromShippedDate = (String) request.getAttribute("fromShippedDate");
    String toShippedDate = (String) request.getAttribute("toShippedDate");

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





        <form id="form1" class="container form-container" action="OrderServlet" method="get">
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

                <label class="col-sm-2 col-form-label">Customer Number:</label>
                <div class="col input-group">
                    <div class="input-group-text" style="height: 34px;">#</div>
                    <input type="number" class="form-control" name="customernumber" placeholder="Customer Number" value="<%=customernumber%>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Order Date:</label>
                <div class="col input-group">
                    <div class="input-group-text" style="height: 34px;">From Date</div>
                    <input type="date" class="form-control" name="fromOrderDate"  value="<%=fromOrderDate%>"/>
                </div>
                <div class="col input-group">
                    <div class="input-group-text" style="height: 34px;">To Date</div>
                    <input type="date" class="form-control" name="toOrderDate" value="<%=toOrderDate%>"/>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Required Date:</label>
                <div class="col input-group">
                    <div class="input-group-text" style="height: 34px;">From Date</div>
                    <input type="date" class="form-control" name="fromRequiredDate" value="<%=fromRequiredDate%>"/>
                </div>
                <div class="col input-group">
                    <div class="input-group-text" style="height: 34px;">To Date</div>
                    <input type="date" class="form-control" name="toRequiredDate" value="<%=toRequiredDate%>"/>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Shipped Date:</label>
                <div class="col input-group">
                    <div class="input-group-text" style="height: 34px;"> From Date</div>
                    <input type="date" class="form-control" name="fromShippedDate" value="<%=fromShippedDate%>"/>
                </div>
                <div class="col input-group">
                    <div class="input-group-text" style="height: 34px;">To Date</div>
                    <input type="date" class="form-control" name="toShippedDate" value="<%=toShippedDate%>"/>
                </div>
            </div>

            <fieldset class="row mb-3 row">
                <legend class="col-form-label col-sm-2 pt-0">Status:</legend>
                <div class="col">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="status" value="In Process"
                            <%if(Arrays.stream(status).anyMatch("In Process"::equals)){%> checked <%}%>
                        >
                        <label class="form-check-label">In Process</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="status" value="On Hold"
                            <%if(Arrays.stream(status).anyMatch("On Hold"::equals)){%> checked <%}%>
                        >
                        <label class="form-check-label">On Hold</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="status" value="Disputed"
                            <%if(Arrays.stream(status).anyMatch("Disputed"::equals)){%> checked <%}%>
                        >
                        <label class="form-check-label">Disputed</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="status" value="Resolved"
                            <%if(Arrays.stream(status).anyMatch("Resolved"::equals)){%> checked <%}%>
                        >
                        <label class="form-check-label">Resolved</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="status" value="Shipped"
                            <%if(Arrays.stream(status).anyMatch("Shipped"::equals)){%> checked <%}%>
                        >
                        <label class="form-check-label">Shipped</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="status" value="Cancelled"
                            <%if(Arrays.stream(status).anyMatch("Cancelled"::equals)){%> checked <%}%>
                        >
                        <label class="form-check-label">Cancelled</label>
                    </div>
                </div>
                <div class="col-md-2 input-group" style="flex-basis: content; height: 34px;" >
                    <div class="input-group-text" style="flex-basis: content; height: 34px;">Records per page</div>
                    <input type="number" class="form-control" name="recordsPerPage" value="<%=recordsPerPage%>" min="1" required>
                </div>
                <div class="col-md-2" style="flex-basis: content">
                    <input type="submit" class="btn btn-primary" value="Search"/>
                    <a href="OrderServlet" class="btn btn-danger">Reset</a>
                </div>
            </fieldset>
        </form>

        <form id="searchForm" action="OrderServlet" method="get">
            <input type="hidden" name="currentPage" id="currentPage" value="<%=currentPage%>"/>
            <input type="hidden" name="sortBy" value="<%=sortBy%>"/>
            <input type="hidden" name="direction" value="<%=direction%>"/>
            <input type="hidden" name="nOfPages"  value="<%=nOfPages%>"/>
            <input type="hidden" name="recordsPerPage"  value="<%=recordsPerPage%>"/>
            <input type="hidden" name="ordernumber" value="<%=ordernumber%>"/>
            <input type="hidden" name="customernumber" value="<%=customernumber%>"/>
            <input type="hidden" name="fromOrderDate" value="<%=fromOrderDate%>"/>
            <input type="hidden" name="toOrderDate" value="<%=toOrderDate%>"/>
            <input type="hidden" name="fromRequiredDate" value="<%=fromRequiredDate%>"/>
            <input type="hidden" name="toRequiredDate" value="<%=toRequiredDate%>"/>
            <input type="hidden" name="fromShippedDate" value="<%=fromShippedDate%>"/>
            <input type="hidden" name="toShippedDate" value="<%=toShippedDate%>"/>

                <%for (String s: status) { %>
            <input type="hidden" name="status" value="<%=s%>">
                <%}%>


            <div class="container table-responsive">
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th class="text-center">
                            <a href="OrderServlet?<%=query%>&sortBy=ordernumber&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                                Order Number
                            </a>
                        </th>
                        <th class="text-center">
                            <a href="OrderServlet?<%=query%>&sortBy=orderdate&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                                Order Date
                            </a>
                        </th>
                        <th class="text-center">
                            <a href="OrderServlet?<%=query%>&sortBy=requireddate&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                                Required Date
                            </a>
                        </th>
                        <th class="text-center">
                            <a href="OrderServlet?<%=query%>&sortBy=shippeddate&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                                Shipped Date
                            </a>
                        </th>
                        <th class="text-center">
                            <a href="OrderServlet?<%=query%>&sortBy=status&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                                Status
                            </a>
                        </th>
                        <th class="text-center">
                            <a href="OrderServlet?<%=query%>&sortBy=comments&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                                Comments
                            </a>
                        </th>
                        <th class="text-center">
                            <a href="OrderServlet?<%=query%>&sortBy=customernumber&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                                Customer Number
                            </a>
                        </th>

                        <th>
                            Order Details
                        </th>
                        <th>
                            Update
                        </th>
                        <th>
                            Delete
                        </th>
                    </tr>
                    <%
                        List<Order> orders = (List<Order>) request.getAttribute("orders");
                        if (orders.size() != 0) {
                            for (Order o : orders) {%>
                    <tr id="<%=o.getId()%>">
                        <td><%=o.getId()%></td>
                        <td><%=o.getOrderdate()%></td>
                        <td><%=o.getRequireddate()%></td>
                        <td><%=o.getShippeddate() == null ? "" : o.getShippeddate()%></td>
                        <td><%=o.getStatus()%></td>
                        <td><%=o.getComments()%></td>
                        <td><%=o.getCustomernumber()%></td>
                        <td id="view" ><a href="OrderdetailServlet?currentPage=1&sortBy=ordernumber&direction=asc&ordernumber=<%=o.getId()%>&recordsPerPage=20">View</a></td>
                        <td id="update" ><a href="OrderServlet?action=update&ordernumber=<%=o.getId()%>">Update</a></td>
                        <td id="delete" ><a style='color: red;'  href="#" onclick="deleteOrder(<%=o.getId()%>)">Delete</a></td>
                    </tr>
                            <%}
                        } else {
                            out.println("<tr>");
                            for (int i = 0; i < 10; i++) out.println("<td>No records</td>");
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
    </div>
    </form>
    </div>
</div>


<script>
    function pagination(action)
    {
        if (action == "first")
            document.getElementById("currentPage").value = 1;
        else if (action == "last")
            document.getElementById("currentPage").value = <%=nOfPages%>;
        else if (action == "next")
            document.getElementById("currentPage").value = <%=currentPage%> + 1;
        else if (action == "previous")
            document.getElementById("currentPage").value = <%=currentPage%> - 1;
        document.getElementById("searchForm").submit();
    }

    function deleteOrder(id) {
        var r = confirm('Are you sure you want to delete Order Number: '+id+'?');
        if (r == true) {
            window.location.href = 'OrderServlet?action=delete&ordernumber=' + id;
        } else {
            return false;
        }
    }
</script>
</body>
</html>