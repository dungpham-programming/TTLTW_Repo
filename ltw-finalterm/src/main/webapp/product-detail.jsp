<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.ProductBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
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
    <link href="<c:url value="/templates/client/css/bootstrap.min.css"/>" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="<c:url value="/templates/client/css/tiny-slider.css"/>" rel="stylesheet">
    <link href="<c:url value="/templates/client/css/style.css"/>" rel="stylesheet">

    <title>DDD. - Nghệ thuật mỹ nghệ</title>
</head>
<body>
<!-- Start Header/Navigation -->
<nav id="navigation" class="custom-navbar navbar navbar-fixed navbar-expand-md navbar-dark bg-dark"
     aria-label="DDD Navigation Bar">

    <div class="container" id="container-nav">
        <a class="navbar-brand" href="index.html">DDD<span>.</span></a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni"
                aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsFurni">
            <ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
                <li class="nav-item active">
                    <a class="nav-link" href="index.html">Trang chủ</a>
                </li>
                <li><a class="nav-link " href="shop.html">Sản phẩm</a></li>
                <li><a class="nav-link" href="blog.html">Tin tức</a></li>
                <li><a class="nav-link" href="contact.html">Liên hệ</a></li>
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
                <li class="hv-li"><a class="nav-link yellow" href="cart.html"><i class="fa-light fa-cart-shopping"></i></a>
                </li>
            </ul>
        </div>
    </div>

</nav>
<!-- End Header/Navigation -->

<!-- Start Product Detail Section -->
<div class="product position-relative-top-84px">
    <div class="container">
        <div class="product-content product-wrap clearfix product-detail">
            <div class="row">
                <% ProductBean productDetails= (ProductBean) request.getAttribute("productDetail");

                  %>
                <div class="col-md-4 col-sm-12 col-xs-12">
                    <div class="product-image">
                        <div id="carouselExampleIndicators" class="carousel slide">
                            <div class="carousel-indicators">
                                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0"
                                        class="active" aria-current="true" aria-label="Slide 1"></button>
                                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
                                        aria-label="Slide 2"></button>
                                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"
                                        aria-label="Slide 3"></button>
                            </div>
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="../images/knitting/vi_cam_tay.jpg" class="d-block fixed-height-img"
                                         alt="...">
                                </div>
                                <div class="carousel-item">
                                    <img src="../images/knitting/vi_cam_tay1.jpg" class="d-block fixed-height-img"
                                         alt="...">
                                </div>
                                <div class="carousel-item">
                                    <img src="../images/knitting/vi_cam_tay2.jpg" class="d-block fixed-height-img"
                                         alt="...">
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button"
                                    data-bs-target="#carouselExampleIndicators"
                                    data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button"
                                    data-bs-target="#carouselExampleIndicators"
                                    data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>

                    <div id="btn-back" class="button-back dp-flex flex-row justify-content-between">
                        <a href="shop.html" class="back">Quay lại sản phẩm</a>
                        <a href="index.html" class="back">Quay lại trang chủ</a>
                    </div>
                </div>
                <div class="col-md-7 offset-md-1 col-sm-12 col-xs-12">
                    <h2 class="name">
                        Túi sen
                        <small>Sản phẩm của <a href="javascript:void(0);" class="text-cyan">DDD.</a></small>

                    </h2>
                    <hr/>
                    <h3 class="price-container">
                        <span class="discount-price">450.000đ</span>
                        <del>500.000đ</del>
                        <span class="discount-percent">-10%</span>
                    </h3>
                    <div class="certified">
                        <ul>
                            <li>
                                <a href="javascript:void(0);">Thời gian vận chuyển<span>3 ngày</span></a>
                            </li>
                            <li>
                                <a href="javascript:void(0);">Chứng nhận<span>Bảo đảm chất lượng</span></a>
                            </li>
                        </ul>
                    </div>
                    <hr/>
                    <div class="col-12">
                        <div class="list-group list-group-horizontal"
                             id="myList" role="tablist">
                            <a class="list-group-item list-group-item-action active darkred-active"
                               data-bs-toggle="list" href="#description"
                               role="tab">
                                Chi tiết
                            </a>
                            <a class="list-group-item list-group-item-action"
                               data-bs-toggle="list" href="#size" role="tab">
                                Kích thước
                            </a>
                        </div>
                    </div>
                    <div class="col-12 content">
                        <div class="tab-content">
                            <div class="tab-pane fade active show" id="description"
                                 role="tabpanel">
                                <br/>
                                <strong>Chi tiết sản phẩm</strong>
                                <p>
                                    Làm từ chất liệu cỏ bàng tự nhiên, túi này là biểu tượng của sự bền vững và sáng tạo.
                                    Thiết kế đơn giản nhưng tinh tế, túi cỏ bàng mang lại không gian rộng rãi và thoải mái cho đồ đạc cá nhân.
                                    Dây đeo êm ái, làn da tự nhiên, và hoa văn tự nhiên tạo nên sự duyên dáng.
                                    Sự giao thoa giữa thiên nhiên và thời trang, túi cỏ bàng là sự lựa chọn độc đáo.
                                </p>
                            </div>
                            <div class="tab-pane fade" id="size" role="tabpanel">
                                <br/>
                                <strong>Chiều cao x Đáy bé x Đáy lớn</strong>
                                <p>40cm x 22cm x 25cm</p>
                            </div>
                        </div>
                    </div>
                    <hr/>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-6 dp-flex justify-content-center align-items-center">
                            <a href="javascript:void(0);" class="add-cart">Thêm vào giỏ hàng</a>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-6 dp-flex justify-content-start align-content-center">
                            <div class="btn-group-vertical">
                                <a href="contact.html"><i class="fa fa-envelope"></i>
                                    Liên hệ với người bán
                                </a>

                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<!-- End Product Detail -->

