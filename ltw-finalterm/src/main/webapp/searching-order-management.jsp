<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<%@ include file="/common/admin/top-header.jsp" %>
<div id="layoutSidenav">
    <%@ include file="/common/admin/left-navigation.jsp" %>

    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Kiểm tra chi tiết đơn hàng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <form id="searching-order-detail" action="<c:url value="/admin/order-detail-search"/>" method="post">
                    <div class="row">
                        <!-- Thêm input nhớ xóa mb-4 -->
                        <div class="col-12 mb-4">
                            <label for="orderId">ID Đơn hàng</label>
                            <input type="text" id="orderId" name="orderId">
                        </div>
                        <div id="error"></div>
                    </div>

                    <!-- Làm với backend sẽ sử dung input -->
                    <input type="submit" value="Kiểm tra" class="adding button">
                    <a href="<c:url value="/admin/home"/>">Quay về trang chủ</a>
                </form>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="<c:url value="/templates/admin/js/scripts.js"/>"></script>
</body>
</html>
