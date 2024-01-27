<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.ltw.bean.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Start Header/Navigation -->
<nav id="navigation" class="custom-navbar navbar navbar-fixed navbar-expand-md navbar-dark bg-dark" aria-label="DDD Navigation Bar">

    <div class="container" id="container-nav">
        <a class="navbar-brand" href="index.html">DDD<span>.</span></a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsFurni">
            <ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
                <li class="nav-item active">
                    <a class="nav-link" href="<c:url value="/home"/>">Trang chủ</a>
                </li>
                <li><a class="nav-link" href="<c:url value="/shop"/>">Sản phẩm</a></li>
                <li><a class="nav-link" href="<c:url value="/blog"/>">Tin tức</a></li>
                <li><a class="nav-link" href="contact.html">Liên hệ</a></li>
                <li><a class="nav-link" href="about.html">Về chúng tôi</a></li>
            </ul>

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
                <li class="hv-li"><a class="nav-link yellow" href="#"><i class="fa-regular fa-user"></i></a>
                    <ul class="ul-drop-menu">
                        <li class="drop-menu hello-user">Xin chào, <%= (user.getFirstName() == null || user.getFirstName().isEmpty() || user.getLastName() == null || user.getLastName().isEmpty()) ? user.getEmail() : user.getFirstName() + " " + user.getLastName() %>!</li>
                        <li class="drop-menu hv-gray"><a href="<c:url value="user-info">
                                                                  <c:param name="action" value="view"/>
                                                                  <c:param name="id" value="<%=id%>"/>
                                                               </c:url>">Thông tin tài khoản</a></li>
                        <li class="drop-menu hv-gray"><a href="order-history.html" class="">Lịch sử đơn hàng</a></li>
                        <li class="drop-menu hv-gray"><a href="<c:url value="/signout"/>">Đăng xuất</a></li>
                    </ul>
                </li>
                <li class="hv-li"><a class="nav-link yellow" href="cart.html"><i class="fa-light fa-cart-shopping"></i></a></li>
                <% } %>
            </ul>
        </div>
    </div>

</nav>
<!-- End Header/Navigation -->
