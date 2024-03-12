<%@ page import="com.ltw.bean.OrderDetailBean" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <jsp:include page="/common/client/using-resource-header.jsp"/>
    <title>DDD. - Chi tiết lịch sử mua hàng</title>
</head>

<body>
<jsp:include page="/common/client/header.jsp"/>

<!-- Start Hero Section -->
<div class="hero home position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-12">
                <div class="intro-excerpt">
                    <h1>Lịch sử đơn hàng</h1>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Hero Section -->

<!-- Start Renew Password -->
<div class="renew-password position-relative-top-84px">
    <div class="container">
        <div class="table-responsive">
            <table id="orderHistory">
                <thead>
                <th>Mã đặt hàng</th>
                <th>Tên sản phẩm</th>
                <th>Giá gốc</th>
                <th>Giá giảm</th>
                <th>Số lượng</th>
                </thead>
                <tbody>
                <%
                    List<OrderDetailBean> listOrderDetail = (List<OrderDetailBean>) request.getAttribute("orderDetails");
                    for (OrderDetailBean orderDetail : listOrderDetail) {
                        String idStr = String.valueOf(orderDetail.getOrderId());


                %>
                <tr>
                    <td><%=orderDetail.getOrderId()%></td>
                    <% if (orderDetail.getProductName() != null) {%>
                    <td><%= orderDetail.getProductName()%></td>
                    <% } %>
                    <td><fmt:formatNumber value="<%=orderDetail.getOriginalPrice()%>" pattern="#,##0.##"/>đ</td>
                    <td><fmt:formatNumber value="<%=orderDetail.getDiscountPrice()%>" pattern="#,##0.##"/>đ</td>
                    <td><%=orderDetail.getQuantity()%></td>
                </tr>
                </tbody>
                <%}%>
            </table>
        </div>
        <div class="return-btn">
            <a href="<c:url value="/order-history"/>" class="checking-order-detail">Quay về đơn hàng</a>
            <a href="<c:url value="/home"/>" class="checking-order-detail">Quay về trang chủ</a>
        </div>
    </div>
</div>
<!-- End Renew Password -->

<jsp:include page="/common/client/footer.jsp"/>

<jsp:include page="/common/client/using-resource-footer.jsp"/>
</body>
</html>