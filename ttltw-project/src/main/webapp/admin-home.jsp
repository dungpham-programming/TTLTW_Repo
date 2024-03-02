<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>Dashboard - SB Admin</title>

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
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <%
            List<Integer> countUser = (List<Integer>) request.getAttribute("countUser");
            List<Integer> countProduct = (List<Integer>) request.getAttribute("countProduct");
            List<Integer> countOrder = (List<Integer>) request.getAttribute("countOrder");
        %>
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Trang chủ</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>

                <div class="row">
                    <div class="col-xl-6">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-chart-area me-1"></i>
                                Tài khoản
                            </div>
                            <div class="card-body">
                                <h6>Tổng số tài khoản: <%=countUser.get(0)%></h6>
                                <h6>Số tài khoản còn hoạt động: <%=countUser.get(1)%></h6>
                                <h6>Số tài khoản bị vô hiệu hóa: <%=countUser.get(2)%></h6>
                                <h6>Số tài khoản quản trị viên: <%=countUser.get(3)%></h6>
                                <h6>Số tài khoản người dùng: <%=countUser.get(4)%></h6>
                                <a href="<c:url value="/admin/account-management"/>" class="to-manage-link">Quản lý tài khoản</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-6">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-chart-area me-1"></i>
                                Sản phẩm
                            </div>
                            <div class="card-body">
                                <h6>Tổng số loại sản phẩm: <%=countProduct.get(0)%></h6>
                                <h6>Số sản phẩm khả dụng: <%=countProduct.get(1)%></h6>
                                <h6>Số sản phẩm hết hàng: <%=countProduct.get(2)%></h6>
                                <h6 class="missing-1-row">Số sản phẩm vô hiệu hóa: <%=countProduct.get(3)%></h6>
                                <a href="<c:url value="admin/product-management"/>" class="to-manage-link">Quản lý sản phẩm</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-6">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-chart-area me-1"></i>
                                Đơn hàng
                            </div>
                            <div class="card-body">
                                <h6>Tổng số đơn hàng: <%=countOrder.get(0)%></h6>
                                <h6>Số đơn hàng đang vận chuyển: <%=countOrder.get(1)%></h6>
                                <h6>Số đơn hàng thành công: <%=countOrder.get(2)%></h6>
                                <h6 class="missing-1-row">Số đơn hàng hủy: <%=countOrder.get(3)%></h6>
                                <a href="<c:url value="/admin/order-management"/>" class="to-manage-link">Quản lý đơn hàng</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <footer class="py-4 bg-light mt-auto">
            <div class="container-fluid px-4">
                <div class="d-flex align-items-center justify-content-between small">
                    <div class="text-muted">Copyright &copy; Your Website 2023</div>
                    <div>
                        <a href="#">Privacy Policy</a>
                        &middot;
                        <a href="#">Terms &amp; Conditions</a>
                    </div>
                </div>
            </div>
        </footer>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="<c:url value="/templates/admin/js/scripts.js"/>"></script>
</body>
</html>
