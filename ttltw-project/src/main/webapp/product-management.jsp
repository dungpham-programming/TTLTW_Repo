<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.ProductBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>DDD. Admin - Quản lý sản phẩm</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
</head>
<body class="sb-nav-fixed">
<%-- Include navigation --%>
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
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
                        <a href="<c:url value="/admin/product-management/adding"/>" data-bs-toggle="tooltip"
                           title="Thêm sản phẩm" class="add"><i
                                class="fa-solid fa-plus" style="color: #e3bd74;"></i>Thêm sản phẩm</a>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <table id="productData" class="table table-striped" style="width:100%">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Giới thiệu</th>
                                    <th>Mã danh mục</th>
                                    <th>Giá gốc</th>
                                    <th>Giá giảm</th>
                                    <th>%</th>
                                    <th>Còn lại</th>
                                    <th>Đã bán</th>
                                    <th>Đánh giá</th>
                                    <th>Số lượng đánh giá</th>
                                    <th>Ảnh</th>
                                    <th>Kích thước</th>
                                    <th>Đặc điểm khác</th>
                                    <th>Trạng thái</th>
                                    <th>Từ khóa</th>
                                    <th>Tạo ngày</th>
                                    <th>Tạo bởi</th>
                                    <th>Sửa ngày</th>
                                    <th>Sửa bởi</th>
                                    <th>Chức năng</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th>#</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Giới thiệu</th>
                                    <th>Mã danh mục</th>
                                    <th>Giá gốc</th>
                                    <th>Giá giảm</th>
                                    <th>%</th>
                                    <th>Còn lại</th>
                                    <th>Đã bán</th>
                                    <th>Đánh giá</th>
                                    <th>Số lượng đánh giá</th>
                                    <th>Ảnh</th>
                                    <th>Kích thước</th>
                                    <th>Đặc điểm khác</th>
                                    <th>Trạng thái</th>
                                    <th>Từ khóa</th>
                                    <th>Tạo ngày</th>
                                    <th>Tạo bởi</th>
                                    <th>Sửa ngày</th>
                                    <th>Sửa bởi</th>
                                    <th>Chức năng</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Modal Description -->
<div class="modal fade" id="showDescription" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5">Giới thiệu</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p class="description-content"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Images -->
<div class="modal fade" id="showImgs" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5">Ảnh sản phẩm</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="display-images">
                    <div id="imgsCarousel" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-indicators">
                            <!-- Indicators will be inserted here by jQuery -->
                        </div>
                        <div class="carousel-inner">
                            <!-- Images will be inserted here by jQuery -->
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#imgsCarousel" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#imgsCarousel" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
<script src="<c:url value="/templates/logic-datatable/admin/datatable-product.js"/>"></script>
<script src="<c:url value="/templates/logic-datatable/service-logic.js"/>"></script>
<script src="<c:url value="/templates/modal/show-modal.js"/>"></script>
</body>
</html>