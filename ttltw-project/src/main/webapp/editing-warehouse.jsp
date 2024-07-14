<%@ page import="com.ltw.bean.WarehouseBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>DDD. Admin - Chỉnh sửa kho</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Chỉnh sửa kho</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <%
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                <%= (msg.equals("success") ? "<div class=\"alert alert-success\">Thay đổi thành công!</div>" : "<div class=\"alert alert-danger\">Thay đổi thất bại!</div>") %>
                <%}%>
                <form action="<c:url value="/admin/warehouse-management/editing"/>" method="post">
                    <%
                        WarehouseBean warehouse = (WarehouseBean) request.getAttribute("displayWarehouse");
                        if (warehouse != null) {
                    %>
                    <div class="row">
                        <div class="col-12">
                            <label for="shippingFrom">Gửi từ</label>
                            <input type="text" id="shippingFrom" name="shippingFrom" value="<%=warehouse.getShippingFrom()%>" required>
                        </div>

                        <div class="col-6">
                            <label for="shippingStart">Ngày bắt đầu gửi</label>
                            <input type="datetime-local" id="shippingStart" name="shippingStart" value="<%=warehouse.getShippingStart()%>" required>
                        </div>

                        <div class="col-6">
                            <label for="shippingDone">Ngày kết thúc gửi</label>
                            <input type="datetime-local" id="shippingDone" name="shippingDone" value="<%=warehouse.getShippingDone()%>" required>
                        </div>

                        <div class="col-12">
                            <label for="description">Mô tả</label>
                            <input type="text" id="description" name="description" value="<%=warehouse.getDescription()%>" required>
                        </div>

                        <div class="col-12">
                            <label for="createdBy">Tạo bởi</label>
                            <input type="text" id="createdBy" name="createdBy" value="<%=warehouse.getCreatedBy()%>" required>
                        </div>
                    </div>
                    <input type="hidden" name="id" value="<%=warehouse.getId()%>">
                    <input type="submit" value="Chỉnh sửa kho" class="adding button">
                    <a href="<c:url value="/admin/warehouse-management"/>">Quay về trang quản lý</a>
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
