<%@ page import="com.utar.model.entity.Productline" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 4/18/2023
  Time: 9:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Update Product Information</title>
    <style>
        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }
        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        tr:nth-child(even) {
            background-color: #dddddd;
        }
    </style>
</head>
<body>

<%
    Productline productline = (Productline) request.getAttribute("productline");
%>
<form action="ProductlineController" method="post">
    <table>
        <tr>
            <td>Productline</td>
            <td>
                <%
                    out.println("<textarea name=\"productline\" cols=\"50\" >" + productline.getId() +"</textarea>");
                %>
            </td>
        </tr>
        <tr>
            <td>Text Description</td>
            <td>
                <%
                    out.println("<textarea name=\"textDescription\" cols=\"50\" >" + productline.getTextdescription() +"</textarea>");
                %>
            </td>
        </tr>
        <tr>
            <td>HTML Description</td>
            <td>
                <%
                    out.println("<textarea name=\"htmlDescription\" cols=\"50\" >" + productline.getHtmldescription() +"</textarea>");
                %>
            </td>
        </tr>
        <tr>
            <td>Image</td>
            <td>
                <%
                    out.println("<input type=\"text\" name=\"image\" " + productline.getImage() +">");
                %>
            </td>
        </tr>
    </table>
    <input type="submit" name="UPDATE" value="UPDATE" />
    <input type="submit" name="DELETE" value="DELETE" />
</form>
</body>
</html>
