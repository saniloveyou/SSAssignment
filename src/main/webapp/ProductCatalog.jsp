<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 4/16/2023
  Time: 2:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<%@ page import="com.utar.model.entity.Product" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<!--[if lt IE 7]>
<html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>
<html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>
<html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <title>Products</title>

    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800" rel="stylesheet">

    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/normalize.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/templatemo-misc.css">
    <link rel="stylesheet" href="css/templatemo-style.css">

    <script src="js/vendor/modernizr-2.6.2.min.js"></script>

    <style>
        .product-item-1 .product-content {
            height: 550px;
            border-top: 0;
            padding: 20px 20px 15px 20px;
        }

        .product-content h5 {
            text-transform: none;
        }

        form {
            padding: 15px;
        }

    </style>

</head>
<body>
<!--[if lt IE 7]>
<p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade
    your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to
    improve your experience.</p>
<![endif]-->


<header class="site-header">
    <div class="top-header">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <div class="top-header-left">
                        <a href="Logout.jsp">Logout</a>
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
                            <li>
                                <a href="ProductPaginationServlet?currentPage=1&recordsPerPage=12&admin=false&keyword=&sort=ASC">Catalogs</a>
                            </li>
                            <li><a href="ProductlineDisplayServlet?currentPage=1&recordsPerPage=12&&keyword=&sort=ASC">Productline</a>
                            </li>
                            <li><a href="contact.html">Contact</a></li>
                            <li><a href="adminProductPage.html">Product Edit</a></li>
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
            <nav class="navbar navbar-light bg-light" style="margin: 0">
                <form class="form-inline md-form mr-auto mb-4"
                      action="ProductPaginationServlet" method="get">
                    <input class="form-control mr-sm-2" type="text" aria-label="Search"
                           name="keyword"/>
                    <select class="form-control" id="sort" name="sort">
                        <option value="ASC">Ascending</option>
                        <option value="DESC">Descending</option>
                    </select>
                    <button class="btn aqua-gradient btn-rounded btn-sm my-0 btn btn-info"
                            type="submit">Search
                    </button>
                    <input type="hidden" name="currentPage" value="<%=currentPage%>"/>
                    <input type="hidden" name="recordsPerPage" value="<%=recordsPerPage%>"/>
                    <input type="hidden" name="admin" value="false"/>
                </form>
            </nav>

            <%
                List<Product> products = (List<Product>) request.getAttribute("products");
                if (products.size() != 0) {
                    for (Product p : products) {
            %>

            <div class="col-md-3">
                <div class="product-item-1">
                    <div class="product-thumb">
                        <img src="images/<%=p.getProductline().getId()%>.jpg" alt="Product Title">
                    </div> <!-- /.product-thumb -->
                    <div class="product-content">
                        <h5><a href="ProductController?display=product&id=<%=p.getId()%>"><%=p.getProductname()%>
                        </a></h5>
                        <span class="tagline"><%=p.getProductline().getId()%></span>
                        <span class="price">RM <%=p.getMsrp()%></span>
                        <p><%=p.getProductdescription()%>
                        </p>
                    </div> <!-- /.product-content -->
                </div> <!-- /.product-item -->
            </div> <!-- /.col-md-3 -->
            <% }
            } else {%>
        </div> <!-- /.row -->
        <h1>No relevant product found</h1>
        <%}%>
    </div> <!-- /.container -->
</div> <!-- /.content-section -->

