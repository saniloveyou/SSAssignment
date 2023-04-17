<%@page import="java.util.List"%>
<%@ page import="com.utar.model.entity.Order" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js" integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ" crossorigin="anonymous"></script>
</head>
<body class="m-3">
<%
    int nOfPages = (int) request.getAttribute("nOfPages");
    int currentPage = (int) request.getAttribute("currentPage");
    int recordsPerPage = (int) request.getAttribute("recordsPerPage");
    String sortBy = (String) request.getAttribute("sortBy");
    String direction = (String) request.getAttribute("direction");

    String search = "";
%>

<h1 class="text-center">
    Order Details
</h1>
<form class="container form-container" action="OrderServlet" method="post">
    <div class="row mb-3">
        <label for="ordernumber" class="col-sm-2 col-form-label">Order Number:</label>
        <div class="col input-group">
            <div class="input-group-text">#</div>
            <input type="number" class="form-control" id="ordernumber" placeholder="Order Number">
        </div>

        <label for="customernumber" class="col-sm-2 col-form-label">Customer Number:</label>
        <div class="col input-group">
            <div class="input-group-text">#</div>
            <input type="number" class="form-control" id="customernumber" placeholder="Customer Number">
        </div>
    </div>

    <div class="row mb-3">
        <label class="col-sm-2 col-form-label">Order Date:</label>
        <div class="col input-group">
            <div class="input-group-text">From Date</div>
            <input type="date" class="form-control" id="formOrderDate"/>
        </div>
        <div class="col input-group">
            <div class="input-group-text">To Date</div>
            <input type="date" class="form-control" id="toOrderDate"/>
        </div>
    </div>

    <div class="row mb-3">
        <label class="col-sm-2 col-form-label">Required Date:</label>
        <div class="col input-group">
            <div class="input-group-text">From Date</div>
            <input type="date" class="form-control" id="formRequiredDate"/>
        </div>
        <div class="col input-group">
            <div class="input-group-text">To Date</div>
            <input type="date" class="form-control" id="toRequiredDate"/>
        </div>
    </div>

    <div class="row mb-3">
        <label class="col-sm-2 col-form-label">Shipped Date:</label>
        <div class="col input-group">
            <div class="input-group-text">From Date</div>
            <input type="date" class="form-control" id="formShippedDate"/>
        </div>
        <div class="col input-group">
            <div class="input-group-text">To Date</div>
            <input type="date" class="form-control" id="toShippedDate"/>
        </div>
    </div>

    <fieldset class="row mb-3 row">
        <legend class="col-form-label col-sm-2 pt-0">Status:</legend>
        <div class="col">
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="status" id="InProcess" value="In Process">
                <label class="form-check-label" for="InProcess">In Process</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="status" id="OnHold" value="On Hold">
                <label class="form-check-label" for="OnHold">On Hold</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="status" id="Disputed" value="Disputed">
                <label class="form-check-label" for="Disputed">Disputed</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="status" id="Resolved" value="Resolved">
                <label class="form-check-label" for="Resolved">Resolved</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="status" id="Cancelled" value="Cancelled">
                <label class="form-check-label" for="Cancelled">Cancelled</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="status" id="NoStatus" value="NoStatus">
                <label class="form-check-label" for="NoStatus">No Status</label>
            </div>
        </div>
        <div class="col-md-2" style="flex-basis: content">
            <button type="submit" class="btn btn-primary">Search</button>
        </div>
    </fieldset>
</form>

