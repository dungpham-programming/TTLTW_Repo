<%@ page import="com.ltw.bean.UserBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>DDD. Admin - Chỉnh sửa tài khoản</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
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
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                <%= (msg.equals("success") ? "<div class=\"alert alert-success\">Thay đổi thành công!</div>" : "<div class=\"alert alert-danger\">Thay đổi thất bại!</div>") %>
                <%}%>
                <form action="<c:url value="/admin/account-management/editing"/>" method="post">
                    <%
                        UserBean user = (UserBean) request.getAttribute("displayUser");
                        if (user != null) {
                    %>
                    <div class="row">
                        <div class="col-3">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" value="<%=user.getEmail()%>">
                        </div>

                        <div class="col-3">
                            <label for="firstName">Họ</label>
                            <input type="text" id="firstName" name="firstName" value="<%=user.getFirstName()%>">
                        </div>

                        <div class="col-3">
                            <label for="lastName">Tên</label>
                            <input type="text" id="lastName" name="lastName" value="<%=user.getLastName()%>">
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
                    <input type="hidden" name="id" value="<%=user.getId()%>">
                    <input type="submit" value="Chỉnh sửa tài khoản" class="adding button">
                    <a href="<c:url value="/admin/account-management"/>">Quay về trang quản lý</a>
                    <a href="<c:url value="/admin/home"/>">Quay về trang chủ</a>
                </form>
                <%} else {%>
                <div class="alert alert-danger">Lỗi hệ thống!</div>
                <%}%>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
</body>
</html>