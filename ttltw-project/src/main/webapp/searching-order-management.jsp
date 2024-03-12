<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DDD. Admin - Tìm kiếm chi tiết đơn hàng</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
</head>
<body class="sb-nav-fixed">
<%@ include file="/common/admin/top-header.jsp" %>
<div id="layoutSidenav">
    <%@ include file="/common/admin/left-navigation.jsp" %>

    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Kiểm tra chi tiết đơn hàng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <form id="searching-order-detail" action="<c:url value="/admin/order-detail-search"/>" method="post">
                    <div class="row">
                        <!-- Thêm input nhớ xóa mb-4 -->
                        <div class="col-12 mb-4">
                            <label for="orderId">ID Đơn hàng</label>
                            <input type="text" id="orderId" name="orderId">
                        </div>
                        <div id="error"></div>
                    </div>

                    <!-- Làm với backend sẽ sử dung input -->
                    <input type="submit" value="Kiểm tra" class="adding button">
                    <a href="<c:url value="/admin/home"/>">Quay về trang chủ</a>
                </form>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
</body>
</html>
