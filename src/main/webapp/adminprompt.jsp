<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>
<head>
  <title>Account Created</title>
  <style>
    body {
      background-color: #f2f2f2;
      font-family: Arial, sans-serif;
    }

    .container {
      margin: auto;
      width: 400px;
      padding: 20px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }

    h1 {
      text-align: center;
      color: #333;
    }

    p {
      text-align: center;
      color: #333;
    }

    button {
      background-color: #4CAF50;
      color: white;
      padding: 14px 20px;
      margin: 8px 0;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      width: 100%;
    }

    button:hover {
      background-color: #45a049;
    }

    @media screen and (max-width: 600px) {
      .container {
        width: 80%;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Please login as user</h1>
  <p>Your Login as an admin please login as a user to continue purchasing</p>
  <h1>Username: <%= session.getAttribute("username").toString() %></h1>
  <h1>Role: <%= session.getAttribute("user_role").toString() %></h1>
  <button onclick="window.location.href='index.html'">Return Home</button>
</div>
</body>
</html>



