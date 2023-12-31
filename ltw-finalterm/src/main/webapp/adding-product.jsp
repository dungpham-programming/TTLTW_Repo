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
<nav class="sb-topnav navbar navbar-expand navbar-darkred">
    <!-- Navbar Brand-->
    <a class="navbar-brand ps-3 logo fs-4" href="index.html">DDD. Admin</a>
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
                    <a class="nav-link light-text pt-3 pb-3 yellow-active" href="<c:url value="/admin/product-management"/>">
                        <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                        Quản lý sản phẩm
                    </a>
                    <a class="nav-link light-text pt-3 pb-3" href="management-order.html">
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
                <h1 class="mt-4">Thêm sản phẩm</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <form action="#" method="post">
                    <div class="row">
                        <div class="col-12">
                            <label for="productName">Tên sản phẩm</label>
                            <input type="text" id="productName" name="productName" value="" required>
                        </div>

                        <div class="col-12">
                            <label for="description">Mô tả</label>
                            <textarea name="description" id="description">Làm từ chất liệu cỏ bàng tự nhiên, túi này là biểu tượng của sự bền vững và sáng tạo.
Thiết kế đơn giản nhưng tinh tế, túi cỏ bàng mang lại không gian rộng rãi và thoải mái cho đồ đạc cá nhân.
Dây đeo êm ái, làn da tự nhiên, và hoa văn tự nhiên tạo nên sự duyên dáng.
Sự giao thoa giữa thiên nhiên và thời trang, túi cỏ bàng là sự lựa chọn độc đáo cho những ai yêu thích phong cách eco-friendly
                            </textarea>
                        </div>

                        <div class="col-3">
                            <label for="categoryTypeID">Mã phân loại sản phẩm</label>
                            <input type="text" id="categoryTypeID" name="categoryTypeID" value="00003" required>
                        </div>

                        <div class="col-3">
                            <label for="originalPrice">Giá gốc</label>
                            <input type="text" id="originalPrice" name="originalPrice" value="" required>
                        </div>

                        <div class="col-3">
                            <label for="discountPrice">Giá giảm</label>
                            <input type="text" id="discountPrice" name="discountPrice" value="450.000">
                        </div>

                        <div class="col-3">
                            <label for="discountPercent">Phần trăm giảm</label>
                            <input type="text" id="discountPercent" name="discountPercent" value="" required>
                        </div>

                        <div class="col-3">
                            <label for="quantity">Số lượng còn</label>
                            <input type="text" id="quantity" name="quantity" value="150">
                        </div>

                        <div class="col-3">
                            <label for="size">Size</label>
                            <input type="text" id="size" name="size" value="150">
                        </div>

                        <div class="col-3">
                            <label for="otherSpec">Thông số khác</label>
                            <input type="text" id="otherSpec" name="otherSpec" value="150">
                        </div>

                        <div class="col-3">
                            <label for="status">Trạng thái</label>
                            <input type="text" id="status" name="status" value="150">
                        </div>

                        <div class="col-12">
                            <label for="keyword">Từ khóa tìm kiếm</label>
                            <input type="text" id="keyword" name="keyword" value="" required>
                        </div>

                        <div class="col-12">
                            <label for="images">Các ảnh của sản phẩm</label>
                            <input type="file" name="images" id="images" multiple>
                        </div>
                    </div>

                    <input type="submit" value="Thêm sản phẩm" class="adding button">
                    <input type="reset" value="Đặt lại biểu mẫu" class="adding button">
                    <a href="<c:url value="/admin/product-management"/>">Quay về trang quản lý</a>
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
