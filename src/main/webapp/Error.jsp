<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 16/4/2023
  Time: 4:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Error</title>
</head>
<body>
<%out.print(request.getAttribute("error"));%>
</body>
</html>