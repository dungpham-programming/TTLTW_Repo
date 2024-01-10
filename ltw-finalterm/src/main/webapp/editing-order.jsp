<%@ page import="com.ltw.bean.OrderBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DDD. Admin - Thêm tài khoản</title>

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<c:url value="/templates/admin/css/styles.css"/>">
    <link rel="stylesheet" href="<c:url value="/templates/admin/css/admin-custom.css"/>">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
<nav class="sb-topnav navbar navbar-expand navbar-darkred">
    <!-- Navbar Brand-->
    <a class="navbar-brand ps-3 logo fs-4" href="<c:url value="/home"/>">DDD. Admin</a>
    <!-- Sidebar Toggle-->
    <button class="btn btn-lg yellow-hv gray order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i
            class="fas fa-bars"></i></button>
    <ul class="navbar-nav ms-auto me-3 me-lg-4">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown yellow-hv" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown"
               aria-expanded="false"><i class="fa-thin fa-user fa-lg" style="color: #f0f0f0;"></i></a>
            <ul class="dropdown-menu dropdown-menu-end navbar-darkred" aria-labelledby="navbarDropdown">
                <li class="hi-admin light-text">Xin chào, <a class="highlight-admin" href="admin-info.html">quản trị viên!</a></li>
                <li><hr class="dropdown-divider" /></li>
                <li><a class="dropdown-item light-text" href="admin-info.html">Tài khoản hiện tại</a></li>
                <li><a class="dropdown-item light-text" href="#">Đăng xuất</a></li>
            </ul>
        </li>
    </ul>
</nav>
<div id="layoutSidenav">
    <div id="layoutSidenav_nav">
        <nav class="sb-sidenav accordion sb-sidenav-dark navbar-darkred mt-3" id="sidenavAccordion">
            <div class="sb-sidenav-menu">
                <div class="nav">
                    <div class="sb-sidenav-menu-heading gray">Quản trị viên</div>
                    <a class="nav-link pt-3 pb-3" href="index.html">
                        <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                        Trang chủ
                    </a>
                    <a class="nav-link light-text pt-3 pb-3" href="manage-account.html">
                        <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                        Quản lý tài khoản
                    </a>
                    <a class="nav-link light-text pt-3 pb-3" href="management-product.html">
                        <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                        Quản lý sản phẩm
                    </a>
                    <a class="nav-link light-text pt-3 pb-3 yellow-active" href="<c:url value="/admin/order-management"/>">
                        <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                        Quản lý đơn hàng
                    </a>
                    <a class="nav-link light-text pt-3 pb-3" href="management-blog.html">
                        <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                        Quản lý tin tức
                    </a>
                    <a class="nav-link light-text pt-3 pb-3" href="management-contact.html">
                        <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                        Quản lý liên hệ
                    </a>
                    <a class="nav-link light-text pt-3 pb-3" href="manage-image.html">
                        <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                        Quản lý ảnh sản phẩm
                    </a>
                    <a class="nav-link light-text pt-3 pb-3" href="order-detail.html">
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
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Chỉnh sửa đơn hàng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <%
                    OrderBean orderBean = (OrderBean) request.getAttribute("orderBean");
                    ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");
                    String success = request.getParameter("success");

                %>
                <% if (success != null) { %>
                <div class="alert alert-success">
                    Chỉnh sửa đơn hàng thành công!
                </div>
                <% } %>
                <form action="<c:url value="/admin/order-management/editing"/>" method="post">
                    <div class="row">
                        <div class="col-6">
                            <label for="email">Email</label>
                            <input type="text" id="email" name="email" value="13001" disabled>
                        </div>

                        <div class="col-3">
                            <label for="createdDate">Ngày đặt</label>
                            <input type="text" id="createdDate" name="createdDate" value="<%=orderBean.getCreatedDate()%>>" disabled>
                        </div>

                        <div class="col-3">
                            <label for="shipToDate">Ngày giao</label>
                            <input type="text" id="shipToDate" name="shipToDate" value="<%=orderBean.getShipToDate()%>>" disabled>
                        </div>

                        <div class="col-6">
                            <label for="total">Tổng trị giá</label>
                            <input type="email" id="total" name="total" value="<%=orderBean.getTotal()%>>" disabled>
                            <% if (errors != null && errors.get(3) != null) { %>
                            <div class="error" id="error4">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-6">
                            <label for="status">Trạng thái</label>
                            <select type="text" id="status" name="status">
                            <option value="1" <%= (orderBean.getStatus() == 1) ? "selected" : "" %>>Thành công</option>
                            <option value="2" <%= (orderBean.getStatus() == 2) ? "selected" : "" %>>Chờ xác nhận</option>
                            <option value="3" <%= (orderBean.getStatus() == 3) ? "selected" : "" %>>Đang vận chuyển</option>
                            <option value="3" <%= (orderBean.getStatus() == 4) ? "selected" : "" %>>Hủy bỏ</option>
                            </select>
                            <% if (errors != null && errors.get(9) != null) { %>
                            <div class="error" id="error10">Không được để trống!</div>
                            <% } %>
                        </div>
                    </div>
                    <input type="hidden" name="id" value="<%=orderBean.getId()%>">

                    <input type="submit" value="Chỉnh sửa đơn hàng" class="adding button">
                    <a href="<c:url value="/admin/order-management"/>">Quay về trang quản lý</a>
                    <a href="<c:url value="/admin/home"/>">Quay về trang chủ</a>
                </form>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="<c:url value="/templates/admin/js/scripts.js"/>"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="../assets/demo/chart-area-demo.js"></script>
<script src="../assets/demo/chart-bar-demo.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
        crossorigin="anonymous"></script>
<script src="../js/datatables-simple-demo.js"></script>
</body>
</html>
