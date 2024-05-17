<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>DDD. Admin - Thêm tài khoản</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Thêm tài khoản</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <%
                    ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");
                %>
                <form action="<c:url value="/admin/account-management/adding"/>" method="post">
                    <div class="row">
                        <div class="col-6">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" required>
                            <% if (errors != null && errors.get(0) != null) { %>
                            <div class="error" id="error5">Không được để trống!</div>
                            <% } %>
                        </div>
                        <div class="col-6">
                            <label for="password">Mật khẩu</label>
                            <input type="password" id="password" name="password" required>
                            <% if (errors != null && errors.get(1) != null) { %>
                            <div class="error" id="error2">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="firstName">Họ</label>
                            <input type="text" id="firstName" name="firstName" required>
                            <% if (errors != null && errors.get(2) != null) { %>
                            <div class="error" id="error3">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="lastName">Tên</label>
                            <input type="text" id="lastName" name="lastName" required>
                            <% if (errors != null && errors.get(3) != null) { %>
                            <div class="error" id="error4">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="roleId">Phân quyền</label>
                            <select name="roleId" id="roleId">
                                <option value="1" selected>Người dùng</option>
                                <option value="2">Quản trị viên</option>
                            </select>
                        </div>

                        <div class="col-3">
                            <label for="status">Trạng thái</label>
                            <select name="status" id="status">
                                <option value="1">Đã active</option>
                                <option value="2">Chưa xác thực</option>
                                <option value="3">Vô hiệu hóa</option>
                            </select>
                        </div>

                        <div class="col-12">
                            <label for="addressLine">Số nhà/Tên đường</label>
                            <input type="text" id="addressLine" name="addressLine">
                            <% if (errors != null && errors.get(4) != null) { %>
                            <div class="error" id="error6">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="addressWard">Phường/Xã</label>
                            <input type="text" id="addressWard" name="addressWard">
                            <% if (errors != null && errors.get(5) != null) { %>
                            <div class="error" id="error7">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="addressDistrict">Quận/Huyện</label>
                            <input type="text" id="addressDistrict" name="addressDistrict">
                            <% if (errors != null && errors.get(6) != null) { %>
                            <div class="error" id="error8">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="addressProvince">Tỉnh/Thành phố</label>
                            <input type="text" id="addressProvince" name="addressProvince">
                            <% if (errors != null && errors.get(7) != null) { %>
                            <div class="error" id="error9">Không được để trống!</div>
                            <% } %>
                        </div>
                    </div>

                    <input type="submit" value="Thêm tài khoản" class="adding button">
                    <input type="reset" value="Đặt lại biểu mẫu" class="adding button">
                    <a href="<c:url value="/admin/account-management"/>">Quay về trang quản lý</a>
                    <a href="<c:url value="/admin/home"/>">Quay về trang chủ</a>
                </form>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
</body>
</html>
