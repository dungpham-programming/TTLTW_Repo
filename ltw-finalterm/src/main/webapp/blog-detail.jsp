<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.BlogBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %><!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="../favicon.png">

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

    <!-- Bootstrap CSS -->
    <link href="<c:url value="/templates/client/css/bootstrap.min.css" /> "rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="<c:url value="/templates/client/css/tiny-slider.css" />"rel="stylesheet">
    <link href="<c:url value="/templates/client/css/style.css" />"rel="stylesheet">
    <title>DDD. - Nghệ thuật mỹ nghệ</title>
</head>

<body>

<!-- Start Header/Navigation -->
<nav class="custom-navbar navbar navbar navbar-expand-md navbar-dark bg-dark" arial-label="Furni navigation bar">

    <div class="container">
        <a class="navbar-brand" href="index.html">DDD<span>.</span></a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni"
                aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsFurni">
            <ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
                <li class="nav-item">
                    <a class="nav-link" href="index.html">Trang chủ</a>
                </li>
                <li><a class="nav-link" href="shop.html">Sản phẩm</a></li>
                <li class="active"><a class="nav-link" href="blog.html">Tin tức</a></li>
                <li><a class="nav-link" href="contact.html">Liên hệ </a></li>
                <li><a class="nav-link" href="about.html">Về chúng tôi</a></li>
            </ul>

            <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
                <li class="hv-li"><a class="nav-link yellow" href="#"><i class="fa-regular fa-user"></i></a>
                    <ul class="ul-drop-menu">
                        <li class="drop-menu hello-user">Xin chào, User!</li>
                        <li class="drop-menu hv-gray"><a href="update_user_info.html" class="">Thông tin tài khoản</a></li>
                        <li class="drop-menu hv-gray"><a href="order-history.html" class="">Lịch sử đơn hàng</a></li>
                        <li class="drop-menu hv-gray"><a href="#">Đăng xuất</a></li>
                    </ul>
                </li>
                <li class="hv-li"><a class="nav-link yellow" href="cart.html"><i class="fa-light fa-cart-shopping"></i></a></li>
            </ul>
        </div>
    </div>

</nav>
<!-- End Header/Navigation -->

<!-- Start Hero Section -->
<div class="hero blog position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-12">
                <div class="intro-excerpt">
                    <h1>Tin tức</h1>
                </div>
            </div>

        </div>
    </div>
</div>
<!-- End Hero Section -->

<div class="blog-content position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-center">
            <% BlogBean blogdetails = (BlogBean)
                    request.getAttribute("blogdetail");
            %>
            <div class="col-8">
                <div class="author-n-date">
                    <h5> <% ((BlogBean) request.getAttribute("blogdetail")).getAuthor();%></h5>
                </div>

                <div class="title">
                    <h2><% ((BlogBean) request.getAttribute("blogdetail")).getTitle();%></h2>
                </div>


                <div class="blog-img">
                    <img src="../images/blog/post-1.jpg" alt="" class="img-fluid">
                </div>

                <div class="news-content">
                    <p> <% ((BlogBean) request.getAttribute("blogdetail")).getContent();%></p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Start Footer Section -->
<footer class="footer-section position-relative-top-84px">
    <div class="container relative">
        <div class="row g-5 mb-5">
            <div class="col-4">
                <div class="mb-4"><p href="#" class="footer-head">DDD<span>.</span></p></div>
                <p class="mb-4 light-text footer-content">Với chúng tôi, mỗi một sản phẩm mỹ nghệ đều là một kiệt tác, là một tác phẩm nghệ thuật. Cảm ơn bạn đã ghé thăm DDD. - Nghệ thuật mỹ nghệ. Mua sắm với chúng tôi trong mục sản phẩm, hoặc bấm vào nút Khám phá trên trang chủ.</p>
            </div>

            <div class="col-4 center-text">
                <div class="mb-4"><p id="mxh-changing" class="footer-head">Mạng xã hội</p></div>
                <p class="mb-4 light-text footer-content">Đừng quên theo dõi chúng tôi qua các kênh mạng xã hội sau để không bỏ lỡ nhưng thông tin mới nhất của DDD. - Nghệ thuật mỹ nghệ</p>
                <ul class="list-unstyled custom-social">
                    <li><a href="#"><span class="fa fa-brands fa-facebook-f footer-content"></span></a></li>
                    <li><a href="#"><span class="fa fa-brands fa-twitter footer-content"></span></a></li>
                    <li><a href="#"><span class="fa fa-brands fa-instagram footer-content"></span></a></li>
                    <li><a href="#"><span class="fa fa-brands fa-linkedin footer-content"></span></a></li>
                </ul>
            </div>

            <div class="col-4">
                <div class="row links-wrap">
                    <div class="right-text">
                        <div class="mb-4"><p class="footer-head">Nội dung</p></div>
                        <ul class="list-unstyled ">
                            <li><a class="light-text footer-content" href="#">Sản phẩm</a></li>
                            <li><a class="light-text footer-content" href="#">Tin tức</a></li>
                            <li><a class="light-text footer-content" href="#">Liên hệ</a></li>
                            <li><a class="light-text footer-content" href="#">Về chúng tôi</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="border-top copyright">
            <div class="row pt-4">
                <div class="col-lg-6">
                    <p class="mb-2 text-center text-lg-start light-text footer-content">Copyright &copy;<script>document.write(new Date().getFullYear());</script>. All Rights Reserved.</p>
                    <!-- License information: https://untree.co/license/ -->
                </div>

                <div class="col-lg-6 text-center text-lg-end light-text">
                    <ul class="list-unstyled d-inline-flex ms-auto">
                        <li class="me-4 footer-content"><a  href="#">Terms &amp; Conditions</a></li>
                        <li><a href="#" class="footer-content">Privacy Policy</a></li>
                    </ul>
                </div>
            </div>
        </div>

    </div>
</footer>
<!-- End Footer Section -->

<button id="scroll-to-top"><i class="fa-solid fa-chevron-up" style="color: #e3bd74;"></i></button>

<script src="<c:url value="/templates/client/js/bootstrap.bundle.min.js"/>"></script>
<script src="<c:url value="/templates/client/js/tiny-slider.js"/>"> </script>
<script src="<c:url value="/templates/client/js/custom.js"/>"></script>

</body>
</html>