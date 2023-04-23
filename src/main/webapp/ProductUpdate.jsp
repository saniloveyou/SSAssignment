<%@ page import="com.utar.model.entity.Product" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
Product product = (Product) request.getAttribute("product");
%>
    <form action="ProductController" method="post">
        <table>
            <tr>
                <td>Product Code</td>
                <td>
                    <%
                        out.println("<input type=\"text\" name=\"productId\" readonly value=" + product.getId() + ">");
                    %>
                </td>
            </tr>
            <tr>
                <td>Product Name</td>
                <td>
                    <%
                        out.println("<textarea name=\"productName\" cols=\"50\" >" + product.getProductname() +"</textarea>");
                    %>
                </td>
            </tr>
            <tr>
                <td>Productline</td>
                <td>
                    <%
                        out.println("<textarea name=\"productline\" cols=\"50\" >" + product.getProductline().getId() +"</textarea>");
                    %>
                </td>
            </tr>
            <tr>
                <td>Product Scale</td>
                <td>
                    <%
                        out.println("<input type=\"text\" name=\"productScale\" value=" + product.getProductscale());
                    %>
                </td>
            </tr>
            <tr>
                <td>Product Vendor</td>
                <td>
                    <%
                        out.println("<textarea name=\"productVendor\" cols=\"50\" >" + product.getProductvendor() +"</textarea>");
                    %>
                </td>
            </tr>
            <tr>
                <td>Product Description</td>
                <td>
                    <%
                        out.println("<textarea name=\"productDescription\" rows =\"10\" cols=\"100\" >" + product.getProductdescription() +"</textarea>");
                    %>
                </td>
            </tr>
            <tr>
                <td>Quantity in Stock</td>
                <td>
                    <%
                        out.println("<input type=\"text\" name=\"productInStock\" value=" + product.getQuantityinstock());
                    %>
                </td>

            </tr>
            <tr>
                <td>Buy Price</td>
                <td>
                    <%
                        out.println("<input type=\"text\" name=\"buyPrice\" value=" + product.getBuyprice());
                    %>
                </td>
            </tr>
            <tr>
                <td>MSRP</td>
                <td>
                    <%
                        out.println("<input type=\"text\" name=\"msrp\" value=" + product.getMsrp());
                    %>
                </td>
            </tr>
        </table>
        <input type="submit" name="UPDATE" value="UPDATE" />
        <input type="submit" name="DELETE" value="DELETE" />
    </form>
</body>
</html>