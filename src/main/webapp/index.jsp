<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1>Username: <%= session.getAttribute("username").toString() %></h1>
<h1>Role: <%= session.getAttribute("user_role").toString() %></h1>
<br/>
</body>
</html>