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

        select, input[type="text"], input[type="submit"], input[type="date"],button[type="reset"] {
            font-size: 1.2em;
            padding: 10px;
            margin: 5px;
            border: none;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        select:focus, input[type="text"]:focus, input[type="submit"]:focus,button[type="reset"], input[type="date"]:focus {
            outline: none;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
        }

        button[type="reset"] {
            background-color: red;
            color: white;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
        }

        button[type="reset"]:hover {
            background-color: darkred;
        }

        button[type="reset"]:hover {
            background-color: darkred;
        }


        input[type="submit"]:hover {
            background-color: #3e8e41;
        }

        button#home {
            background-color: lightblue;
            color: white;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
        }

        .range-select {
            display: none;
            flex-wrap: wrap;
            margin-top: 10px;
        }

        .range-select.show {
            display: flex;
        }

        .range-sel {
            display: none;
            flex-wrap: wrap;
            margin-top: 10px;
        }

        .range-sel.show {
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

    <%

        int nOfPages = (int) request.getAttribute("nOfPages");
        int currentPage = (int) request.getAttribute("currentPage");
        int recordsPerPage = (int) request.getAttribute("recordsPerPage");
        String direction = (String) request.getAttribute("direction");

    %>

    <script>

        function categorySelected() {
            var categorySelect = document.getElementById("category-select");
            var selectedValue = categorySelect.options[categorySelect.selectedIndex].value;
            var rangeSelect = document.getElementById("range-select");
            var rangeSelect1 = document.getElementById("range-sel");

            if (selectedValue == "date"  ) {
                rangeSelect.classList.add("show");
            }
            else if(selectedValue == "creditlimit" || selectedValue == "amount" ) {
                rangeSelect1.classList.add("show");
            }
                else {
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

        <h1> Payment Details </h1>
        <form action="PaymentServlet">
            <label for="category-select"></label>
            <select id="category-select" onchange="categorySelected()">
                <option value="customernumber">Customer Number</option>
                <option value="customername">Customer Name</option>
                <option value="checknumber">Check Number</option>
                <option value="phonenumber">Phone Number</option>
                <option value="creditlimit">Credit Limt</option>
                <option value="amount">Product Price</option>
                <option value="date">Payment Date</option>
            </select>


            <div id="range-select" class="range-select">

                <label for="from_date">From:</label>
                <input type="date" id="from_date" name="from_date">

                <label for="to_date">To:</label>
                <input type="date" id="to_date" name="to_date">
            </div>

            <div id="range-sel" class="range-sel">
                <label for="amount">Enter Amount Range</label>

                    <input id="amount"  type="button" value="less" ></input>
                <input id="more" type="button" value="greater" ></input>
                <input id="equal" type="button" value="equal" ></input>

            </div>

            <input type="text" name="customernumber" placeholder="Search..." id="search-now" >
            <input type="submit" value="Search">
            <div id="reset-home" >
            <button id="resetbtn" type="reset" value="Reset">Reset</button>
                <button id="home" type="reset" value="Home" >Home</button>
            </div>
            <input type="hidden" id="direction" name="direction" value= <%="ASC"%> >
            <input type="hidden" id="currentPage" name="currentPage" value= <%=currentPage%> >
            <input type="hidden" id="recordsPerPage" name="recordsPerPage" value= <%=recordsPerPage%> >
        </form>

        <script type="text/javascript">
            document.getElementById("home").onclick = function () {
                location.href = "index.html";
            };
            document.getElementById("resetbtn").onclick = function () {
                location.href = "PaymentServlet?direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>&currentPage=<%=currentPage%>&recordsPerPage=<%=recordsPerPage%>";
            };
        </script>

        <tr>
            <th>
                <a href="PaymentServlet?direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>&currentPage=<%=currentPage%>&recordsPerPage=<%=recordsPerPage%>">Customer Number</a>
            </th>
            <th>Customer Name</th>
            <th>Customer Phone</th>
            <th>Customer Credit Limit</th>
            <th>Check Number</th>
            <th>Payment Date</th>
            <th>Amount</th>
            <th>Update</th>
            <th>Delete</th>
        </tr>

</body>

</html>

        <%
            List<Object[]> list = (List<Object[]>) session.getAttribute("payment");
            if (list.size() != 0) {
                for (Object[] row : list) {
                    out.println("<tr>");
                    out.println("<td>" + row[0] + "</td>");
                    out.println("<td>" + row[1] + "</td>");
                    out.println("<td>" + row[2] + "</td>");
                    out.println("<td>" + row[3] + "</td>");
                    out.println("<td>" + row[4] + "</td>");
                    out.println("<td>" + row[5] + "</td>");
                    out.println("<td>" + row[6] + "</td>");
                    out.println("<td><a href=\"EmployeeController?id=" + row[0] + "\">Update</a></td>");
                    out.println("<td><a href=\"EmployeeController?id=" + row[0] + "\">Delete</a></td>");
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
<nav aria-label="Navigation for staffs">
    <ul class="pagination">
        <%if (currentPage != 1 && nOfPages != 0) {%>
        <%
            out.println("<li class=\"page-item\">");
            out.println("<a class=\"page-link\" href=\"" + "PaymentServlet?recordsPerPage=" + recordsPerPage + "&currentPage=1"  + "&direction=" + direction + "\">First</a>");
            out.println("</li>");
        %>
        <li class="page-item">
            <%
                out.println("<a class=\"page-link\" href=\"" + "PaymentServlet?recordsPerPage=" + recordsPerPage
                        + "&currentPage=" + (currentPage - 1)  + "&direction=" + direction + "\">Previous</a>");
            %>
        </li>
        <%
            }
        %>
        <%
            if (currentPage < nOfPages) {
                out.println("<li class=\"page-item\">");
                out.println("<a class=\"page-link\" href=\"" + "PaymentServlet?recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage + 1)  + "&direction=" + direction + "\">Next</a>");
                out.println("</li>");
                out.println("<li class=\"page-item\">");
                out.println("<a class=\"page-link\" href=\"" + "PaymentServlet?recordsPerPage=" + recordsPerPage + "&currentPage=" + nOfPages  + "&direction=" + direction + "\">Last</a>");
                out.println("</li>");
            }
        %>
    </ul>
</nav>
<%
    if (nOfPages != 0) {
        out.println("<p class=\"pageref\">");
        out.println(currentPage + " of " + nOfPages);
        out.println("</p>");
    }
%>

<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js"></script>
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
<script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>


</body>
</html>