<%@ page import="com.ltw.bean.OrderBean" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="../favicon.png">

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

    <!-- Bootstrap CSS -->
    <link href="<c:url value="templates/client/css/bootstrap.min.css"/>" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="<c:url value="/templates/client/css/tiny-slider.css"/>" rel="stylesheet">
    <link href="<c:url value="/templates/client/css/style.css"/>" rel="stylesheet">

    <title>DDD. - Nghệ thuật mỹ nghệ</title>
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
    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
    <div class="alert alert-danger">Lỗi hệ thống</div>
    <%}%>
    <div class="container">
        <div class="table-responsive">
            <table id="orderHistory">
                <thead>

                <tr>
                    <th>ID Đơn hàng</th>
                    <th>Ngày tạo</th>
                    <th>Ngày nhận</th>
                    <th>Tổng tiền</th>
                    <td>Trạng thái</td>
                    <th>Chức năng</th>

                </tr>
                </thead>
                <%
                    List<OrderBean> listOrder = (List<OrderBean>) request.getAttribute("orderList");
                    for (OrderBean order : listOrder){
                        String idStr = String.valueOf(order.getUserId());
                %>
                <tbody>
                <tr>
                    <td><%=order.getId()%></td>
                    <td><fmt:formatDate value="<%= order.getCreatedDate() %>" pattern="dd/MM/yyyy" /></td>
                    <td><fmt:formatDate value="<%= order.getShipToDate() %>" pattern="dd/MM/yyyy" /></td>
                    <td><fmt:formatNumber value="<%=order.getTotal()%>" pattern="#,##0.##"/>đ</td>
                    <% if (order.getStatus() == 1) { %>
                    <td>Chờ xác nhận</td>
                    <% } else if (order.getStatus() == 2) { %>
                    <td>Đã xác nhận</td>
                    <% } else if (order.getStatus() == 3) { %>
                    <td>Đang vận chuyển</td>
                    <% } else if (order.getStatus() == 4) { %>
                    <td>Thành công</td>
                    <% } else if (order.getStatus() == 0) { %>
                    <td>Đã hủy</td>
                    <% } %>
                    <td>
                        <a href="<c:url value="/order-detail-history"><c:param name="orderId" value="<%=String.valueOf(order.getId())%>"/></c:url>" data-bs-toggle="tooltip" title="Chi tiết đơn hàng"
                           class="edit"><i class="fa-solid fa-info fa-xl" style="color: #e3bd74;"></i></a>
                        <a href="<c:url value="/order-history">
                                    <c:param name="action" value="cancel"/>
                                    <c:param name="orderId" value="<%=String.valueOf(order.getId())%>"/>
                                 </c:url>" data-bs-toggle="tooltip" title="Hủy đơn hàng" class="delete"><i
                                class="fa-solid fa-trash" style="color: #e3bd74;"></i></a>
                    </td>
                </tr>
                </tbody>
                <% } %>
            </table>
        </div>
        <div class="return-btn">
            <a href="<c:url value="/home"/>" class="checking-order-detail">Quay về trang chủ</a>
        </div>
    </div>
</div>
<!-- End Renew Password -->

<jsp:include page="/common/client/footer.jsp"/>

<script src="<c:url value="/templates/client/js/bootstrap.bundle.min.js"/>"></script>
<script src="<c:url value="/templates/client/js/tiny-slider.js"/>"></script>
<%--<script src="../js/reset-password.js"></script>--%>
<script src="<c:url value="/templates/client/js/custom.js"/>"></script>
</body>

</html>