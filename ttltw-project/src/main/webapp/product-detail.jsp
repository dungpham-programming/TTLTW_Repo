<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.ProductBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    ProductBean productDetail= (ProductBean) request.getAttribute("productDetail");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/common/client/using-resource-header.jsp"/>
    <title>DDD. - <%=productDetail.getName()%></title>
</head>
<body>
<jsp:include page="/common/client/header.jsp"/>

<!-- Start Product Detail Section -->
<div class="product position-relative-top-84px">
    <div class="container">
        <div class="product-content product-wrap clearfix product-detail">
            <div class="row">
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
                        <%=productDetail.getName()%>
                        <small>Sản phẩm của <a href="javascript:void(0);" class="text-cyan">DDD.</a></small>

                    </h2>
                    <hr/>
                    <h3 class="price-container">
                        <span class="discount-price"><fmt:formatNumber value="<%=productDetail.getDiscountPrice()%>" pattern="#,##0.##"/>đ</span>
                        <del><fmt:formatNumber value="<%=productDetail.getOriginalPrice()%>" pattern="#,##0.##"/>đ</del>
                        <span class="discount-percent">-10%</span>
                    </h3>
                    <div class="certified">
                        <ul>
                            <li>
                                <a href="javascript:void(0);">Số lượng hàng còn<span><%=productDetail.getQuantity()%></span></a>
                            </li>
                            <li>
                                <a href="javascript:void(0);">Tình trạng hàng<span>
                                    <%if (productDetail.getStatus() == 1) {%>Còn hàng<%}%>
                                    <%if (productDetail.getStatus() == 2) {%>Hết hàng<%}%>
                                </span></a>
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
                                Giới thiệu
                            </a>
                            <a class="list-group-item list-group-item-action"
                               data-bs-toggle="list" href="#size" role="tab">
                                Thuộc tính
                            </a>
                        </div>
                    </div>
                    <div class="col-12 content">
                        <div class="tab-content">
                            <div class="tab-pane fade active show" id="description"
                                 role="tabpanel">
                                <br/>
                                <strong>Chi tiết sản phẩm</strong>
                                <p><%=productDetail.getDescription()%></p>
                            </div>
                            <div class="tab-pane fade" id="size" role="tabpanel">
                                <strong>Chiều cao x Đáy bé x Đáy lớn</strong>
                                <p><%=productDetail.getSize()%></p>
                                <strong>Chất liệu</strong>
                                <p><%=productDetail.getOtherSpec()%></p>
                                <strong>Từ khóa</strong>
                                <p><%=productDetail.getKeyword()%></p>
                            </div>
                        </div>
                    </div>
                    <hr/>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-6 dp-flex justify-content-center align-items-center">
                            <a href="<c:url value="/cart-adding">
                                        <c:param name="productId" value="<%=String.valueOf(productDetail.getId())%>"/>
                                        <c:param name="requestBy" value="product-detail"/>
                                     </c:url>" class="add-cart">Thêm vào giỏ hàng</a>
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

<jsp:include page="/common/client/footer.jsp"/>

<jsp:include page="/common/client/using-resource-footer.jsp"/>
</body>
</html>
