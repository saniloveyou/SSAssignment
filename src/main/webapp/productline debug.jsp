<%@ page import="com.utar.model.entity.Productline" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 4/20/2023
  Time: 3:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Debug</title>
</head>
<body>
<%
    Productline pl = (Productline) request.getAttribute("String");


%>
<h2><%=pl.getId()%></h2>
<h2><%=pl.getTextdescription()%></h2>
<h2><%=pl.getHtmldescription()%></h2>
<h2><%=pl.getImage()%></h2>
</body>
</html>
