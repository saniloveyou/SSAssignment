<%@ page import="com.utar.model.entity.Productline" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 4/18/2023
  Time: 2:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Productline list </title>
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800" rel="stylesheet">

    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/normalize.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/templatemo-misc.css">
    <link rel="stylesheet" href="css/templatemo-style.css">

    <script src="js/vendor/modernizr-2.6.2.min.js"></script>
</head>
<body>
<!--[if lt IE 7]>
<p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
<![endif]-->


<header class="site-header">
    <div class="top-header">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <div class="top-header-left">
                        <a href="#">Sign Up</a>
                        <a href="#">Log In</a>
                    </div> <!-- /.top-header-left -->
                </div> <!-- /.col-md-6 -->
                <div class="col-md-6 col-sm-6">
                    <div class="social-icons">
                        <ul>
                            <li><a href="#" class="fa fa-facebook"></a></li>
                            <li><a href="#" class="fa fa-dribbble"></a></li>
                            <li><a href="#" class="fa fa-twitter"></a></li>
                            <li><a href="#" class="fa fa-linkedin"></a></li>
                        </ul>
                        <div class="clearfix"></div>
                    </div> <!-- /.social-icons -->
                </div> <!-- /.col-md-6 -->
            </div> <!-- /.row -->
        </div> <!-- /.container -->
    </div> <!-- /.top-header -->
    <div class="main-header">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-sm-6 col-xs-8">
                    <div class="logo">
                        <h1><a href="#">Kool Store</a></h1>
                    </div> <!-- /.logo -->
                </div> <!-- /.col-md-4 -->
                <div class="col-md-8 col-sm-6 col-xs-4">
                    <div class="main-menu">
                        <a href="#" class="toggle-menu">
                            <i class="fa fa-bars"></i>
                        </a>
                        <ul class="menu">
                            <li><a href="#">Home</a></li>
                            <li><a href="#">Catalogs</a></li>
                            <li><a href="#">FAQs</a></li>
                            <li><a href="#">Policies</a></li>
                            <li><a href="#">About</a></li>
                        </ul>
                    </div> <!-- /.main-menu -->
                </div> <!-- /.col-md-8 -->
            </div> <!-- /.row -->
        </div> <!-- /.container -->
    </div> <!-- /.main-header -->
    <div class="main-nav">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-sm-7">
                    <div class="list-menu">
                        <ul>
                            <li><a href="index.html">Shop</a></li>
                            <li><a href="">Catalogs</a></li>
                            <li><a href="contact.html">Contact</a></li>
                            <li><a href="adminProductPage.html">Admin Product Edit</a></li>
                        </ul>
                    </div> <!-- /.list-menu -->
                </div> <!-- /.col-md-6 -->
                <div class="col-md-6 col-sm-5">
                    <div class="notification">
                        <span>Free Shipping on any order above $50</span>
                    </div>
                </div> <!-- /.col-md-6 -->
            </div> <!-- /.row -->
        </div> <!-- /.container -->
    </div> <!-- /.main-nav -->
</header> <!-- /.site-header -->

<div class="content-section">
    <div class="container">
        <div class="row">


            <%
                int currentPage = (int) request.getAttribute("currentPage");
                int recordsPerPage = (int) request.getAttribute("recordsPerPage");
                int nOfPages = (int) request.getAttribute("nOfPages");
                String keyword = (String) request.getAttribute("keyword");
                String sort = (String) request.getAttribute("sort");
            %>

            <form class="form-inline md-form mr-auto mb-4"
                  action="ProductlineDisplayServlet" method="get">
                <input class="form-control mr-sm-2" type="text" aria-label="Search"
                       name="keyword" />
                <select class="form-control" id="sort" name="sort">
                    <option value="ASC">Ascending</option>
                    <option value="DESC">Descending</option>
                </select>
                <button class="btn aqua-gradient btn-rounded btn-sm my-0 btn btn-info"
                        type="submit">Search</button>
                <input type="hidden" name="currentPage" value="<%=currentPage%>" />
                <input type="hidden" name="recordsPerPage" value="<%=recordsPerPage%>" />
                <a href="ProductlineAdd.html">
                    <i class="fa fa-plus-circle" aria-hidden="true" style="font-size: 30px;float: right"></i>
                </a>
            </form>

            <table class="table table-striped table-bordered table-sm">
                <tr>
                    <th>Productline</th>
                    <th>Text Description</th>
                    <th>HTML Description</th>
                    <th>Image</th>
                </tr>
                <%
                    List<Productline> productlineList = (List<Productline>) request.getAttribute("productline");
                    if (productlineList.size() != 0) {
                    for (Productline pl:productlineList){
                %>
                <tr>
                    <td><%=pl.getId()%></td>
                    <td><%=pl.getTextdescription()%></td>
                    <td><%=pl.getHtmldescription()%></td>
                    <td><%=pl.getImage()%></td>
                    <td><a href="ProductlineController?id=<%=pl.getId()%>">UPDATE</a></td>
                    <td><a href="ProductlineController?id=<%=pl.getId()%>">DELETE</a></td>
                </tr>
                <%      }
                }else{%>
                <h1>No relevant productline found</h1>
                <%}%>

            </table>
            <nav>
                <ul class="pagination">
                    <%

                        if (currentPage != 1 && nOfPages != 0) {
                            out.println("<li class=\"page-item\">");

                            //&admin=true might affect going to next page
                            out.println("<a class=\"page-link\" href=\"" + "ProductPaginationServlet?recordsPerPage=" + recordsPerPage
                                    + "&currentPage=1" + "&keyword=" + keyword + "&sort="  +
                                    sort +"\">First</a>");
                            out.println("</li>");
                    %>
                    <li class="page-item">
                        <%
                            out.println("<a class=\"page-link\" href=\"" + "ProductPaginationServlet?recordsPerPage=" + recordsPerPage
                                    + "&currentPage=" + (currentPage - 1) + "&keyword=" + keyword + "&sort="  +
                                    sort +"\">Previous</a>");
                        %>
                    </li>
                    <%
                        }
                    %>
                    <%
                        if (currentPage < nOfPages) {
                            out.println("<li class=\"page-item\">");
                            out.println("<a class=\"page-link\" href=\"" + "ProductPaginationServlet?recordsPerPage=" + recordsPerPage
                                    + "&currentPage=" + (currentPage + 1) + "&keyword=" + keyword + "&sort="  +
                                    sort + "\">Next</a>");
                            out.println("</li>");
                            out.println("<li class=\"page-item\">");
                            out.println("<a class=\"page-link\" href=\"" + "ProductPaginationServlet?&recordsPerPage=" + recordsPerPage
                                    + "&currentPage=" + nOfPages + "&keyword=" + keyword +"&sort="  +
                                    sort + "\">Last</a>");
                            out.println("</li>");
                        }
                    %>
                </ul>
            </nav>
            <%
                if (nOfPages != 0) {
                    out.println("<p class=\"pageref\">");
                    out.println("Page " + currentPage + " of " + nOfPages);
                    out.println("</p>");
                }
            %>
        </div>
    </div>
</div>

</body>
</html>
