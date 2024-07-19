<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>DDD. - Homepage</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
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
                                <h6>Số tài khoản người dùng: <%=countUser.get(3)%></h6>
                                <h6>Số tài khoản quản trị viên: <%=countUser.get(4)%></h6>
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

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
</body>
</html>
