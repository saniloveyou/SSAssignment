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

<style>
    .input-row1 {
        display: inline-block;
        vertical-align: top;
        margin-right: 20px;
        width: 30px;
        text-align: left;
    }
    .input-row {
        display: inline-block;
        vertical-align: top;
        margin-right: 20px;
        width: 83%;
        text-align: left;
    }

</style>

<%
String customernumber = session.getAttribute("customernumber").toString();
%>

<style>
    #btnuser {
        background-color: green;
        color: white;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
    }

    #btnuser.green {
        background-color: red;
    }

</style>

<body>






<div class="container">
    <div style="text-align: center; ;">
        <h1 style="display: inline-block;" >Sign Up</h1>
    </div>
    <form action="SignUp" method="post">


        <div class="input-group">
            <div class="input-row1">
                <label  for="ids">ID</label>
                <br>
                <input readonly  type="text" id="ids" name="ids" required style="width: 100%;">
            </div>
            <div class="input-row">
                <label for="username">Username</label>
                <br>
                <input type="text" id="username" name="username" required style="width: 100%;">
            </div>
        </div>
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>
        <label for="firstname">First Name</label>
        <input type="text" id="firstname" name="firstname" required>
        <label for="lastname">Last Name</label>
        <input type="text" id="lastname" name="lastname" required>
        <label for="phone">Phone</label>
        <input type="text" id="phone" name="phone" required>
        <label for="address">Address Line 1</label>
        <input type="text" id="address" name="address1" required>
        <label for="address">Address Line 2</label>
        <input type="text" id="address" name="address2" required>
        <label for="city">City</label>
        <input type="text" id="city" name="city" required>
        <label for="state">State</label>
        <input type="text" id="state" name="state" required>
        <label for="zip">Postal Code</label>
        <input type="text" id="zip" name="zip" required>
        <label for="country">Country</label>
        <input type="text" id="country" name="country" required>
        <label for="creditlimit">Credit Limit</label>
        <input type="text" id="creditlimit" name="creditlimit" required>
<div><button type="submit">Sign Up</button></div>


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

    <script>

        document.getElementById("ids").value = <%=customernumber%>;
        var button = document.getElementById("btnuser");

        button.addEventListener("click", function() {
            if (button.classList.contains("green")) {
                button.classList.remove("green");
                button.value = "admin";
            } else {
                button.classList.add("green");
                button.value = "user";

            }
        });
    </script>


</div>
</body>
</html>
