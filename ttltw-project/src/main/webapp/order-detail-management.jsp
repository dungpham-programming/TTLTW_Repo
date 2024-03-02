<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.OrderDetailBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DDD. Admin - Quản lý chi tiết đơn hàng</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
</head>
<body>
<%@ include file="/common/admin/top-header.jsp" %>
<div id="layoutSidenav">
    <%@ include file="/common/admin/left-navigation.jsp" %>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Chỉnh sửa chi tiết đơn hàng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>

                <div class="card mb-4 mt-4">
                    <div class="card-header">
                        <i class="fas fa-table me-1"></i>
                        Chi tiết đơn hàng
                    </div>
                    <div class="table-responsive">
                        <table id="manageAccountTable">
                            <thead>
                            <tr>
                                <th>ID Sản phẩm</th>
                                <th>Tên sản phẩm</th>
                                <th>Giá gốc</th>
                                <th>Giá giảm</th>
                                <th>Phần trăm</th>
                                <th>Số lượng</th>
                            </tr>
                            </thead>
                            <%
                                List<OrderDetailBean> orderDetailList = (List<OrderDetailBean>) request.getAttribute("orderDetailList");
                                for (OrderDetailBean orderDetail : orderDetailList) {
                            %>
                            <tbody>
                            <tr>
                                <td><%=orderDetail.getProductId()%></td>
                                <td><%=orderDetail.getProductName()%></td>
                                <td><fmt:formatNumber value="<%=orderDetail.getOriginalPrice()%>" pattern="#,##0.##"/>đ</td>
                                <td><fmt:formatNumber value="<%=orderDetail.getDiscountPrice()%>" pattern="#,##0.##"/>đ</td>
                                <td><fmt:formatNumber value="<%=orderDetail.getDiscountPercent()%>" pattern="#.##"/>%</td>
                                <td><fmt:formatNumber value="<%=orderDetail.getQuantity()%>" pattern="#,##0.##"/></td>
                            </tr>
                            </tbody>
                            <% } %>
                        </table>
                    </div>
                </div>
                <a href="<c:url value="/admin/order-management"/>" class="checking-order-detail">Quay về trang quản lý</a>
                <a href="<c:url value="/admin/order-detail-search"/>" class="checking-order-detail">Quay về trang tìm đơn hàng</a>
                <a href="<c:url value="/admin/home"/>" class="checking-order-detail">Quay về trang chủ</a>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
</body>
</html>
