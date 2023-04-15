<%--
  Created by IntelliJ IDEA.
  User: san
  Date: 16/04/2023
  Time: 2:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Details</title>
    <style>
        body {
            background-color: #f2f2f2;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0,0,0,0.2);
            margin: 50px auto;
            max-width: 800px;
            padding: 30px;
        }

        h1 {
            color: #333;
            font-size: 36px;
            margin: 0;
        }

        h2 {
            color: #333;
            font-size: 24px;
            margin-top: 40px;
        }

        table {
            border-collapse: collapse;
            margin-top: 20px;
            width: 100%;
        }

        th, td {
            padding: 10px;
            text-align: left;
            vertical-align: top;
        }

        th {
            background-color: #333;
            color: #fff;
            font-size: 18px;
            font-weight: normal;
            text-transform: uppercase;
        }

        td {
            border-bottom: 1px solid #ccc;
            font-size: 16px;
        }

        .total {
            font-size: 20px;
            font-weight: bold;
            margin-top: 20px;
            text-align: right;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Customer Details</h1>
    <div>
        <h2>Customer 1</h2>
        <table>
            <tr>
                <th>Order ID</th>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
            <tr>
                <td>1</td>
                <td>Product 1</td>
                <td>2</td>
                <td>$20.00</td>
            </tr>
            <tr>
                <td>2</td>
                <td>Product 2</td>
                <td>1</td>
                <td>$15.00</td>
            </tr>
        </table>
        <div class="total">
            Total: $55.00
        </div>
    </div>
    <div>
        <h2>Customer 2</h2>
        <table>
            <tr>
                <th>Order ID</th>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
            <tr>
                <td>3</td>
                <td>Product 3</td>
                <td>3</td>
                <td>$10.00</td>
            </tr>
            <tr>
                <td>4</td>
                <td>Product 4</td>
                <td>1</td>
                <td>$25.00</td>
            </tr>
        </table>
        <div class="total">
            Total: $55.00
        </div>
    </div>
</div>
