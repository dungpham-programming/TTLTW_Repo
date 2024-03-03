<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.ltw.bean.CategoryBean" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.CategoryTypeBean" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.ltw.bean.ProductBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String sort = (String) request.getAttribute("sort");
    String range = (String) request.getAttribute("range");
    String key = (String) request.getAttribute("key");
%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/common/client/using-resource-header.jsp"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>

    <title>DDD. - Tìm kiếm "<%=key%>"</title>
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
                <div class="nav-left-block">
                    <div class="mb-5">
                        <p class="nav-left-title">Danh mục sản phẩm</p>
                        <%
                            List<CategoryBean> categories = (List<CategoryBean>) request.getAttribute("categories");
                            Map<Integer, List<CategoryTypeBean>> categoryTypeMap = (Map<Integer, List<CategoryTypeBean>>) request.getAttribute("categoryTypeMap");
                        %>
                        <ul class="nav-left-list">
                            <% for (CategoryBean category : categories) {%>
                            <li class="nav-left-item"><a
                                    href="<c:url value="shop-detail-by-category"><c:param name="categoryId" value="<%=String.valueOf(category.getId())%>"/></c:url>"
                                    class="nav-left-link">Sản
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
                                                                        </c:url>" class="pop-right-link"><%=categoryType.getName()%>
                                    </a></li>
                                    <% } %>
                                </ul>
                            </li>
                            <% } %>
                        </ul>
                    </div>

                    <div class="sorting px-1">
                        <form action="<c:url value="/search"/>" method="get">
                            <input type="hidden" name="page" value="1">
                            <input type="hidden" name="key" value="<%=key%>">
                            <div><h5>Sắp xếp theo giá</h5></div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="sort" id="option1" value="none" <%if (sort.equals("none")) {%>checked<%}%>>
                                <label class="form-check-label" for="option1">Không</label>
                            </div>

                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="sort" id="option2" value="asc" <%if (sort.equals("asc")) {%>checked<%}%>>
                                <label class="form-check-label" for="option2">Tăng</label>
                            </div>

                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="sort" id="option3" value="desc" <%if (sort.equals("desc")) {%>checked<%}%>>
                                <label class="form-check-label" for="option3">Giảm</label>
                            </div>

                            <div class="mt-2"><h5>Khoảng giá</h5></div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="range" id="option4" value="none" <%if (range.equals("none")) {%>checked<%}%>>
                                <label class="form-check-label" for="option4">Không</label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="range" id="option5" value="0-to-499" <%if (range.equals("0-to-499")) {%>checked<%}%>>
                                <label class="form-check-label" for="option5">0 - 499.000đ</label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="range" id="option6" value="500-to-2999" <%if (range.equals("500-to-2999")) {%>checked<%}%>>
                                <label class="form-check-label" for="option6">500.000đ - 2.999.000đ</label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="range" id="option7" value="3000-to-9999" <%if (range.equals("3000-to-9999")) {%>checked<%}%>>
                                <label class="form-check-label" for="option7">3.000.000đ - 9.999.000đ</label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="range" id="option8" value="up-to-10000" <%if (range.equals("up-to-10000")) {%>checked<%}%>>
                                <label class="form-check-label" for="option8">10.000.000đ trở lên</label>
                            </div>

                            <button class="btn btn-primary" type="submit">Gửi</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-9">
                <div class="row">
                    <div class="col-12" id="luc-binh-go">
                        <h1 class="product-type-title">Kết quả cho "<%=key%>"
                        </h1>
                        <hr size="4">
                    </div>
                </div>

                <div class="row">
                    <%
                        List<ProductBean> products = (List<ProductBean>) request.getAttribute("products");
                        for (ProductBean product : products) {
                    %>
                    <!-- Start Column 1 -->
                    <div class="col-12 col-md-6 col-lg-3 mb-5">
                        <div class="product-item">
                            <img src="../images/wooden/binh_go_cam_2_1.jpg" class="img-fluid product-thumbnail">
                            <h3 class="product-title"><%=product.getName()%>
                            </h3>
                            <strong class="product-price"><f:formatNumber value="<%=product.getDiscountPrice()%>"
                                                                          pattern="#,##0.##"/>₫</strong>
                            <div class="origin-price-and-discount">
                                <del><f:formatNumber value="<%=product.getOriginalPrice()%>" pattern="#,##0.##"/>₫</del>
                                <label><f:formatNumber value="<%=product.getDiscountPercent()%>"
                                                       pattern="##0"/>%</label>
                            </div>
                            <a href="<c:url value="/cart-adding"><c:param name="productId" value="<%=String.valueOf(product.getId())%>"/><c:param name="requestBy" value="shop-detail-by-type"/></c:url>"
                               class="btn-pop-mini left">
                                <i class="fa-solid fa-cart-plus fa-xl" style="color: #2a1710"></i>
                                <p class="content-btn-mini">Thêm vào giỏ hàng</p>
                            </a>
                            <a href="<c:url value="/product-detail"><c:param name="productId" value="<%=String.valueOf(product.getId())%>"/></c:url>" class="btn-pop-mini right">
                                <i class="fa-solid fa-info fa-xl" style="color: #2a1710"></i>
                                <p class="content-btn-mini">Chi tiết sản phẩm</p>
                            </a>
                        </div>
                    </div>
                    <!-- End Column 1 -->
                    <% } %>
                </div>
                <div class="row justify-content-center">
                    <form action="<c:url value="/search"/>" id="paginationForm" method="get">
                        <ul class="pagination justify-content-center" id="pagination"></ul>
                        <!-- Có input nhưng hidden (ẩn) đi -->
                        <input type="hidden" name="key" value="<%=key%>">
                        <input type="hidden" value="" id="page" name="page"/>
                        <input type="hidden" name="sort" value="<%=sort%>">
                        <input type="hidden" name="range" value="<%=range%>">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%
    int serverPage = (int) request.getAttribute("serverPage");
    int serverTotalPages = (int) request.getAttribute("serverTotalPages");
%>

<!-- End Wood Section -->
<jsp:include page="/common/client/footer.jsp"/>

<script>
    let currentPage = <%=serverPage%>;
    let totalPages =  <%=serverTotalPages%>;
    let limit = 2;
    $(function () {
        window.pagObj = $('#pagination').twbsPagination({
            // Kiểm tra các thuộc tính trong file .js (trong default)
            totalPages: totalPages,
            // Đây là SỐ PAGE HIỂN THỊ TRONG THANH CHỌN PAGE
            visiblePages: 5,
            startPage: currentPage,
            onPageClick: function (event, page) {
                // Nếu page hiện tại khác page đang chọn thì mới cần submit
                if (currentPage !== page) {
                    // Đây là SỐ LƯỢNG ITEM TRONG 1 PAGE
                    $('#itemPerVisible').val(limit);
                    $('#page').val(page);
                    $('#paginationForm').submit();
                }
            }
        }).on('page', function (event, page) {
            console.info(page + ' (from event listening)');
        });
    });
</script>

<jsp:include page="/common/client/using-resource-footer.jsp"/>
</body>
</html>
