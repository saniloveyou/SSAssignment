<%@page import="java.util.List"%>
<%@ page import="com.utar.model.entity.Employee" %>
<%@ page import="com.utar.model.entity.Product" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        /* Button used to open the contact form - fixed at the bottom of the page */
        .open-button {
            background-color: #555;
            color: white;
            padding: 16px 20px;
            border: none;
            cursor: pointer;
            opacity: 0.8;
            position: fixed;
            bottom: 23px;
            right: 28px;
            width: 280px;
        }
        /* The popup form - hidden by default */
        .form-popup {
            overflow-x: hidden;
            overflow-y: auto;
            height: 400px;
            display: none;
            position: fixed;
            top: 60%;
            left: 50%;
            -webkit-transform: translate(-50%, -50%);
            transform: translate(-50%, -50%);
        }
        /* Add styles to the form container */
        .form-container {
            max-width: 500px;
            padding: 10px;
            background-color: white;
        }
        /* Full-width input fields */
        .form-container input[type=text], .form-container input[type=password] {
            width: 100%;
            padding: 15px;
            margin: 5px 0 22px 0;
            border: none;
            background: #f1f1f1;
        }
        /* When the inputs get focus, do something */
        .form-container input[type=text]:focus, .form-container input[type=password]:focus
        {
            background-color: #ddd;
            outline: none;
        }
        /* Set a style for the submit button */
        .form-container .btn {
            background-color: #4CAF50;
            color: white;
            padding: 16px 20px;
            border: none;
            cursor: pointer;
            width: 100%;
            margin-bottom: 10px;
            opacity: 0.8;
        }
        /* Add a red background color to the cancel button */
        .form-container .cancel {
            background-color: red;
        }
        /* Add some hover effects to buttons */
        .form-container .btn:hover, .open-button:hover {
            opacity: 1;
        }
        .pageref {
            text-align: center;
            font-weight: bold;
        }
    </style>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css">
</head>
<body class="m-3">
<%
    int currentPage = (int) request.getAttribute("currentPage");
    int recordsPerPage = (int) request.getAttribute("recordsPerPage");
    int nOfPages = (int) request.getAttribute("nOfPages");
%>
<div class="row col-md-6">
    <table class="table table-striped table-bordered table-sm">
        <tr>
            <th>ID</th>
            <th>Product Name</th>
            <th>Product line</th>
            <th>Quantity</th>
            <th>Vendor</th>
            <th>Price</th>
            <th>Update</th>
            <th>Delete</th>
        </tr>
        <%
            List<Product> Products = (List<Product>) request.getAttribute("list");
            for (Product t : Products) {
                out.println("<tr>");
                out.println("<td>" + t.getId() + "</td>");
                out.println("<td>" + t.getProductname() + "</td>");
                out.println("<td>" + t.getProductline().getId() + "</td>");
                out.println("<td>" + t.getQuantityinstock()+ "</td>");
                out.println("<td>" + t.getProductvendor() + "</td>");
                out.println("<td>" + t.getBuyprice() + "</td>");
                out.println("<td><a href=\"EmployeeController?id=" + t.getId() + "\">Update</a></td>");
                out.println("<td><a href=\"EmployeeController?id=" + t.getId() + "\">Delete</a></td>");
                out.println("</tr>");
            }
        %>
    </table>
</div>
<nav aria-label="Navigation for staffs">
    <ul class="pagination">
        <%
            if (currentPage != 1) {
        %>
        Observe the components in the link
        <%
            out.println("<li class=\"page-item\">");
            out.println("<a class=\"page-link\" href=\"" + "PaginationServlet?recordsPerPage=" + recordsPerPage
                    + "&currentPage=1" + "\">First</a>");
            out.println("</li>");
        %>
        <li class="page-item">
            <%
                out.println("<a class=\"page-link\" href=\"" + "PaginationServlet?recordsPerPage=" + recordsPerPage
                        + "&currentPage=" + (currentPage - 1) + "\">Previous</a>");
            %>
        </li>
        <%
            }
        %>
        <%
        %>
        <%
            if (currentPage < nOfPages) {
                out.println("<li class=\"page-item\">");
                out.println("<a class=\"page-link\" href=\"" + "PaginationServlet?recordsPerPage=" + recordsPerPage
                        + "&currentPage=" + (currentPage + 1) +
                        "\">Next</a>");
                out.println("</li>");
                out.println("<li class=\"page-item\">");
                out.println("<a class=\"page-link\" href=\"" + "PaginationServlet?recordsPerPage=" + recordsPerPage
                        + "&currentPage=" + nOfPages + "\">Last</a>");
                out.println("</li>");
            }
        %>
    </ul>
</nav>
<%
    out.println("<p class=\"pageref\">");
    out.println(currentPage + " of " + nOfPages);
    out.println("</p>");
%>
<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js"></script>
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
<script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>

<button class="open-button" onclick="openForm()">Open Form</button>
<div class="form-popup" id="myForm">
    <form action="EmployeeController" class="form-container" method="post">
        <h1>Add Employee</h1>
        <fieldset>
            <legend>Add Employee Details:</legend>
            <br> First Name:
            <input type="text" name="fname" /> <br>
            Last Name: <input type="text" name="lname" /> <br>
            Gender: <input type="text" name="gender" /> <br>
            DOB: <input type="text" name="dob" />
            <br> Hired Date: <input type="text" name="hdate" />
        </fieldset>
        <button type="submit" class="btn">Submit Test</button>
        <button type="button" class="btn cancel" onclick="closeForm()">Close</button>
        <button type="reset" class="btn">Reset</button>
    </form>
</div>
<script>
    function openForm() {
        document.getElementById("myForm").style.display = "block";
    }
    function closeForm() {
        document.getElementById("myForm").style.display = "none";
    }
</script>
</body>
</html>