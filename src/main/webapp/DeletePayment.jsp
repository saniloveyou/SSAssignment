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

<%
String paymentID = request.getParameter("id");
%>

<div class="container">
  <h1>Payment Delete</h1>
    <p>Are you sure you want to delete the payment <%=paymentID%></p>
    <button onclick="window.location.href='DeletePayment?id=<%=paymentID%>'">Yes</button>
    <button onclick="window.location.href='index.html'">No</button>
</div>
</body>
</html>



