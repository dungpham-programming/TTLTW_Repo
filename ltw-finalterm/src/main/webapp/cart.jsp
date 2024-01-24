<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.Item" %>
<%@ page import="com.ltw.bean.Cart" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
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
<jsp:include page="/common/client/header.jsp"/>
<!-- Start Hero Section -->
<div class="hero cart position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-lg-5">
                <div class="intro-excerpt">
                    <h1>Thanh toán</h1>
                </div>
            </div>
            <div class="col-lg-7">

            </div>
        </div>
    </div>
</div>
<!-- End Hero Section -->


<div class="untree_co-section before-footer-section">
    <div class="container">
        <div id="notify"></div>
        <div class="row mb-5">
            <form action="<c:url value="/cart-updating"/>" class="col-md-12" method="post">
                <div class="site-blocks-table">
                    <table class="table">

                        <thead>
                        <tr>
                            <th class="product-thumbnail">Ảnh</th>
                            <th class="product-name">Sản phẩm</th>
                            <th class="product-price">Giá gốc</th>
                            <th class="product-dprice">Giá giảm</th>
                            <th class="product-quantity">Số lượng</th>
                            <th class="product-total">Tổng cộng (Giá giảm)</th>
                            <th class="product-remove">Xóa</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            Cart cart = (Cart) request.getSession().getAttribute("cart");
                            if (cart != null) {
                                List<Item> items = cart.getItems();
                                if (items != null) {
                                    if (!items.isEmpty()) {
                                        for (int i = 0; i < cart.getTotalItem(); i++) {
                        %>
                        <tr>
                            <td class="product-thumbnail">
                                <img src="images/product-1.png" alt="Image" class="img-fluid">
                            </td>
                            <td class="product-name">
                                <h2 class="h5 text-black"><%=items.get(i).getProduct().getName()%></h2>
                            </td>
                            <td class="original-price"><f:formatNumber value="<%=items.get(i).getProduct().getOriginalPrice()%>" pattern="#,##0.##"/>đ</td>
                            <td class="discount-price"><f:formatNumber value="<%=items.get(i).getProduct().getDiscountPrice()%>" pattern="#,##0.##"/>đ</td>
                            <td>
                                <div class="input-group mb-3 d-flex align-items-center quantity-container"
                                     style="max-width: 120px;">
                                    <div class="input-group-prepend">
                                        <button class="btn btn-outline-black decrease" type="button">&minus;</button>
                                    </div>
                                    <input type="text" class="form-control text-center quantity-amount" name="quantity-<%=i+1%>" value="<%=items.get(i).getQuantity()%>"
                                           placeholder="" aria-label="Example text with button addon"
                                           aria-describedby="button-addon1">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-black increase" type="button">&plus;</button>
                                    </div>
                                </div>
                            </td>
                            <td class="total"><f:formatNumber value="<%=items.get(i).getTotalWithDiscount()%>" pattern="#,##0.##"/>đ</td>
                            <td><a href="<c:url value="/cart-deleting"><c:param name="productId" value="<%=String.valueOf(items.get(i).getProduct().getId())%>"/></c:url>" class="btn btn-black btn-sm">X</a></td>
                        </tr>
                        <%              }
                                    }
                                }
                            }
                        %>
                        </tbody>
                    </table>
                </div>
                <div class="row mt-3">
                    <div class="col-md-6">
                        <div class="row mb-5">
                            <div class="col-md-6">
                                <input class="cart-btn" type="submit" value="Cập nhật giỏ hàng">
                            </div>
                            <div class="col-md-6">
                                <div class="cart-btn d-inline-block">
                                    <a style="color: #e3bd74;" href="<c:url value="/product"/>">Tiếp tục mua</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <div class="row flex-row-reverse">
            <div class="col-md-6 pl-5">
                <div class="row justify-content-end">
                    <div class="col-md-7">
                        <div class="row">
                            <div class="col-md-12 text-right border-bottom mb-5">
                                <h3 class="text-black h4 text-uppercase">Tổng cộng</h3>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <span class="text-black">Tổng giá gốc</span>
                            </div>
                            <div class="col-md-6 text-right">
                                <del class="text-black original-total">7.000.000đ</del>
                            </div>
                        </div>
                        <div class="row mb-5">
                            <div class="col-md-6">
                                <span class="text-black">Tổng giá sau giảm</span>
                            </div>
                            <div class="col-md-6 text-right">
                                <strong class="text-black discount-total">5.000.000đ</strong>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <button class="cart-btn"
                                        onclick="window.location='checkout.html'">Đi đến kiểm tra
                                </button>
                            </div>
                        </div>
                    </div>
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


<script src="<c:url value="/templates/client/js/bootstrap.bundle.min.js"/>"></script>
<script src="<c:url value="/templates/client/js/tiny-slider.js"/>"></script>
<script src="<c:url value="/templates/client/js/custom.js"/>"></script>
</body>
</html>
