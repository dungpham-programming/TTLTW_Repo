<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.ltw.bean.CategoryBean" %>
<%@ page import="com.ltw.bean.CategoryTypeBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.ltw.bean.ProductBean" %>
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
        <div class="row mb-3">
            <form action="<c:url value="/search"/>" method="get">
                <input type="hidden" name="sort" value="none">
                <input type="hidden" name="range" value="none">
                <input type="hidden" name="page" value="1">
                <div class="input-group">
                    <input type="search" class="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon" name="key"/>
                    <button type="submit" class="btn btn-outline-primary" data-mdb-ripple-init>search</button>
                </div>
            </form>
        </div>
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
                                                                        <c:param name="page" value="1"/>
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
                            <img src="../images/wooden/binh_go_cam_2_1.jpg" class="img-fluid product-thumbnail">
                            <h3 class="product-title"><%=product.getName()%></h3>
                            <strong class="product-price"><f:formatNumber value="<%=product.getDiscountPrice()%>" pattern="#,##0.##"/>₫</strong>
                            <div class="origin-price-and-discount">
                                <del><f:formatNumber value="<%=product.getOriginalPrice()%>" pattern="#,##0.##"/>₫</del>
                                <label><f:formatNumber value="<%=product.getDiscountPercent()%>" pattern="##0"/>%</label>
                            </div>
                            <a href="<c:url value="/cart-adding"><c:param name="productId" value="<%=String.valueOf(product.getId())%>"/><c:param name="requestBy" value="shop-detail-by-category"/></c:url>" class="btn-pop-mini left">
                                <i class="fa-solid fa-cart-plus fa-xl" style="color: #2a1710"></i><p class="content-btn-mini">Thêm vào giỏ hàng</p>
                            </a>
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
                                                                                <c:param name="page" value="1"/>
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

<jsp:include page="/common/client/using-resource-footer.jsp"/>
</body>
</html>
