<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>DDD. Admin - Thêm kho</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Thêm kho</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <%
                    ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");
                    String msg = (String) request.getAttribute("msg");
                %>
                <%
                    if (msg != null) {
                %>
                <%= (msg.equals("success") ? "<div class=\"alert alert-success\">Thay đổi thành công!</div>" : "<div class=\"alert alert-danger\">Thay đổi thất bại!</div>") %>
                <%}%>
                <form action="<c:url value="/admin/warehouse-management/adding"/>" method="post">
                    <div class="row">
                        <div class="col-12">
                            <label for="shippingFrom">Gửi từ</label>
                            <input type="text" id="shippingFrom" name="shippingFrom" required>
                            <% if (errors != null && errors.get(0) != null) { %>
                            <div class="error" id="error0">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-6">
                            <label for="shippingStart">Ngày bắt đầu gửi</label>
                            <input type="datetime-local" id="shippingStart" name="shippingStart" required>
                            <% if (errors != null && errors.get(1) != null) { %>
                            <div class="error" id="error1">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-6">
                            <label for="shippingDone">Ngày kết thúc gửi</label>
                            <input type="datetime-local" id="shippingDone" name="shippingDone" required>
                            <% if (errors != null && errors.get(2) != null) { %>
                            <div class="error" id="error2">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="description">Mô tả</label>
                            <input type="text" id="description" name="description" required>
                            <% if (errors != null && errors.get(3) != null) { %>
                            <div class="error" id="error3">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="createdBy">Tạo bởi</label>
                            <input type="text" id="createdBy" name="createdBy" required>
                            <% if (errors != null && errors.get(4) != null) { %>
                            <div class="error" id="error4">Không được để trống!</div>
                            <% } %>
                        </div>
                    </div>

                    <input type="submit" value="Thêm kho" class="adding button">
                    <input type="reset" value="Đặt lại biểu mẫu" class="adding button">
                    <a href="<c:url value="/admin/warehouse-management"/>">Quay về trang quản lý</a>
                    <a href="<c:url value="/admin/home"/>">Quay về trang chủ</a>
                </form>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
</body>
</html>

