<%@ page import="com.ltw.bean.UserBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark navbar-darkred mt-3" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <%
                UserBean user = (UserBean) request.getSession().getAttribute("user");
                String link = request.getServletPath();
                // Nếu servlet trùng với file jsp trong getRequestDispatcher thì thêm class yellow-active
            %>
            <div class="nav">
                <div class="sb-sidenav-menu-heading gray">Quản trị viên</div>
                <a class="nav-link pt-3 pb-3" <%if (link.equals("/admin-home.jsp")) {%><%="yellow-active"%><% } %> href="<c:url value="/admin/home"/>">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Trang chủ
                </a>
                <a class="nav-link light-text pt-3 pb-3 <%if (link.equals("/client-home-management.jsp")) {%><%="yellow-active"%><% } %>" href="<c:url value="/admin/client-home-management"/>">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý giao diện người dùng
                </a>
                <a class="nav-link light-text pt-3 pb-3 <%if (link.equals("/account-management.jsp")) {%><%="yellow-active"%><% } %>" href="<c:url value="/admin/account-management"/>">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý tài khoản
                </a>
                <a class="nav-link light-text pt-3 pb-3 <%if (link.equals("/product-management.jsp")) {%><%="yellow-active"%><% } %>" href="<c:url value="/admin/product-management"/>">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý sản phẩm
                </a>
                <a class="nav-link light-text pt-3 pb-3 <%if (link.equals("/order-management.jsp")) {%><%="yellow-active"%><% } %>" href="<c:url value="/admin/order-management"/>">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý đơn hàng
                </a>
                <a class="nav-link light-text pt-3 pb-3 <%if (link.equals("/contact-management.jsp")) {%><%="yellow-active"%><% } %>" href="<c:url value="/admin/contact-management"/>">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý liên hệ
                </a>
                <a class="nav-link light-text pt-3 pb-3 <%if (link.equals("/blog-management.jsp")) {%><%="yellow-active"%><% } %>" href="<c:url value="/admin/blog-management"/>">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý bài viết
                </a>
                <a class="nav-link light-text pt-3 pb-3<%if (link.equals("/all-image-management.jsp")) {%><%="yellow-active"%><% } %>" href="<c:url value="/admin/all-image-management"/>">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý ảnh sản phẩm
                </a>
                <a class="nav-link light-text pt-3 pb-3 <%if (link.equals("/warehouse-management.jsp")) {%><%="yellow-active"%><% } %>" href="<c:url value="/admin/warehouse-management"/>">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý kho hàng
                <a class="nav-link light-text pt-3 pb-3<%if (link.equals("/log-management.jsp")) {%><%="yellow-active"%><% } %>" href="<c:url value="/admin/log-management"/>">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Quản lý log
                </a>
            </div>
        </div>
        <div class="sb-sidenav-footer mb-3">
            <%
                String name;
                if (user.getFirstName() == null && user.getLastName() == null) {
                    name = user.getEmail();
                } else if (user.getFirstName() != null && user.getLastName() == null) {
                    name = user.getFirstName();
                } else if (user.getFirstName() == null && user.getLastName() != null) {
                    name = user.getLastName();
                } else {
                    name = user.getFirstName() + user.getLastName();
                }
            %>
            <div class="small">Logged in as:</div>
            <%=name%>
        </div>
    </nav>
</div>