<!DOCTYPE html>
<html>
<head>
    <title>Order Details</title>
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
    <h1>Order Details</h1>
    <table>
        <tr>
            <th>Product</th>
            <th>Quantity</th>
            <th>Price</th>
        </tr>
        <tr>
            <td>Product 1</td>
            <td>2</td>
            <td>$20.00</td>
        </tr>
        <tr>
            <td>Product 2</td>
            <td>1</td>
            <td>$15.00</td>
        </tr>
        <tr>
            <td>Product 3</td>
            <td>3</td>
            <td>$10.00</td>
        </tr>
        <tr>
            <td>Product 4</td>
            <td>1</td>
            <td>$25.00</td>
        </tr>
    </table>
    <div class="total">
        Total: $95.00
    </div>
</div>
</body>
</html>