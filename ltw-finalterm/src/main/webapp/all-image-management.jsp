<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.ProductImageBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>DDD. Admin - Manage Account</title>

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
<%-- Include navigation --%>
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý tất cả ảnh sản phẩm</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <div class="card mb-4 mt-4">
                    <div class="card-header">
                        <i class="fas fa-table me-1"></i>
                        Quản lý ảnh
                    </div>
                    <div class="list-button">
                        <a href="<c:url value="/admin/all-image-adding"/>" data-bs-toggle="tooltip" title="Thêm ảnh" class="add"><i
                                class="fa-solid fa-plus" style="color: #e3bd74;"></i>Thêm ảnh</a>
                    </div>
                    <div class="table-responsive">
                        <table id="manageAccountTable">
                            <thead>
                            <tr>
                                <th>ID Ảnh</th>
                                <th>Tên</th>
                                <th>Link</th>
                                <th>Mã loại sản phẩm</th>
                                <th>Tạo ngày</th>
                                <th>Tạo bởi</th>
                                <th>Sửa ngày</th>
                                <th>Sửa bởi</th>
                                <th>Chức năng</th>
                            </tr>
                            </thead>
                            <%
                                List<ProductImageBean> allImages = (List<ProductImageBean>) request.getAttribute("allImages");
                                if (allImages != null) {
                                    for (ProductImageBean image : allImages) {
                            %>
                            <tbody>
                            <tr>
                                <td><%=image.getId()%></td>
                                <td><%=image.getName()%></td>
                                <td><img class="img-fluid" src="<%=image.getLink()%>" alt="image"></td>
                                <td><%=image.getProductId()%></td>
                                <td><%=image.getCreatedDate()%></td>
                                <td><%=image.getCreatedBy()%></td>
                                <td><%=image.getModifiedDate()%></td>
                                <td><%=image.getModifiedBy()%></td>
                                <td>
                                    <a href="<c:url value="/admin/all-image-editing"><c:param name="id" value="<%=String.valueOf(image.getId())%>"/></c:url>" data-bs-toggle="tooltip" title="Chỉnh sửa ảnh"
                                       class="edit"><i class="fa-regular fa-pen-to-square" style="color: #e3bd74;"></i></a>
                                    <a href="<c:url value="/admin/all-image-delete"><c:param name="id" value="<%=String.valueOf(image.getId())%>"/></c:url>" data-bs-toggle="tooltip" title="Xóa ảnh" class="delete"><i
                                            class="fa-solid fa-trash" style="color: #e3bd74;"></i></a>
                                </td>
                            </tr>
                            </tbody>
                            <% } %>
                        <% } %>
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
