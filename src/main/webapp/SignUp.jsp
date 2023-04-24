<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><!DOCTYPE html>
<html>
<head>
    <title>Sign Up Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .container {
            margin: 50px auto;
            max-width: 500px;
            padding: 35px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        h1 {
            text-align: center;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            width: 95%;
            padding: 10px;
            margin-bottom: 20px;
            border: none;
            border-radius: 4px;
            background-color: #f2f2f2;
        }

        button[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Sign Up</h1>
    <form action="SignUp" method="post">
        <label for="username">Username</label>
        <input type="text" id="username" name="username" required>
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>
        <label for="phone">Phone</label>
        <input type="text" id="phone" name="phone" required>
        <label for="address">Address Line 1</label>
        <input type="text" id="address" name="address" required>
        <label for="address">Address Line 2</label>
        <input type="text" id="address" name="address" required>
        <label for="city">City</label>
        <input type="text" id="city" name="city" required>
        <label for="state">State</label>
        <input type="text" id="state" name="state" required>
        <label for="zip">Postal Code</label>
        <input type="text" id="zip" name="zip" required>
        <label for="country">Country</label>
        <input type="text" id="country" name="country" required>

        <button type="submit">Sign Up</button>

        <%           String flag = (String) request.getAttribute("flag"); %>
        <%           if(flag == "True"){%>
                <br>
                <br>
        <label style="color: green">Your account has been successfully created.You will be redirect to home page shortly</label>

        <%
            response.setHeader("Refresh","3; URL=index.html");
        } else if (flag == "False"){ %>
        <br>
        <br>
        <label style="color: red">This username already taken please try other username</label>
        <% }%>
    </form>

</div>
</body>
</html>
