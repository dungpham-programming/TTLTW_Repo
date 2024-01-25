<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.CategoryBean" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.ltw.bean.CategoryTypeBean" %>
<%@ page import="com.ltw.bean.ProductBean" %>
<%@ page import="com.ltw.bean.ProductImageBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<!-- Start Shop Section -->
<div class="product-section product-section before-footer-section position-relative-top-84px">
    <div class="container">
        <%
            String success = (String) request.getAttribute("success");
            if (success != null) {
        %>
        <div class="alert alert-success alert-dismissible fade show" role="alert" id="autoDismissAlert">
            Thêm sản phẩm thành công!
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <% } %>
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
                        <li class="nav-left-item"><a href="wood.html" class="nav-left-link">Sản
                            phẩm <%=category.getName()%>
                        </a>
                            <ul class="pop-right">
                                <%
                                    int categoryId = category.getId();
                                    List<CategoryTypeBean> categoryTypes = categoryTypeMap.get(categoryId);
                                    for (CategoryTypeBean categoryType : categoryTypes) {
                                %>
                                <% if (category.getId() == 1) {%>
                                <li class="pop-right-item"><a
                                        href="<c:url value="/shop-wood"><c:param name="idOnBrowser" value="<%=categoryType.getIdOnBrowser()%>"/></c:url>"
                                        class="pop-right-link"><%=categoryType.getName()%>
                                </a></li>
                                <% } %>
                                <% if (category.getId() == 2) {%>
                                <li class="pop-right-item"><a
                                        href="<c:url value="/shop-knitting"><c:param name="idOnBrowser" value="<%=categoryType.getIdOnBrowser()%>"/></c:url>"
                                        class="pop-right-link"><%=categoryType.getName()%>
                                </a></li>
                                <% } %>
                                <% if (category.getId() == 3) {%>
                                <li class="pop-right-item"><a
                                        href="<c:url value="/shop-porcelain"><c:param name="idOnBrowser" value="<%=categoryType.getIdOnBrowser()%>"/></c:url>"
                                        class="pop-right-link"><%=categoryType.getName()%>
                                </a></li>
                                <% } %>
                                <% } %>
                            </ul>
                        </li>
                        <% } %>
                    </ul>
                </div>
            </div>

            <div class="col-9">
                <%
                    List<CategoryBean> categoriesForProduct = (List<CategoryBean>) request.getAttribute("categories");
                    Map<Integer, List<ProductBean>> productMap = (Map<Integer, List<ProductBean>>) request.getAttribute("productMap");
                    for (CategoryBean category : categoriesForProduct) {
                %>
                <div class="row">
                    <div class="col-12 col-md-6 col-lg-3 mb-5 dp-flex justify-content-center align-items-center darkredbg">
                        <div class="product-list-title dp-flex flex-column justify-content-center align-items-center">
                            <h5 class="product-list-madeby">
                                Sản phẩm làm từ
                            </h5>
                            <h4 class="product-category"><%=category.getName().toUpperCase()%>
                            </h4>
                            <h4 class="product-category">-></h4>
                        </div>
                    </div>
                    <%
                        int categoryId = category.getId();
                        List<ProductBean> products = productMap.get(categoryId);
                        for (ProductBean product : products) {
                    %>
                    <div class="col-12 col-md-6 col-lg-3 mb-5">
                        <div class="product-item">
                            <%
                                Map<Integer, ProductImageBean> productImage = (Map<Integer, ProductImageBean>) request.getAttribute("imageMap");
                                ProductImageBean imageBean = productImage.get(product.getId());
                            %>
                            <img src="<%=imageBean.getLink()%>" alt="image" class="img-fluid product-thumbnail">
                            <h3 class="product-title"><%=product.getName()%>
                            </h3>
                            <strong class="product-price"><f:formatNumber value="<%=product.getDiscountPrice()%>"
                                                                          pattern="#,##0.##"/>₫</strong>
                            <div class="origin-price-and-discount">
                                <del><f:formatNumber value="<%=product.getOriginalPrice()%>" pattern="#,##0.##"/>₫</del>
                                <label><f:formatNumber value="<%=product.getDiscountPercent()%>" pattern="##0"/>%</label>
                            </div>
                            <a href="<c:url value="/cart-adding"><c:param name="productId" value="<%=String.valueOf(product.getId())%>"/><c:param name="requestBy" value="shop"/></c:url>" class="btn-pop-mini left">
                                <i class="fa-solid fa-cart-plus fa-xl" style="color: #2a1710"></i>
                                <p class="content-btn-mini">Thêm vào giỏ hàng</p>
                            </a>
                            <a href="product-detail-go1.html" class="btn-pop-mini right">
                                <i class="fa-solid fa-info fa-xl" style="color: #2a1710"></i>
                                <p class="content-btn-mini">Chi tiết sản phẩm</p>
                            </a>
                        </div>
                    </div>
                    <% } %>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>
<%--<!-- End Shop Section -->--%>
<%--<jsp:include page="/common/client/footer.jsp"/>--%>

<script>
    // Wait for the DOM to be ready
    $(document).ready(function() {
        // Set a timeout to close the alert after 3000 milliseconds (3 seconds)
        setTimeout(function() {
            $("#autoDismissAlert").alert('close');
        }, 3000);
    });
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="<c:url value="/templates/client/js/bootstrap.bundle.min.js"/>"></script>
<script src="<c:url value="/templates/client/js/tiny-slider.js"/>"></script>
<script src="<c:url value="/templates/client/js/custom.js"/>"></script>
</body>
</html>
