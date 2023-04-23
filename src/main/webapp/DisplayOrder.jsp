<%@page import="java.util.List"%>
<%@ page import="com.utar.model.entity.Order" %>
<%@ page import="com.utar.model.sessionbean.OrderSessionBean" %>
<%@ page import="javax.ejb.EJB" %>
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
%>

<h1 class="text-center">
    Order Details
</h1>
<form class="container form-container" action="OrderServlet" method="post">
    <div class="row mb-3">
        <label class="col-sm-2 col-form-label">Order Number:</label>
        <div class="col input-group">
            <div class="input-group-text">#</div>
            <input type="number" class="form-control" name="ordernumber" placeholder="Order Number">
        </div>

        <label class="col-sm-2 col-form-label">Customer Number:</label>
        <div class="col input-group">
            <div class="input-group-text">#</div>
            <input type="number" class="form-control" name="customernumber" placeholder="Customer Number">
        </div>
    </div>

    <div class="row mb-3">
        <label class="col-sm-2 col-form-label">Order Date:</label>
        <div class="col input-group">
            <div class="input-group-text">From Date</div>
            <input type="date" class="form-control" name="formOrderDate"/>
        </div>
        <div class="col input-group">
            <div class="input-group-text">To Date</div>
            <input type="date" class="form-control" name="toOrderDate"/>
        </div>
    </div>

    <div class="row mb-3">
        <label class="col-sm-2 col-form-label">Required Date:</label>
        <div class="col input-group">
            <div class="input-group-text">From Date</div>
            <input type="date" class="form-control" name="formRequiredDate"/>
        </div>
        <div class="col input-group">
            <div class="input-group-text">To Date</div>
            <input type="date" class="form-control" name="toRequiredDate"/>
        </div>
    </div>

    <div class="row mb-3">
        <label class="col-sm-2 col-form-label">Shipped Date:</label>
        <div class="col input-group">
            <div class="input-group-text">From Date</div>
            <input type="date" class="form-control" name="formShippedDate"/>
        </div>
        <div class="col input-group">
            <div class="input-group-text">To Date</div>
            <input type="date" class="form-control" name="toShippedDate"/>
        </div>
    </div>

    <fieldset class="row mb-3 row">
        <legend class="col-form-label col-sm-2 pt-0">Status:</legend>
        <div class="col">
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="status" value="In Process">
                <label class="form-check-label">In Process</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="status" value="On Hold">
                <label class="form-check-label">On Hold</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="status" value="Disputed">
                <label class="form-check-label">Disputed</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="status" value="Resolved">
                <label class="form-check-label">Resolved</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="status" value="Shipped">
                <label class="form-check-label">Shipped</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="status" value="Cancelled">
                <label class="form-check-label">Cancelled</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="status" value="NoStatus">
                <label class="form-check-label">No Status</label>
            </div>
        </div>
        <div class="col-md-2 input-group" style="flex-basis: content" >
            <div class="input-group-text">Records per page</div>

            <input type="number" class="form-control" name="recordsPerPage" value="<%=recordsPerPage%>" placeholder="<%=recordsPerPage%>" max=<%=recordsPerPage*nOfPages%>>
        </div>
        <div class="col-md-2" style="flex-basis: content">
            <button type="submit" class="btn btn-primary">Search</button>
        </div>
    </fieldset>
</form>

<form id="searchForm" action="OrderServlet" method="post">
    <input type="hidden" name="currentPage" id="currentPage" value="<%=currentPage%>">
    <input type="hidden" name="sortBy" value="<%=sortBy%>">
    <input type="hidden" name="direction" value="<%=direction%>">
    <input type="hidden" name="nOfPages" id="nOfPages" value="<%=nOfPages%>">
<%--    <input type="hidden" name="ordernumber">--%>
<%--    <input type="hidden" name="customernumber">--%>
<%--    <input type="hidden" name="formOrderDate"/>--%>
<%--    <input type="hidden" name="toOrderDate"/>--%>
<%--    <input type="hidden" name="formRequiredDate"/>--%>
<%--    <input type="hidden" name="toRequiredDate"/>--%>
<%--    <input type="hidden" name="formShippedDate"/>--%>
<%--    <input type="hidden" name="toShippedDate"/>--%>
<%--    <input type="hidden" name="status" value="Shipped">--%>
    <input type="hidden" name="recordsPerPage" value="<%=recordsPerPage%>">

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
                    for (int i = 0; i < 9; i++) out.println("<td>No records</td>");
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
</script>
</body>
</html>