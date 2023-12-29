<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DDD. Admin - Management Product</title>

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
                    <a class="nav-link light-text pt-3 pb-3 " href="manage-account.html">
                        <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                        Quản lý tài khoản
                    </a>
                    <a class="nav-link light-text pt-3 pb-3 yellow-active" href="management-product.html">
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
                <h1 class="mt-4">Quản lý sản phẩm</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <div class="card mb-4 mt-4">
                    <div class="card-header">
                        <i class="fas fa-table me-1"></i>
                        Quản lý sản phẩm
                    </div>
                    <div class="list-button">
                        <a href="adding-product.html" data-bs-toggle="tooltip" title="Thêm sản phẩm" class="add"><i
                                class="fa-solid fa-plus" style="color: #e3bd74;"></i>Thêm sản phẩm</a>
                    </div>
                    <div class="table-responsive">
                        <table id="manageAccountTable">
                            <thead>
                            <tr>
                                <th>ID Sản phẩm</th>
                                <th>Tên sản phẩm</th>
                                <th>Miêu tả</th>
                                <th>Mã danh mục</th>
                                <th>Giá gốc</th>
                                <th>Giá giảm</th>
                                <th>Số lượng còn</th>
                                <th>Trạng thái</th>
                                <th>Ảnh</th>
                                <th>Tạo ngày</th>
                                <th>Tạo bởi</th>
                                <th>Sửa ngày</th>
                                <th>Sửa bởi</th>
                                <th>Chức năng</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>30001</td>
                                <td>Túi sen</td>
                                <td>Làm từ chất liệu cỏ bàng tự nhiên, túi này là biểu tượng của sự bền vững và sáng
                                    tạo.
                                    Thiết kế đơn giản nhưng tinh tế, túi cỏ bàng mang lại không gian rộng rãi và thoải
                                    mái cho đồ đạc cá nhân.
                                    Dây đeo êm ái, làn da tự nhiên, và hoa văn tự nhiên tạo nên sự duyên dáng.
                                    Sự giao thoa giữa thiên nhiên và thời trang, túi cỏ bàng là sự lựa chọn độc đáo cho
                                    những ai yêu thích phong cách eco-friendly
                                </td>
                                <td>00003</td>
                                <td>500.000đ</td>
                                <td>450.000đ</td>
                                <td>150</td>
                                <td>Còn hàng</td>
                                <td>
                                    <img src="../assets/img/tui_sen_1.jpg" alt="">
                                    <img src="../assets/img/tui_sen_2.jpg" alt="">
                                    <img src="../assets/img/tui_sen_3.jpg" alt="">
                                </td>
                                <td>03/06/2023</td>
                                <td>admin3</td>
                                <td>null</td>
                                <td>null</td>
                                <td>
                                    <a href="editing-product.html" data-bs-toggle="tooltip" title="Chỉnh sửa sản phẩm" class="edit"><i
                                            class="fa-regular fa-pen-to-square" style="color: #e3bd74;"></i></a>
                                    <a href="#" data-bs-toggle="tooltip" title="Xóa sản phẩm" class="delete"><i
                                            class="fa-solid fa-trash" style="color: #e3bd74;"></i></a>
                                </td>
                            </tr>
                            </tbody>

                            <tbody>
                            <tr>
                                <td>30011</td>
                                <td>Thùng rác hình thú(voi)</td>
                                <td>Sự sáng tạo gặp gỡ với bảo vệ môi trường trong sọt rác lụt bình này.
                                    Được làm từ lụt bình tái chế, mỗi chiếc sọt là một tác phẩm nghệ thuật duyên dáng.
                                    Thiết kế đan tinh tế tạo nên không gian lớn cho việc thu gom rác một cách tiện lợi.
                                    Đường nét tự nhiên của lụt bình tạo nên sự độc đáo và sinh động.
                                    Sự hòa quyện giữa nghệ thuật và bảo vệ môi trường, sọt rác đan bằng lụt bình
                                    là sự chọn lựa ý nghĩa cho những người muốn góp phần vào việc giảm lượng rác thải.
                                </td>
                                <td>00003</td>
                                <td>700.000đ</td>
                                <td>550.000đ</td>
                                <td>97</td>
                                <td>Còn hàng</td>
                                <td>
                                    <img src="../assets/img/tui_sen_1.jpg" alt="">
                                    <img src="../assets/img/tui_sen_2.jpg" alt="">
                                    <img src="../assets/img/tui_sen_3.jpg" alt="">
                                </td>
                                <td>23/06/2023</td>
                                <td>admin3</td>
                                <td>null</td>
                                <td>null</td>
                                <td>
                                    <a href="#" data-bs-toggle="tooltip" title="Chỉnh sửa sản phẩm" class="edit"><i
                                            class="fa-regular fa-pen-to-square" style="color: #e3bd74;"></i></a>
                                    <a href="#" data-bs-toggle="tooltip" title="Xóa sản phẩm" class="delete"><i
                                            class="fa-solid fa-trash" style="color: #e3bd74;"></i></a>
                                </td>
                            </tr>
                            </tbody>

                            <tbody>
                            <tr>
                                <td>30044</td>
                                <td>Nhà ngủ thú cưng</td>
                                <td>Chỗ ngủ thú cưng bằng lục bình - Nơi an lành và thoải mái cho người bạn thân của bạn.
                                    Chất liệu tự nhiên giúp tạo không gian dễ chịu và thoáng mát.
                                    Thiết kế đẹp mắt và bền bỉ, mang đến cho thú cưng của bạn không gian riêng tư .
                                </td>
                                <td>00003</td>
                                <td>1.300.000đ</td>
                                <td>1.250.000đ</td>
                                <td>72</td>
                                <td>Còn hàng</td>
                                <td>
                                    <img src="../assets/img/tui_sen_1.jpg" alt="">
                                    <img src="../assets/img/tui_sen_2.jpg" alt="">
                                    <img src="../assets/img/tui_sen_3.jpg" alt="">
                                </td>
                                <td>23/07/2023</td>
                                <td>admin3</td>
                                <td>null</td>
                                <td>null</td>
                                <td>
                                    <a href="#" data-bs-toggle="tooltip" title="Chỉnh sửa sản phẩm" class="edit"><i
                                            class="fa-regular fa-pen-to-square" style="color: #e3bd74;"></i></a>
                                    <a href="#" data-bs-toggle="tooltip" title="Xóa sản phẩm" class="delete"><i
                                            class="fa-solid fa-trash" style="color: #e3bd74;"></i></a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="<c:url value="/templates/admin/js/scripts.js"/>"></script>
</body>
</html>