<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.ProductBean" %>
<%@ page import="com.ltw.bean.ProductImageBean" %>
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
                            <%
                                List<ProductImageBean> images = productDetail.getImages();
                            %>
                            <div class="carousel-indicators">
                                <% for (int i = 0; i < images.size(); i++) { %>
                                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="<%= i %>"
                                        <%= (i == 0) ? "class=\"active\" aria-current=\"true\"" : "" %>></button>
                                <% } %>
                            </div>
                            <div class="carousel-inner">
                                <% for (int i = 0; i < images.size(); i++) { %>
                                <div class="carousel-item <%= (i == 0) ? "active" : "" %>">
                                    <img src="<%=images.get(i).getLink()%>" class="d-block fixed-height-img" alt="...">
                                </div>
                                <% } %>
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
                            <li>
                                <a href="javascript:void(0);">Số lượng đã bán<span style="color: red"><%=productDetail.getSoldQuantity()%></span></a>
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
                        <div class="col-sm-12 col-md-6 col-lg-6 dp-flex justify-content-center align-items-center cart-div">
                            <input type="hidden" name="productId" value="<%=productDetail.getId()%>">
                            <button class="btn-pop-mini left add-cart">
                                <i class="fa-solid fa-cart-plus fa-xl"></i>
                                <p class="content-btn-mini">Thêm vào giỏ hàng</p>
                            </button>
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

<%-- Icon --%>
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
    <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
        <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"></path>
    </symbol>
    <symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
        <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"></path>
    </symbol>
    <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
        <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"></path>
    </symbol>
</svg>

<jsp:include page="/common/client/using-resource-footer.jsp"/>
<script src="<c:url value="/templates/client/js/ajax/cart/cart-add.js"/>"></script>
</body>
</html>
