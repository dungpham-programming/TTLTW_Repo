<%@ page import="com.ltw.bean.ProductImageBean" %>
<%@ page import="java.util.ArrayList" %>
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
<%-- Include navigation --%>
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Thêm ảnh</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <%
                    String success = (String) request.getAttribute("success");
                    if (success != null) {
                %>
                <div class="alert alert-success">
                    Chỉnh sửa ảnh thành công!
                </div>
                <% } %>
                <%
                    ProductImageBean image = (ProductImageBean) request.getAttribute("image");
                    ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");
                    if (image != null) {
                %>
                <form action="<c:url value="/admin/all-image-editing"><c:param name="id" value="<%=String.valueOf(image.getId())%>"/></c:url>" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-12">
                            <label for="name">Tên ảnh</label>
                            <input type="text" id="name" name="name" value="<%=image.getName()%>" required>
                            <% if (errors != null && errors.get(0) != null) { %>
                            <div class="error" id="error1">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="productId">Mã sản phẩm</label>
                            <input type="text" id="productId" name="productId" value="<%=image.getProductId()%>" required>
                            <% if (errors != null && errors.get(1) != null) { %>
                            <div class="error" id="error2">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="presentationImg">Thể hiện ảnh</label>
                            <img src="<%=image.getLink()%>" alt="" id="presentationImg" class="img-fluid">
                        </div>

                        <div class="col-12">
                            <label for="imageFile">Link</label>
                            <input type="file" id="imageFile" name="imageFile">
                        </div>

                        <input type="hidden" name="link" value="<%=image.getLink()%>">
                    </div>

                    <input type="submit" value="Thêm ảnh" class="adding button">
                    <input type="reset" value="Đặt lại biểu mẫu" class="adding button">
                    <a href="<c:url value="admin/all-image-management"/>">Quay về trang quản lý</a>
                    <a href="<c:url value="/admin/home"/>">Quay về trang chủ</a>
                </form>
                <% } %>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="<c:url value="/templates/admin/js/scripts.js"/>"></script>
</body>
</html>
