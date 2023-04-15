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
            max-width: 450px;
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
            width: 100%;
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
