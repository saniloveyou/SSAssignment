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
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin: 0;
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
        h1 {
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            margin: 50px 0;
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
        input[type=text], select {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type=submit] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type=submit]:hover {
            background-color: #45a049;
        }

        div.container {
            border-radius: 5px;
            background-color: #f2f2f2;
            padding: 20px;
            margin-top: 20px;
        }

        form {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
            margin: 50px 0;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
            border-radius: 4px;
        }

        select, input[type="text"], input[type="submit"], input[type="date"] {
            font-size: 1.2em;
            padding: 10px;
            margin: 5px;
            border: none;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        select:focus, input[type="text"]:focus, input[type="submit"]:focus, input[type="date"]:focus {
            outline: none;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
        }

        input[type="submit"]:hover {
            background-color: #3e8e41;
        }

        .range-select {
            display: none;
            flex-wrap: wrap;
            margin-top: 10px;
        }

        .range-select.show {
            display: flex;
        }

        label {
            font-weight: bold;
            margin: 5px;
        }

        @media (max-width: 768px) {
            form {
                flex-direction: column;
                box-shadow: none;
                padding: 0;
                background-color: transparent;
            }
        }

    </style>

    <script>

        function categorySelected() {
            var categorySelect = document.getElementById("category-select");
            var selectedValue = categorySelect.options[categorySelect.selectedIndex].value;
            var rangeSelect = document.getElementById("range-select");

            if (selectedValue == "date" || selectedValue == "price") {
                rangeSelect.classList.add("show");
            } else {
                console.log("this here"+selectedValue);
                document.getElementById("search-now").setAttribute("name",selectedValue);
                rangeSelect.classList.remove("show");
            }
        }
    </script>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css">
</head>
<body class="m-3">

<div class="row col-md-6">
    <table class="table table-striped table-bordered table-sm">
        <tr>
            <th>Customer Number</th>
            <th>Customer Name</th>
            <th>Check Number</th>
            <th>Payment Date</th>®®
            <th>Amount</th>®
            <th>Update</th>
            <th>Delete</th>
        </tr>

        <h1>Search Products by Category</h1>
        <form>
            <label for="category-select"></label>
            <select id="category-select" onchange="categorySelected()">
                <option value="customernumber">Customer Number</option>
                <option value="customername">Customer Name</option>
                <option value="checknumber">Check Number</option>
                <option value="date">Payment Date</option>
            </select>

            <input type="text" name="customernumber" placeholder="Search..." id="search-now" >
            <input type="submit" value="Search">

            <div id="range-select" class="range-select">

                <label for="from_date">From:</label>
                <input type="date" id="from_date" name="from_date">

                <label for="to_date">To:</label>
                <input type="date" id="to_date" name="to_date">
            </div>
        </form>
</body>

</html>

        <%
            List<Object[]> list = (List<Object[]>) session.getAttribute("payment");

            for (Object[] row : list) {
                out.println("<tr>");
                out.println("<td>" + row[0] + "</td>");
                out.println("<td>" + row[1] + "</td>");
                out.println("<td>" + row[2] + "</td>");
                out.println("<td>" + row[3]+ "</td>");
                out.println("<td>" + row[4] + "</td>");
                out.println("<td><a href=\"EmployeeController?id=" +  row[0] + "\">Update</a></td>");
                out.println("<td><a href=\"EmployeeController?id=" +  row[0] + "\">Delete</a></td>");
                out.println("</tr>");
            }
        %>
    </table>
</div>
<%--<nav aria-label="Navigation for staffs">--%>
<%--    <ul class="pagination">--%>
<%--        <%--%>
<%--            if (currentPage != 1) {--%>
<%--        %>--%>
<%--        Observe the components in the link--%>
<%--        <%--%>
<%--            out.println("<li class=\"page-item\">");--%>
<%--            out.println("<a class=\"page-link\" href=\"" + "PaginationServlet?recordsPerPage=" + recordsPerPage--%>
<%--                    + "&currentPage=1" + "\">First</a>");--%>
<%--            out.println("</li>");--%>
<%--        %>--%>
<%--        <li class="page-item">--%>
<%--            <%--%>
<%--                out.println("<a class=\"page-link\" href=\"" + "PaginationServlet?recordsPerPage=" + recordsPerPage--%>
<%--                        + "&currentPage=" + (currentPage - 1) + "\">Previous</a>");--%>
<%--            %>--%>
<%--        </li>--%>
<%--        <%--%>
<%--            }--%>
<%--        %>--%>
<%--        <%--%>
<%--        %>--%>
<%--        <%--%>
<%--            if (currentPage < nOfPages) {--%>
<%--                out.println("<li class=\"page-item\">");--%>
<%--                out.println("<a class=\"page-link\" href=\"" + "PaginationServlet?recordsPerPage=" + recordsPerPage--%>
<%--                        + "&currentPage=" + (currentPage + 1) +--%>
<%--                        "\">Next</a>");--%>
<%--                out.println("</li>");--%>
<%--                out.println("<li class=\"page-item\">");--%>
<%--                out.println("<a class=\"page-link\" href=\"" + "PaginationServlet?recordsPerPage=" + recordsPerPage--%>
<%--                        + "&currentPage=" + nOfPages + "\">Last</a>");--%>
<%--                out.println("</li>");--%>
<%--            }--%>
<%--        %>--%>
<%--    </ul>--%>
<%--</nav>--%>
<%--<%--%>
<%--    out.println("<p class=\"pageref\">");--%>
<%--    out.println(currentPage + " of " + nOfPages);--%>
<%--    out.println("</p>");--%>
<%--%>--%>
<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js"></script>
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
<script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>


</body>
</html>