<div class="container table-responsive">
    <table class="table table-striped table-bordered table-hover">
        <tr>
            <th class="text-center">
                <a href="OrderServlet?currentPage=<%=currentPage%>&recordsPerPage=<%=recordsPerPage%>&sortBy=ordernumber&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                    Order Number
                </a>
            </th>
            <th class="text-center">
                <a href="OrderServlet?currentPage=<%=currentPage%>&recordsPerPage=<%=recordsPerPage%>&sortBy=orderdate&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                    Order Date
                </a>
            </th>
            <th class="text-center">
                <a href="OrderServlet?currentPage=<%=currentPage%>&recordsPerPage=<%=recordsPerPage%>&sortBy=requireddate&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                    Required Date
                </a>
            </th>
            <th class="text-center">
                <a href="OrderServlet?currentPage=<%=currentPage%>&recordsPerPage=<%=recordsPerPage%>&sortBy=shippeddate&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                    Shipped Date
                </a>
            </th>
            <th class="text-center">
                <a href="OrderServlet?currentPage=<%=currentPage%>&recordsPerPage=<%=recordsPerPage%>&sortBy=status&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                    Status
                </a>
            </th>
            <th class="text-center">
                <a href="OrderServlet?currentPage=<%=currentPage%>&recordsPerPage=<%=recordsPerPage%>&sortBy=comments&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                    Comments
                </a>
            </th>
            <th class="text-center">
                <a href="OrderServlet?currentPage=<%=currentPage%>&recordsPerPage=<%=recordsPerPage%>&sortBy=customernumber&direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>">
                    Customer Number
                </a>
            </th>
            <th>Update</th>
            <th>Delete</th>
        </tr>
        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            if (orders.size() != 0) {
                for (Order o : orders) {
                    out.println("<tr>");
                    out.println("<td>" + o.getId() + "</td>");
                    out.println("<td>" + o.getOrderdate() + "</td>");
                    out.println("<td>" + o.getRequireddate() + "</td>");
                    out.println("<td>" + (o.getShippeddate() == null ? "" : o.getShippeddate()) + "</td>");
                    out.println("<td>" + o.getStatus() + "</td>");
                    out.println("<td>" + o.getComments() + "</td>");
                    out.println("<td>" + o.getCustomernumber() + "</td>");
                    out.println("<td><a href=\"EmployeeController?id=" + o.getId() + "\">Update</a></td>");
                    out.println("<td><a href=\"EmployeeController?id=" + o.getId() + "\">Delete</a></td>");
                    out.println("</tr>");
                }
            } else {
                out.println("<tr>");
                String status = "No records";
                for (int i = 0; i < 8; i++) {
                    out.println("<td>" + status + "</td>");
                }
                out.println("</tr>");
            }
        %>
    </table>
</div>
<nav class="container" aria-label="Navigation for staffs">
    <ul class="pagination justify-content-center">
        <%if (currentPage != 1 && nOfPages != 0) {%>
        <%
            out.println("<li class=\"page-item\">");
            out.println("<a class=\"page-link\" href=\"" + "OrderServlet?recordsPerPage=" + recordsPerPage + "&currentPage=1" + "&sortBy=" + sortBy + "&direction=" + direction + "\">First</a>");
            out.println("</li>");
        %>
        <li class="page-item">
            <%
                out.println("<a class=\"page-link\" href=\"" + "OrderServlet?recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage - 1) + "&sortBy=" + sortBy + "&direction=" + direction + "\">Previous</a>");
            %>
        </li>
        <%
            }
        %>
        <%
            if (currentPage < nOfPages) {
                out.println("<li class=\"page-item\">");
                out.println("<a class=\"page-link\" href=\"" + "OrderServlet?recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage + 1) + "&sortBy=" + sortBy + "&direction=" + direction + "\">Next</a>");
                out.println("</li>");
                out.println("<li class=\"page-item\">");
                out.println("<a class=\"page-link\" href=\"" + "OrderServlet?recordsPerPage=" + recordsPerPage + "&currentPage=" + nOfPages + "&sortBy=" + sortBy + "&direction=" + direction + "\">Last</a>");
                out.println("</li>");
            }
        %>
    </ul>
</nav>


<div class="container text-center">
    <%if (nOfPages != 0) {%>
    <p class="pageref"><%=currentPage%> of <%=nOfPages%></p>
    <%}%>
</div>
</div>
</body>
</html>