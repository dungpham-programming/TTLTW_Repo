<%@ page import="com.ltw.bean.UserBean" %>
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
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Chỉnh sửa tài khoản</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <%
                    String success = request.getParameter("success");
                    if (success != null) {
                %>
                <div class="alert alert-success">Thay đổi thành công!</div>
                <%}%>
                <form action="<c:url value="/admin/account-management/editing"/>" method="post">
                    <%
                        UserBean user = (UserBean) request.getAttribute("accountBean");
                    %>
                    <div class="row">
                        <div class="col-3">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" value="<%=user.getEmail()%>" disabled>
                        </div>

                        <div class="col-3">
                            <label for="firstName">Họ</label>
                            <input type="text" id="firstName" name="firstName" value="<%=user.getFirstName()%>" disabled>
                        </div>

                        <div class="col-3">
                            <label for="lastName">Tên</label>
                            <input type="text" id="lastName" name="lastName" value="<%=user.getLastName()%>" disabled>
                        </div>

                        <div class="col-2">
                            <label for="roleId">Phân quyền</label>
                            <select name="roleId" id="roleId">
                                <option value="1" <%= (user.getStatus() == 1) ? "selected" : "" %>>Người dùng</option>
                                <option value="2" <%= (user.getStatus() == 2) ? "selected" : "" %>>Quản trị viên</option>
                            </select>
                        </div>

                        <div class="col-1">
                            <label for="status">Trạng Thái</label>
                            <select name="status" id="status">
                                <option value="1" <%= (user.getStatus() == 1) ? "selected" : "" %>>Đã active</option>
                                <option value="2" <%= (user.getStatus() == 2) ? "selected" : "" %>>Chưa xác thực</option>
                                <option value="3" <%= (user.getStatus() == 3) ? "selected" : "" %>>Vô hiệu hóa</option>
                            </select>
                        </div>

                        <div class="col-12">
                            <label for="addressLine">Số nhà/Tên đường</label>
                            <input type="text" id="addressLine" name="addressLine" value="Đường NAQ" disabled>
                        </div>

                        <div class="col-12">
                            <label for="addressWard">Phường/Xã</label>
                            <input type="text" id="addressWard" name="addressWard" value="Phường Klfa" disabled>
                        </div>

                        <div class="col-12">
                            <label for="addressDistrict">Quận/Huyện</label>
                            <input type="text" id="addressDistrict" name="addressDistrict" value="BH" disabled>
                        </div>

                        <div class="col-12">
                            <label for="addressProvince">Tỉnh/Thành phố</label>
                            <input type="text" id="addressProvince" name="addressProvince" value="Đồng Nai" disabled>
                        </div>
                    </div>
                    <input type="hidden" name="id" value="<%=user.getId()%>">
                    <input type="submit" value="Chỉnh sửa tài khoản" class="adding button">
                    <a href="<c:url value="/admin/account-management"/>">Quay về trang quản lý</a>
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