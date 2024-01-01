<%@ page import="com.ltw.bean.ProductBean" %>
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
    <a class="navbar-brand ps-3 logo fs-4" href="index.html">DDD. Admin</a>
    <!-- Sidebar Toggle-->
    <button class="btn btn-lg yellow-hv gray order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i
            class="fas fa-bars"></i></button>
    <ul class="navbar-nav ms-auto me-3 me-lg-4">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown yellow-hv" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown"
               aria-expanded="false"><i class="fa-thin fa-user fa-lg" style="color: #f0f0f0;"></i></a>
            <ul class="dropdown-menu dropdown-menu-end navbar-darkred" aria-labelledby="navbarDropdown">
                <li class="hi-admin light-text">Xin chào, <a class="highlight-admin" href="">quản trị viên!</a></li>
                <li><hr class="dropdown-divider" /></li>
                <li><a class="dropdown-item light-text" href="#!">Tài khoản hiện tại</a></li>

                <li><a class="dropdown-item light-text" href="#!">Đăng xuất</a></li>
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
                <h1 class="mt-4">Chỉnh sửa sản phẩm</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <%
                    ProductBean productBean = (ProductBean) request.getAttribute("productBean");
                    ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");
                    String success = request.getParameter("success");
                %>
                <% if (success != null) { %>
                <div class="alert alert-success">
                    Chỉnh sửa sản phẩm thành công!
                </div>
                <% } %>
                <form action="<c:url value="/admin/product-management/editing"/>" method="post">
                    <div class="row">
                        <div class="col-12">
                            <label for="name">Tên sản phẩm</label>
                            <input type="text" id="name" name="name" placeholder="Tên sản phẩm" value="<%=productBean.getName()%>" required>
                            <% if (errors != null && errors.get(0) != null) { %>
                            <div class="error error1">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="description">Mô tả</label>
                            <textarea name="description" id="description" placeholder="Mô tả"><%=productBean.getDescription()%>
                            </textarea>
                            <% if (errors != null && errors.get(1) != null) { %>
                            <div class="error" id="error2">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="categoryTypeId">Mã phân loại sản phẩm</label>
                            <input type="text" id="categoryTypeId" name="categoryTypeId" value="<%=productBean.getCategoryTypeId()%>" required>
                            <% if (errors != null && errors.get(2) != null) { %>
                            <div class="error" id="error3">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="originalPrice">Giá gốc</label>
                            <input type="text" id="originalPrice" name="originalPrice" placeholder="(Có thể thêm chấm hoặc không)" value="<fmt:formatNumber value="<%=productBean.getOriginalPrice()%>" pattern="#,##0.##"/>" required>
                            <% if (errors != null && errors.get(3) != null) { %>
                            <div class="error" id="error4">Không được để trống!</div>
                            <% } %>
                            <div class="error" id="oPrError"></div>
                        </div>

                        <div class="col-3">
                            <label for="discountPrice">Giá giảm</label>
                            <input type="text" id="discountPrice" name="discountPrice" placeholder="(Có thể thêm chấm hoặc không)" value="<fmt:formatNumber value="<%=productBean.getDiscountPrice()%>" pattern="#,##0.##"/>">
                            <% if (errors != null && errors.get(4) != null) { %>
                            <div class="error" id="error5">Không được để trống!</div>
                            <% } %>
                            <div class="error" id="dPrError"></div>
                        </div>

                        <div class="col-3">
                            <label for="discountPercent">Phần trăm giảm</label>
                            <input type="text" id="discountPercent" name="discountPercent" placeholder="Phần trăm giảm" value="<fmt:formatNumber value="<%=productBean.getDiscountPercent()%>" pattern="#,##0.##"/>" required>
                            <% if (errors != null && errors.get(5) != null) { %>
                            <div class="error" id="error6">Không được để trống!</div>
                            <% } %>
                            <div class="error" id="dPeError"></div>
                        </div>

                        <div class="col-3">
                            <label for="quantity">Số lượng còn</label>
                            <input type="text" id="quantity" name="quantity" placeholder="(Có thể thêm dấu chấm hoặc không)" value="<%=productBean.getQuantity()%>">
                            <% if (errors != null && errors.get(6) != null) { %>
                            <div class="error" id="error7">Không được để trống!</div>
                            <% } %>
                            <div class="error" id="qError"></div>
                        </div>

                        <div class="col-3">
                            <label for="size">Size</label>
                            <input type="text" id="size" name="size" value="<%=productBean.getSize()%>" required>
                            <% if (errors != null && errors.get(7) != null) { %>
                            <div class="error" id="error8">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="otherSpec">Thông số khác</label>
                            <input type="text" id="otherSpec" name="otherSpec" value="<%=productBean.getOtherSpec()%>">
                            <% if (errors != null && errors.get(8) != null) { %>
                            <div class="error" id="error9">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="status">Trạng thái</label>
                            <input type="text" id="status" name="status" value="<%=productBean.getStatus()%>" required>
                            <% if (errors != null && errors.get(9) != null) { %>
                            <div class="error" id="error10">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="keyword">Từ khóa tìm kiếm</label>
                            <input type="text" id="keyword" name="keyword" value="<%=productBean.getKeyword()%>" required>
                            <% if (errors != null && errors.get(10) != null) { %>
                            <div class="error" id="error11">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="images">Các ảnh của sản phẩm</label>
                            <input type="file" name="images" id="images" multiple>
                            <div class="error" id="error12"></div>
                        </div>
                    </div>

                    <input type="hidden" name="id" value="<%=productBean.getId()%>">

                    <input type="submit" value="Chỉnh sửa sản phẩm" class="adding button">
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