<!-- Start Footer Section -->
<footer class="footer-section position-relative-top-84px">
    <div class="container relative">
        <div class="row g-5 mb-5">
            <div class="col-4">
                <div class="mb-4"><p href="#" class="footer-head">DDD<span>.</span></p></div>
                <p class="mb-4 light-text footer-content">Với chúng tôi, mỗi một sản phẩm mỹ nghệ đều là một kiệt tác,
                    là một tác phẩm nghệ thuật. Cảm ơn bạn đã ghé thăm DDD. - Nghệ thuật mỹ nghệ. Mua sắm với chúng tôi
                    trong mục sản phẩm, hoặc bấm vào nút Khám phá trên trang chủ.</p>
            </div>

            <div class="col-4 center-text">
                <div class="mb-4"><p id="mxh-changing" class="footer-head">Mạng xã hội</p></div>
                <p class="mb-4 light-text footer-content">Đừng quên theo dõi chúng tôi qua các kênh mạng xã hội sau để
                    không bỏ lỡ nhưng thông tin mới nhất của DDD. - Nghệ thuật mỹ nghệ</p>
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
                    <p class="mb-2 text-center text-lg-start light-text footer-content">Copyright &copy;<script>document.write(new Date().getFullYear());</script>
                        . All Rights Reserved.
                    </p>
                    <!-- License information: https://untree.co/license/ -->
                </div>

                <div class="col-lg-6 text-center text-lg-end light-text">
                    <ul class="list-unstyled d-inline-flex ms-auto">
                        <li class="me-4 footer-content"><a href="#">Terms &amp; Conditions</a></li>
                        <li><a href="#" class="footer-content">Privacy Policy</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- End Footer Section -->

<button id="scroll-to-top"><i class="fa-solid fa-chevron-up" style="color: #e3bd74;"></i></button>

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.min.js"></script>
<script src="<c:url value="/templates/client/js/custom.js"/>"></script>
<script type="text/javascript">

</script>
</body>
</html>
