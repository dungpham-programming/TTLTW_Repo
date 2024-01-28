<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
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
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Thông tin cá nhân</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>

                <form action="<c:url value="/admin-info?editing"/>" method="post">
                    <div class="row">
                        <div class="col-12">
                            <label for="username">Tên tài khoản</label>
                            <input type="text" id="username" name="username" required>
                        </div>

                        <div class="col-6">
                            <label for="firstName">Họ</label>
                            <input type="text" id="firstName" name="firstName" required>
                        </div>

                        <div class="col-6">
                            <label for="lastName">Tên</label>
                            <input type="text" id="lastName" name="lastName" required>
                        </div>

                        <div class="col-6">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" required>
                        </div>

                        <div class="col-3">
                            <label for="roleID">Mã phân quyền</label>
                            <input type="text" id="roleID" name="roleID" required>
                        </div>

                        <div class="col-3">
                            <label for="status">Trạng thái</label>
                            <input type="text" id="status" name="status" required>
                        </div>

                        <div class="col-12">
                            <label for="addressLine">Số nhà/Tên đường</label>
                            <input type="text" id="addressLine" name="addressLine">
                        </div>

                        <div class="col-12">
                            <label for="addressWard">Phường/Xã</label>
                            <input type="text" id="addressWard" name="addressWard">
                        </div>

                        <div class="col-12">
                            <label for="addressDistrict">Quận/Huyện</label>
                            <input type="text" id="addressDistrict" name="addressDistrict">
                        </div>

                        <div class="col-12">
                            <label for="addressProvince">Tỉnh/Thành phố</label>
                            <input type="text" id="addressProvince" name="addressProvince">
                        </div>
                    </div>

                    <input type="submit" value="Chỉnh sửa tài khoản" class="adding button">
                    <a href="index.html">Quay về trang chủ</a>
                    <a href="renew-password.html" class="changing-password-link">Bạn muốn đổi mật khẩu? Click vào đây</a>
                </form>
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