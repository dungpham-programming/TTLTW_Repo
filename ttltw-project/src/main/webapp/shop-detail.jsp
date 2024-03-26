<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.ltw.bean.CategoryBean" %>
<%@ page import="com.ltw.bean.CategoryTypeBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.ltw.bean.ProductBean" %>
<%@ page import="com.ltw.bean.ProductImageBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/common/client/using-resource-header.jsp"/>
    <title>DDD. - Danh mục sản phẩm</title>
</head>
<body>
<jsp:include page="/common/client/header.jsp"/>

<!-- Start Hero Section -->
<div class="hero shop position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-12">
                <div class="intro-excerpt">
                    <h1>Sản phẩm</h1>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Hero Section -->

<!-- Start Wood Section -->
<div class="product-section product-section before-footer-section position-relative-top-84px">
    <div class="container">
        <div class="row">
            <div class="col-3 pe-3 nav-left">
                <div class="nav-left-block mb-5">
                    <p class="nav-left-title">Danh mục sản phẩm</p>
                    <%
                        List<CategoryBean> categories = (List<CategoryBean>) request.getAttribute("categories");
                        Map<Integer, List<CategoryTypeBean>> categoryTypeMap = (Map<Integer, List<CategoryTypeBean>>) request.getAttribute("categoryTypeMap");
                    %>
                    <ul class="nav-left-list">
                        <% for (CategoryBean category : categories) {%>
                        <li class="nav-left-item"><a href="<c:url value="shop-detail-by-category"><c:param name="categoryId" value="<%=String.valueOf(category.getId())%>"/></c:url>" class="nav-left-link">Sản
                            phẩm <%=category.getName()%>
                        </a>
                            <ul class="pop-right">
                                <%
                                    int categoryId = category.getId();
                                    List<CategoryTypeBean> categoryTypes = categoryTypeMap.get(categoryId);
                                    for (CategoryTypeBean categoryType : categoryTypes) {
                                %>
                                <li class="pop-right-item"><a href="<c:url value="/shop-detail-by-type">
                                                                        <c:param name="categoryTypeId" value="<%=String.valueOf(categoryType.getId())%>"/>
                                                                        <c:param name="recentPage" value="1"/>
                                                                        <c:param name="sort" value="none"/>
                                                                        <c:param name="range" value="none"/>
                                                                    </c:url>"
                                        class="pop-right-link"><%=categoryType.getName()%>
                                </a></li>
                                <% } %>
                            </ul>
                        </li>
                        <% } %>
                    </ul>
                </div>
            </div>

            <div class="col-9">
                <%
                    List<CategoryTypeBean> categoryTypeForProduct = (List<CategoryTypeBean>) request.getAttribute("categoryTypeForProduct");
                    Map<Integer, List<ProductBean>> productMap = (Map<Integer, List<ProductBean>>) request.getAttribute("productMap");
                    for (CategoryTypeBean categoryType : categoryTypeForProduct) {
                %>
                <div class="row">
                    <div class="col-12" id="luc-binh-go">
                        <h1 class="product-type-title"><%=categoryType.getName().toUpperCase()%></h1>
                        <hr size="4">
                    </div>
                </div>

                <div class="row">
                    <%
                        List<ProductBean> products = productMap.get(categoryType.getId());
                        for (ProductBean product : products) {
                    %>
                    <!-- Start Column 1 -->
                    <div class="col-12 col-md-6 col-lg-3 mb-5">
                        <div class="product-item">
                            <%
                                Map<Integer, ProductImageBean> productImage = (Map<Integer, ProductImageBean>) request.getAttribute("imageMap");
                                ProductImageBean imageBean = productImage.get(product.getId());
                            %>
                            <input type="hidden" name="productId" value="<%=product.getId()%>">
                            <img src="<%=imageBean.getLink()%>" class="img-fluid product-thumbnail" alt="">
                            <h3 class="product-title"><%=product.getName()%></h3>
                            <strong class="product-price"><f:formatNumber value="<%=product.getDiscountPrice()%>" pattern="#,##0.##"/>₫</strong>
                            <div class="origin-price-and-discount">
                                <del><f:formatNumber value="<%=product.getOriginalPrice()%>" pattern="#,##0.##"/>₫</del>
                                <label><f:formatNumber value="<%=product.getDiscountPercent()%>" pattern="##0"/>%</label>
                            </div>
                            <button class="btn-pop-mini left">
                                <i class="fa-solid fa-cart-plus fa-xl" style="color: #2a1710"></i>
                                <p class="content-btn-mini">Thêm vào giỏ hàng</p>
                            </button>
                            <a href="<c:url value="/product-detail"><c:param name="id" value="<%=String.valueOf(product.getId())%>"/></c:url>" class="btn-pop-mini right">
                                <i class="fa-solid fa-info fa-xl" style="color: #2a1710"></i><p class="content-btn-mini">Chi tiết sản phẩm</p>
                            </a>
                        </div>
                    </div>
                    <!-- End Column 1 -->
                    <% } %>
                </div>
                <div class="row">
                    <div class="d-flex justify-content-center mb-5"><a href="<c:url value="/shop-detail-by-type">
                                                                                <c:param name="categoryTypeId" value="<%=String.valueOf(categoryType.getId())%>"/>
                                                                                <c:param name="recentPage" value="1"/>
                                                                                <c:param name="sort" value="none"/>
                                                                                <c:param name="range" value="none"/>
                                                                            </c:url>" class="more">Xem thêm -></a>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>
<!-- End Wood Section -->
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
