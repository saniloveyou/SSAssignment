<%@ page import="java.util.Arrays" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String status = (String) request.getAttribute("status");
    String ordernumber = (String) request.getAttribute("ordernumber");
    String customernumber = (String) request.getAttribute("customernumber");
    String orderdate = (String) request.getAttribute("orderdate");
    String requireddate = (String) request.getAttribute("requireddate");
    String shippeddate = (String) request.getAttribute("shippeddate");
    String comments = (String) request.getAttribute("comments");
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
<form id="form1" class="container form-container" action="OrderServlet" method="post">
    <input type="hidden" name="action" value="updateOrder"/>
    <table>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Order Number:</label>
                <div class="col input-group">
                    <div class="input-group-text">#</div>
                    <input readonly type="number" class="form-control" name="ordernumber" placeholder="Order Number" value="<%=ordernumber%>">
                </div>

                <label class="col-sm-2 col-form-label">Customer Number:</label>
                <div class="col input-group">
                    <div class="input-group-text">#</div>
                    <input readonly type="number" class="form-control" name="customernumber" placeholder="Customer Number" value="<%=customernumber%>">
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Order Date:</label>
                <div class="col input-group">
                    <input readonly type="date" class="form-control" name="orderdate"  value="<%=orderdate%>"/>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Required Date:</label>
                <div class="col input-group">
                    <input required type="date" class="form-control" name="requireddate" value="<%=requireddate%>"/>
                </div>
            </div>

            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Shipped Date:</label>
                <div class="col input-group">
                    <input required type="date" class="form-control" name="shippeddate" value="<%=shippeddate%>"/>
                </div>
            </div>

        <div class="row mb-3">
            <label class="col-sm-2 col-form-label">Status:</label>
            <div class="col input-group">
                <select class="form-select" name="status">
                    <option value="In Process" <%if(status.equals("In Process")){%> selected <%}%>>In Process</option>
                    <option value="On Hold" <%if(status.equals("On Hold")){%> selected <%}%>>On Hold</option>
                    <option value="Disputed" <%if(status.equals("Disputed")){%> selected <%}%>>Disputed</option>
                    <option value="Resolved" <%if(status.equals("Resolved")){%> selected <%}%>>Resolved</option>
                    <option value="Shipped" <%if(status.equals("Shipped")){%> selected <%}%>>Shipped</option>
                    <option value="Cancelled" <%if(status.equals("Cancelled")){%> selected <%}%>>Cancelled</option>
                </select>
            </div>

        </div>

        <div class="row mb-3">
            <label class="col-sm-2 col-form-label">Comments:</label>
            <div class="col input-group">
                <textarea class="form-control" name="comments" placeholder="Comments" rows="3"><%=comments%></textarea>
            </div>
        </div>


        <div class="col-md-2" style="flex-basis: content">
            <input type="submit" class="btn btn-primary" value="Update"/>
            <a href="OrderServlet?currentPage=1&recordsPerPage=20&sortBy=ordernumber&direction=asc" class="btn btn-danger">Cancel</a>
        </div>
    </table>
</form>
</body>
</html>
