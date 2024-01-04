<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark navbar-darkred mt-3" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav">
                <div class="sb-sidenav-menu-heading gray">Quản trị viên</div>
                <a class="nav-link pt-3 pb-3" href="<c:url value="/admin/home"/>">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Trang chủ
                </a>
                <%
                    String link = request.getServletPath();
                    // Nếu servlet trùng với file jsp trong getRequestDispatcher thì thêm class yellow-active
                %>
                <a class="nav-link light-text pt-3 pb-3 <%if (link.equals("/client-home-management.jsp")) {%><%="yellow-active"%><% } %>" href="<c:url value="/admin/client-home-management"/>">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý giao diện người dùng
                </a>
                <a class="nav-link light-text pt-3 pb-3 <%if (link.equals("")) {%><%="yellow-active"%><% } %>" href="manage-account.html">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý tài khoản
                </a>
                <a class="nav-link light-text pt-3 pb-3 <%if (link.equals("/product-management.jsp")) {%><%="yellow-active"%><% } %>" href="<c:url value="/admin/product-management"/>">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý sản phẩm
                </a>
                <a class="nav-link light-text pt-3 pb-3 <%if (link.equals("")) {%><%="yellow-active"%><% } %>" href="management-order.html">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý đơn hàng
                </a>
                <a class="nav-link light-text pt-3 pb-3 <%if (link.equals("")) {%><%="yellow-active"%><% } %>" href="management-blog.html">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý tin tức
                </a>
                <a class="nav-link light-text pt-3 pb-3 <%if (link.equals("")) {%><%="yellow-active"%><% } %>" href="management-contact.html">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý liên hệ
                </a>
                <a class="nav-link light-text pt-3 pb-3<%if (link.equals("")) {%><%="yellow-active"%><% } %>" href="manage-image.html">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý ảnh sản phẩm
                </a>
                <a class="nav-link light-text pt-3 pb-3 <%if (link.equals("")) {%><%="yellow-active"%><% } %>" href="order-detail.html">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Kiểm tra chi tiết đơn hàng
                </a>
            </div>
        </div>
        <div class="sb-sidenav-footer mb-3">
            <div class="small">Logged in as:</div>
            Admin3
        </div>
    </nav>
</div>
