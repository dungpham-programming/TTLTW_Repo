<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.ltw.bean.UserBean" %>
<%@ page import="com.ltw.bean.Cart" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Start Header/Navigation -->
<nav id="navigation" class="custom-navbar navbar navbar-fixed navbar-expand-md navbar-dark bg-dark" aria-label="DDD Navigation Bar">

    <div class="container" id="container-nav">
        <a class="navbar-brand" href="<c:url value="/home"/>">DDD<span>.</span></a>

        <div class="col-lg-4 col-md-3 ms-2 p-1">
            <div class="search-frame">
                <%-- Hàm encodeInput có trong using-resource-footer.jsp --%>
                <form action="<c:url value="/search"/>" method="get">
                    <div id="search-component">
                        <input id="search-box" type="text" name="key" class="form-control" placeholder="Tìm kiếm từ khóa, sản phẩm, bài viết..."/>
                        <button type="submit" class="search-btn"><i class="fa-light fa-magnifying-glass"></i></button>
                    </div>
                    <input type="hidden" name="page" id="page" value="1">
                    <input type="hidden" name="sort" value="none">
                    <input type="hidden" name="range" value="none">
                </form>
                <ul id="search-suggest"></ul>
            </div>
        </div>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsFurni">
            <ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="/home"/>">Trang chủ</a>
                </li>
                <li><a class="nav-link" href="<c:url value="/shop"/>">Sản phẩm</a></li>
                <li><a class="nav-link" href="<c:url value="/blog"/>">Tin tức</a></li>
                <li><a class="nav-link" href="<c:url value="/contact"/>">Liên hệ</a></li>
                <li><a class="nav-link" href="<c:url value="/about-us"/>">Về chúng tôi</a></li>
            </ul>
            <%
                Cart cart = (Cart) request.getSession().getAttribute("cart");
                String numberItems = null;
                if (cart != null) {
                    numberItems = String.valueOf(cart.getTotalItem());
                }
            %>

            <%
                UserBean user = (UserBean) request.getSession().getAttribute("user");
                String id;
                if (user != null) {
                    id = String.valueOf(user.getId());
                } else {
                    id ="0";
                }
            %>
            <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
                <% if (user == null) {%>
                <li class="hv-li"><a class="nav-link yellow ss-btn" href="<c:url value="/signin"/>">Đăng nhập</a></li>
                <li class="hv-li"><a class="nav-link yellow ss-btn" href="<c:url value="/register"/>">Đăng ký</a></li>
                <% } %>

                <% if (user != null) {%>
                <li class="hv-li"><a class="nav-link yellow position-relative" href="#"><i class="fa-regular fa-user"></i></a>
                    <ul class="ul-drop-menu">
                        <li class="drop-menu hello-user">Xin chào, <%= (user.getFirstName() == null || user.getFirstName().isEmpty() || user.getLastName() == null || user.getLastName().isEmpty()) ? user.getEmail() : user.getFirstName() + " " + user.getLastName() %>!</li>
                        <li class="drop-menu hv-gray"><a href="<c:url value="user-info">
                                                                  <c:param name="action" value="view"/>
                                                                  <c:param name="id" value="<%=id%>"/>
                                                               </c:url>">Thông tin tài khoản</a></li>
                        <li class="drop-menu hv-gray"><a href="<c:url value="/order-history"/>" class="">Lịch sử đơn hàng</a></li>
                        <li class="drop-menu hv-gray"><a href="<c:url value="/signout"/>">Đăng xuất</a></li>
                    </ul>
                </li>
                <li class="hv-li"><a class="nav-link yellow" href="<c:url value="/cart-management"/>"><i class="fa-light fa-cart-shopping"></i><span class="number-item yellow"><%if (numberItems != null) {%><%=numberItems%><%}%></span></a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
<!-- End Header/Navigation -->
