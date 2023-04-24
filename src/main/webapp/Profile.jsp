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
            /*background-color: #f2f2f2;*/
            /*    make the background size to be smaller*/


        }

        form {

            background-color: lightblue;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
            border-radius: 4px;
            width: 120%;

        }

        select, input[type="text"], input[type="submit"], input[type="date"],button[type="reset"] {
            font-size: 1.2em;
            padding: 10px;
            margin: 5px;
            border: none;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 10%;
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
            width: 20%;
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
        a {
            color: blue;

        }
        @media (max-width: 768px) {
            form {
                flex-direction: column;
                box-shadow: none;
                padding: 0;
                background-color: transparent;
            }
        }
        ::-webkit-scrollbar {
            width: 8px;
        }

        /* Track */
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        /* Handle */
        ::-webkit-scrollbar-thumb {
            background: #888;
        }

        /* Handle on hover */
        ::-webkit-scrollbar-thumb:hover {
            background: #555;
        }

        @import url('https://fonts.googleapis.com/css?family=Montserrat:400,700&display=swap');
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            list-style: none;
            font-family: 'Montserrat', sans-serif
        }

        body {
            padding: 5px
        }

        p {
            margin: 0%
        }

        .container {
            max-width: 900px;
            margin: 20px auto;
            overflow: hidden
        }


        .box-1 img.pic {
            width: 20px;
            height: 20px;
            object-fit: cover
        }

        .box-1 img.mobile-pic {
            width: 100%;
            height: 200px;
            object-fit: cover
        }

        .box-1 .name {
            font-size: 11px;
            font-weight: 600
        }

        .dis {
            font-size: 12px;
            font-weight: 500
        }

        .box-2 {
            /*   make the div to be center */
            margin: 0 auto;
            max-width: 450px;
            padding: 10px 40px;
            user-select: none
            /*width: 100%;*/

        }

        .box-2 .box-inner-2 input.form-control {
            font-size: 12px;
            font-weight: 600;
            width: 100%;
        }

        .box-2 .box-inner-2 .inputWithIcon {
            position: relative
        }

        .box-2 .box-inner-2 .inputWithIcon span {
            position: absolute;
            left: 15px;
            top: 8px
        }

        .box-2 .box-inner-2 .inputWithcheck {
            position: relative
        }

        .box-2 .box-inner-2 .inputWithcheck span {
            position: absolute;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background-color: green;
            font-size: 12px;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            right: 15px;
            top: 6px
        }

        .form-control:focus, .form-select:focus {
            box-shadow: none;
            outline: none;
            border: 1px solid #7700ff
        }

        .border:focus-within {
            border: 1px solid #7700ff !important
        }

        .box-2 .card-atm .form-control {
            border: none;
            box-shadow: none
        }

        .form-select {
            border-radius: 0;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px
        }

        .address .form-control.zip {
            border-radius: 0;
            border-bottom-left-radius: 10px
        }

        .address .form-control.state {
            border-radius: 0;
            border-bottom-right-radius: 10px
        }

        .box-2 .box-inner-2 .btn.btn-outline-primary {
            width: 120px;
            padding: 10px;
            font-size: 11px;
            padding: 0% !important;
            display: flex;
            align-items: center;
            border: none;
            border-radius: 0;
            background-color: whitesmoke;
            color: black;
            font-weight: 600
        }

        .box-2 .box-inner-2 .btn.btn-primary {
            background-color: #7700ff;
            color: whitesmoke;
            font-size: 14px;
            display: flex;
            align-items: center;
            font-weight: 600;
            justify-content: center;
            border: none;
            padding: 5px
        }

        .box-2 .box-inner-2 .btn.btn-primary:hover {
            background-color: #7a34ca
        }

        .box-2 .box-inner-2 .btn.btn-primary .fas {
            font-size: 13px !important;
            color: whitesmoke
        }

        .carousel-indicators [data-bs-target] {
            width: 10px;
            height: 10px;
            border-radius: 50%
        }


        .carousel-item img {
            object-fit: cover;
            height: 100%
        }


        .carousel-control-prev:hover .fas.fa-arrow-left {
            transform: translateX(-5px)
        }


        .carousel-control-next:hover .fas.fa-arrow-right {
            transform: translateX(5px)
        }

        .fas.fa-arrow-left, .fas.fa-arrow-right {
            font-size: 0.8rem;
            transition: all .2s ease
        }



        .fas.fa-times {
            color: red
        }

        .fas, .fab {
            color: #6d6c6d
        }

        ::placeholder {
            font-size: 12px
        }

        .couponCode {
            text-transform: uppercase;
            font-size: 0.7rem
        }

        #code {
            pointer-events: none;
            font-weight: 600
        }

        .close {
            cursor: pointer
        }


        @keyframes moving {
            0% {
                opacity: 0;
                transform: translateX(-500px)
            }
            100% {
                opacity: 1;
                transform: translateX(0px)
            }
        }

        .box-2 {
            transform: translateY(-500px);
            animation: img-top 2.5s;
            animation-fill-mode: forwards
        }



        @keyframes img-top {
            0% {
                opacity: 0;
                transform: translateY(-500px)
            }
            100% {
                opacity: 1;
                transform: translateY(0px)
            }
        }

        @media (max-width: 768px) {
            .container {
                max-width: 700px;
                margin: 10px auto
            }

            .box-1, .box-2 {
                max-width: 600px;
                padding: 20px 90px;
                margin: 20px auto
            }

            .box-2 {
                transform: translateX(-500px);
                animation: box-side 2.6s;
                animation-fill-mode: forwards
            }

            @keyframes box-side {
                0% {
                    opacity: 0;
                    transform: translateX(-500px)
                }
                100% {
                    opacity: 1;
                    transform: translateX(0px)
                }
            }
        }

        @media (max-width: 426px) {
            .box-1, .box-2 {
                max-width: 400px;
                padding: 20px 10px
            }

            ::placeholder {
                font-size: 9px
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
            rangeSelect.classList.remove("show");
            rangeSelect1.classList.remove("show");
            if (selectedValue == "date"  ) {
                rangeSelect.classList.add("show");
            }
            else if(selectedValue == "creditlimit" ) {
                rangeSelect1.classList.add("show");
                document.getElementById("search-now").setAttribute("value",selectedValue);
                document.getElementById("search-now").setAttribute("name",selectedValue);
            }
            else {
                rangeSelect.classList.remove("show");
                document.getElementById("search-now").setAttribute("name",selectedValue);
            }
        }
    </script>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css">
</head>
<body class="m-3">


<div class="">
    <table class="table table-striped table-bordered table-sm">

        <h1> Customer Details </h1>
        <form action="Profile">
            <label for="category-select"></label>
            <select id="category-select" onchange="categorySelected()">
                <option value="customernumber">Customer Number</option>
                <option value="customername">Customer Name</option>
                <option value="phonenumber">Phone Number</option>
                <option value="Address">Address 1</option>
                <option value="Address">Address 2</option>
                <option value="City">City</option>
                <option value="State">State</option>
                <option value="postal">Postal code</option>
                <option value="Country">Country</option>
                <option value="Limit">Credit limit</option>
            </select>


            <div id="range-sel" class="range-sel">
                <div>
                    <label for="minamount">Minimum Amount Range</label>
                    <input type="range" id="minamount" name="minamount" min="0" max="500000" step="100" value="0">
                    <label for="minamount">Amount: </label>
                    <output for="minamount" id="minamount-output">0</output>
                </div>
                <div>
                    <label for="maxamount">Maximum Amount Range</label>
                    <input type="range" id="maxamount" name="maxamount" min="0" max="200000" step="100" value="0">
                    <label for="maxamount">Amount: </label>
                    <output for="maxamount" id="maxamount-output">0</output>
                </div>
            </div>


            <input type="text" name="customernumber" placeholder="Search..." id="search-now" >
            <input type="submit" value="Search" id="search-it">
            <div id="reset-home" >
                <button id="resetbtn" type="reset" value="Reset">Reset</button>
                <button id="home" type="reset" value="Home" >Home</button>
            </div>

        </form>

        <script>
            let amount = 0;
            let amount1 = 0;
            amount = document.getElementById("minamount");
            amount1 = document.getElementById("maxamount");
            const amountOutput = document.getElementById("minamount-output");
            const amountOutput1 = document.getElementById("maxamount-output");

            amount.addEventListener("input", function () {
                amountOutput.innerHTML = amount.value;
            });
            amount1.addEventListener("input", function () {
                amountOutput1.innerHTML = amount1.value;
            });

            document.getElementById("search-it").onclick = function (event) {
                if (amount.value > amount1.value) {
                    alert("Minimum amount should be less than maximum amount")
                    event.preventDefault();
                }
            };
        </script>

        <script type="text/javascript">
            document.getElementById("home").onclick = function () {
                location.href = "index.html";
            };
            document.getElementById("resetbtn").onclick = function () {
                location.href = "Profile?direction=<%="ASC"%>&currentPage=<%=currentPage%>&recordsPerPage=<%=recordsPerPage%>";
            };
        </script>



        <tr>
            <th>
                <a href="Profile?direction=<%=(direction.equals("ASC") ? "DESC" : "ASC")%>&currentPage=<%=currentPage%>&recordsPerPage=<%=recordsPerPage%>">Customer Number</a>
            </th>
            <th>Customer Name</th>
            <th>Customer Last Name</th>
            <th>Customer First Name</th>
            <th>Phone</th>
            <th>Address Line 1</th>
            <th>Address Line 2</th>
            <th>City</th>
            <th>State</th>
            <th>Postal</th>
            <th>Country</th>
            <th>Sales Rep</th>
            <th>Credit Limit</th>
            <th>Update</th>
        </tr>

</body>

</html>

<%
    List<Object[]> list = (List<Object[]>) session.getAttribute("customer");
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
            out.println("<td>" + row[7] + "</td>");
            out.println("<td>" + row[8] + "</td>");
            out.println("<td>" + row[9] + "</td>");
            out.println("<td>" + row[10] + "</td>");
            out.println("<td>" + row[11] + "</td>");
            out.println("<td>" + row[12] + "</td>");

            out.println("<td><button onclick=\"openForm('"+ row[0] + "','" + row[1] + "','" + row[2] + "','" + row[3] +"','" + row[4]  +"','" + row[5] + "','" + row[6] + "','" + row[7] + "','" + row[8] + "','" + row[9] +"','" + row[10]  +"','" + row[11] + "','" + row[12] +"'  )\" > Update</button></td>");
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

<%--store value in session storage--%>
<%
    session.setAttribute("currentPage", currentPage);
    session.setAttribute("recordsPerPage", recordsPerPage);
    session.setAttribute("direction", direction);
%>
<nav aria-label="Navigation for staffs">
    <ul class="pagination">
        <%if (currentPage != 1 && nOfPages != 0) {%>
        <%
            out.println("<li class=\"page-item\">");
            out.println("<a class=\"page-link\" href=\"" + "Profile?recordsPerPage=" + recordsPerPage + "&currentPage=1"  + "&direction=" + direction + "\">First</a>");
            out.println("</li>");
        %>
        <li class="page-item">
            <%
                out.println("<a class=\"page-link\" href=\"" + "Profile?recordsPerPage=" + recordsPerPage
                        + "&currentPage=" + (currentPage - 1)  + "&direction=" + direction + "\">Previous</a>");
            %>
        </li>
        <%
            }
        %>
        <%
            if (currentPage < nOfPages) {
                out.println("<li class=\"page-item\">");
                out.println("<a class=\"page-link\" href=\"" + "Profile?recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage + 1)  + "&direction=" + direction + "\">Next</a>");
                out.println("</li>");
                out.println("<li class=\"page-item\">");
                out.println("<a class=\"page-link\" href=\"" + "Profile?recordsPerPage=" + recordsPerPage + "&currentPage=" + nOfPages  + "&direction=" + direction + "\">Last</a>");
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

<style>
    .fw-bold:first-child {
        float: left;
    }
    .fw-bold:last-child {
        float: right;
    }
</style>

<div class="form-popup" id="myForm">
    <div class="container d-lg-flex">
        <div class="box-2">
            <div class="box-inner-2">
                <form  action="Profile" method="post">
                    <div style="overflow: auto;">
                        <p class="fw-bold left"><strong>Update Customer Details</strong></p>
                        <p onclick="closeForm()" style="color: red" class="fw-bold right"><strong>X</strong></p>
                    </div>

                    <div>
                        <div class="mb-3"><p class="dis fw-bold mb-2">Customer Number</p>
                            <input readonly class="form-control" type="text" id="row0" name="row0"
                                   value=""></div>
                        <div class="mb-3"><p class="dis fw-bold mb-2">Customer Name</p>
                            <input  class="form-control" type="text" id="row1" name="row1"
                                   value=""></div>
                        <div class="mb-3"><p class="dis fw-bold mb-2">Customer Last Name</p>
                            <input  class="form-control" type="text" id="row2" name="row2"
                                   value=""></div>
                        <div class="mb-3"><p class="dis fw-bold mb-2">Customer First Name</p>
                            <input class="form-control" type="text" required id="row3" name="row3"
                                   value=""></div>
                        <div class="mb-3"><p class="dis fw-bold mb-2">Phone</p>
                            <input class="form-control" type="text"   required id="row4" name="row4"
                                   value="2017-06-01"></div>
                        <div class="mb-3"><p class="dis fw-bold mb-2">Address Line 1</p>
                            <input class="form-control" type="text"   required id="row5" name="row5"
                                   value="12345"></div>
                        <div  class="mb-3"><p class="dis fw-bold mb-2">Address Line 2</p>
                            <input  class="form-control" type="text" id="row6" name="row6"
                                   value="5"></div>
                        <div  class="mb-3"><p class="dis fw-bold mb-2">City</p>
                            <input  class="form-control" type="text" id="row7" name="row7"
                                   value="5"></div>

                        <div  class="mb-3"><p class="dis fw-bold mb-2">State</p>
                            <input  class="form-control" type="text" id="row8" name="row8"
                                   value="5"></div>

                        <div  class="mb-3"><p class="dis fw-bold mb-2">Postal</p>
                            <input  class="form-control" type="text" id="row9" name="row9"
                                   value="5"></div>

                        <div  class="mb-3"><p class="dis fw-bold mb-2">Country</p>
                            <input  class="form-control" type="text" id="row10" name="row10"
                                   value="5"></div>

                        <div  class="mb-3"><p class="dis fw-bold mb-2">Sales Rep</p>
                            <input readonly class="form-control" type="text" id="row11" name="row11"
                                   value="5"></div>

                        <div  class="mb-3"><p class="dis fw-bold mb-2">Credit Limit</p>
                            <input  class="form-control" type="text" id="row12" name="row12"
                                   value="5"></div>



                            <div  class="btn btn-primary mt-2"><span class="fas fa-dollar-sign px-1">  <input style=" background-color: #7700ff; width: 100%" type="submit" value="Update" > </span>
                            </div>

                        </div>
                    </div>
            </div>
            </form>
        </div>
    </div>
</div>

</div>


<script>
    function openForm(id,name,first,last,phone,add1,add2,city,state,postal,country,salesrep,creditlimit) {
        var random = Math.floor(Math.random() * 3000) + 2000;
        document.getElementById("myForm").style.display = "block";
        document.getElementById("row0").value = id;
        document.getElementById("row1").value = name;
        document.getElementById("row2").value = first;
        document.getElementById("row3").value = last;
        document.getElementById("row4").value = phone;
        document.getElementById("row5").value = add1;
        document.getElementById("row6").value = add2;
        document.getElementById("row7").value = city;
        document.getElementById("row8").value = state;
        document.getElementById("row9").value = postal;
        document.getElementById("row10").value = country;
        document.getElementById("row11").value = salesrep;
        document.getElementById("row12").value = creditlimit;

        // document.getElementById("p1").innerHTML = productamount;
        // document.getElementById("p2").innerHTML = random.toString();
        //
        // //conver the string to number
        // var productamount = parseFloat(productamount);
        // var random = parseInt(random);
        // document.getElementById("p3").innerHTML = (productamount-random).toFixed(2).toString();

    }



    function closeForm() {
        document.getElementById("myForm").style.display = "none";
    }
</script>


</body>
</html>