<!-- Navigation of the page -->
<div>
    <ul style="list-style-type: none; display: flex;
            flex-direction: row; justify-content: center;
            align-items: center">
        <%
            if (currentPage != 1 && nOfPages != 0) {
                out.println("<li style=\"padding-right: 50px\">");

                //&admin=true might affect going to next page
                out.println("<a class=\"page-link\" href=\"" + "ProductPaginationServlet?admin=false&recordsPerPage=" + recordsPerPage
                        + "&currentPage=1" + "&keyword=" + keyword + "&sort=" +
                        sort + "\">First</a>");
                out.println("</li>");
        %>
        <li style="padding-right: 50px">
            <%
                out.println("<a class=\"page-link\" href=\"" + "ProductPaginationServlet?admin=false&recordsPerPage=" + recordsPerPage
                        + "&currentPage=" + (currentPage - 1) + "&keyword=" + keyword + "&sort=" +
                        sort + "\">Previous</a>");
            %>
        </li>
        <%
            }
            if (currentPage < nOfPages) {
                out.println("<li style=\"padding-right: 50px\">");
                out.println("<a class=\"page-link\" href=\"" + "ProductPaginationServlet?admin=false&recordsPerPage=" + recordsPerPage
                        + "&currentPage=" + (currentPage + 1) + "&keyword=" + keyword + "&sort=" +
                        sort + "\">Next</a>");
                out.println("</li>");
                out.println("<li style=\"padding-right: 50px\">");
                out.println("<a class=\"page-link\" href=\"" + "ProductPaginationServlet?admin=false&recordsPerPage=" + recordsPerPage
                        + "&currentPage=" + nOfPages + "&keyword=" + keyword + "&sort=" +
                        sort + "\">Last</a>");
                out.println("</li>");
            }
        %>
    </ul>
</div>
<%
    if (nOfPages != 0) {
        out.println("<p style=\"text-align: center; justify-content: center\">");
        out.println("Page " + currentPage + " of " + nOfPages);
        out.println("</p>");
    }
%>


<footer class="site-footer">
    <div class="main-footer">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="footer-widget">
                        <h3 class="widget-title">About Us</h3>
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi, debitis recusandae.
                        <ul class="follow-us">
                            <li><a href="#"><i class="fa fa-facebook"></i>Facebook</a></li>
                            <li><a href="#"><i class="fa fa-twitter"></i>Twitter</a></li>
                        </ul> <!-- /.follow-us -->
                    </div> <!-- /.footer-widget -->
                </div> <!-- /.col-md-3 -->
                <div class="col-md-3">
                    <div class="footer-widget">
                        <h3 class="widget-title">Why Choose Us?</h3>
                        Kool Store is free responsive eCommerce template provided by templatemo website. You can use
                        this layout for any website.
                        <br><br>Tempore cum mollitia eveniet laboriosam corporis voluptas earum voluptate. Lorem ipsum
                        dolor sit amet.
                        <br><br>Credit goes to <a rel="nofollow" href="http://unsplash.com">Unsplash</a> for all images.
                    </div> <!-- /.footer-widget -->
                </div> <!-- /.col-md-3 -->
                <div class="col-md-2">
                    <div class="footer-widget">
                        <h3 class="widget-title">Useful Links</h3>
                        <ul>
                            <li><a href="#">Our Shop</a></li>
                            <li><a href="#">Partners</a></li>
                            <li><a href="#">Gift Cards</a></li>
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">Help</a></li>
                        </ul>
                    </div> <!-- /.footer-widget -->
                </div> <!-- /.col-md-2 -->
                <div class="col-md-4">
                    <div class="footer-widget">
                        <h3 class="widget-title">Our Newsletter</h3>
                        <div class="newsletter">
                            <form action="#" method="get">
                                <p>Sign up for our regular updates to know when new products are released.</p>
                                <input type="text" title="Email" name="email" placeholder="Your Email Here">
                                <input type="submit" class="s-button" value="Submit" name="Submit">
                            </form>
                        </div> <!-- /.newsletter -->
                    </div> <!-- /.footer-widget -->
                </div> <!-- /.col-md-4 -->
            </div> <!-- /.row -->
        </div> <!-- /.container -->
    </div> <!-- /.main-footer -->
    <div class="bottom-footer">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <span>Copyright &copy; 2084 <a href="#">Company Name</a> | Design: <a
                            href="http://www.templatemo.com">templatemo</a></span>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium, expedita soluta mollitia
                        accusamus ut architecto maiores cum fugiat. Pariatur ipsum officiis fuga deleniti alias quia
                        nostrum veritatis enim doloremque eligendi?</p>
                </div> <!-- /.col-md-12 -->
            </div> <!-- /.row -->
        </div> <!-- /.container -->
    </div> <!-- /.bottom-footer -->
</footer> <!-- /.site-footer -->


<script src="js/vendor/jquery-1.10.1.min.js"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.1.min.js"><\/script>')</script>
<script src="js/jquery.easing-1.3.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>

</body>
</html>
