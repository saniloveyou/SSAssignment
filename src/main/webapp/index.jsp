<%@ page import="com.utar.model.entity.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="com.utar.model.entity.Customer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Cart.Cart" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<!--[if lt IE 7]><html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <title>Kool Store - Responsive eCommerce Template</title>

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
        .product-content h5 {
            text-transform: none;
        }
    </style>

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
                        <%
                            Customer customer = session.getAttribute("customer") == null ? null : (Customer) session.getAttribute("customer");
                            if(customer != null){
                        %>
                        <p style="color: black">Welcome, <b><%=customer.getCustomername()%></b></p>
                        <%} else {%>
                            <a href="SignUp">Sign Up</a>
                            <a href="Login.jsp">Log In</a>
                        <%}%>
                    </div> <!-- /.top-header-left -->
                </div> <!-- /.col-md-6 -->
                <div class="col-md-6 col-sm-6">
                    <div class="top-header-left text-right">
                        <a href="Profile?currentPage=1&recordsPerPage=20&direction=asc">Edit Profile</a>
                        <a href="Cart.jsp">Cart (<%= ((ArrayList<Cart>)session.getAttribute("cart_list")) != null ? ((ArrayList<Cart>)session.getAttribute("cart_list")).size() : 0%>) </a>
                        <a href="LoginServlet?action=logout">Logout</a>
                    </div> <!-- /.top-header-left -->
                </div> <!-- /.col-md-6 -->
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
                            <li><a href="index.html">Shop</a></li>
                            <li><a href="ProductPaginationServlet?currentPage=1&recordsPerPage=12&admin=false&keyword=&sort=ASC">Catalogs</a></li>
                            <li><a href="ProductlineDisplayServlet?currentPage=1&recordsPerPage=12&&keyword=&sort=ASC">Productline</a></li>
                            <li><a href="OrderServlet?currentPage=1&recordsPerPage=20&sortBy=ordernumber&direction=asc">Order Details</a></li>
                            <li><a href="PaymentServlet?currentPage=1&recordsPerPage=20&direction=asc">Payment Details</a></li>
                            <li><a href="contact.html">Contact</a></li>
                            <li><a href="adminProductPage.html">Product Edit</a></li>
                        </ul>
                    </div> <!-- /.main-menu -->
                </div> <!-- /.col-md-8 -->
            </div> <!-- /.row -->
        </div> <!-- /.container -->
    </div> <!-- /.main-header -->
    <div class="main-nav">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="list-menu">
                        <ul>
                            <li><a href="index.html">Shop</a></li>
                            <li><a href="ProductPaginationServlet?currentPage=1&recordsPerPage=12&admin=false&keyword=&sort=ASC">Catalogs</a></li>
                            <li><a href="ProductlineDisplayServlet?currentPage=1&recordsPerPage=12&&keyword=&sort=ASC">Productline</a></li>
                            <li><a href="adminProductPage.html">Product Edit</a></li>
                            <li><a href="OrderServlet?currentPage=1&recordsPerPage=20&sortBy=ordernumber&direction=asc">Order Details</a></li>
                            <li><a href="PaymentServlet?currentPage=1&recordsPerPage=20&direction=asc">Payment Details</a></li>
                            <li><a href="contact.html">Contact</a></li>
                        </ul>
                    </div> <!-- /.list-menu -->
                </div> <!-- /.col-md-6 -->
            </div> <!-- /.row -->
        </div> <!-- /.container -->
    </div> <!-- /.main-nav -->
</header> <!-- /.site-header -->

<div class="content-section">
    <div class="container">
        <div class="row">
            <%
                List<Product> products = (List<Product>) request.getAttribute("products");
                for (Product p:products){
            %>
            <div class="col-md-3">
                <div class="product-item-1">
                     <div class="product-thumb">
                        <img src="images/gallery-image-1.jpg" alt="Product Title">
                    </div> <!-- /.product-thumb -->
                    <div class="product-content">
                        <h5><a href="ProductController?display=product&id=<%=p.getId()%>"><%=p.getProductname()%></a></h5>
                        <span class="tagline"><%=p.getProductline().getId()%></span>
                        <span class="price">RM <%=p.getMsrp()%></span>
                        <p><%=p.getProductdescription()%></p>
                    </div> <!-- /.product-content -->
                </div> <!-- /.product-item -->
            </div> <!-- /.col-md-3 -->
            <%}%>
        </div> <!-- /.row -->
        <form id="moreProduct" action="ProductPaginationServlet">
            <input type="hidden" name="admin" value="false">
            <input type="hidden" id="currPage" name="currentPage" value="1">
            <input type="hidden" id="recPerPage" name="recordsPerPage" value="12">
            <input type="hidden" name="keyword" value=""/>
            <input type="hidden" name="sort" value="ASC"/>
        </form>
        <a onclick="document.getElementById('moreProduct').submit();" style="cursor: pointer;float: right;">View More >>></a>

    </div> <!-- /.container -->
</div> <!-- /.content-section -->

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
                        Kool Store is free responsive eCommerce template provided by templatemo website. You can use this layout for any website.
                        <br><br>Tempore cum mollitia eveniet laboriosam corporis voluptas earum voluptate. Lorem ipsum dolor sit amet.
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
                    <span>Copyright &copy; 2084 <a href="#">Company Name</a> | Design: <a href="http://www.templatemo.com">templatemo</a></span>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium, expedita soluta mollitia accusamus ut architecto maiores cum fugiat. Pariatur ipsum officiis fuga deleniti alias quia nostrum veritatis enim doloremque eligendi?</p>
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