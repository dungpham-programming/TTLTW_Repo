<%@ page import="com.ltw.bean.OrderBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>DDD. Admin - Chỉnh sửa đơn hàng</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Chỉnh sửa đơn hàng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <%
                    OrderBean orderBean = (OrderBean) request.getAttribute("displayOrder");
                    String msg = (String) request.getAttribute("msg");
                    // Giả sử orderBean đã được đưa vào scope (request, session, hoặc page scope)
                    Timestamp createdDate = orderBean.getCreatedDate();
                    Timestamp shipToDate = orderBean.getShipToDate();
                    String formatCreatedDate = "", formatShipToDate = "";
                    if (createdDate != null) {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        formatCreatedDate = sdf.format(new Date(createdDate.getTime()));
                        formatShipToDate = sdf.format(new Date(shipToDate.getTime()));
                    }
                %>
                <%
                    if (msg != null) {
                %>
                <%= (msg.equals("success") ? "<div class=\"alert alert-success\">Thay đổi thành công!</div>" : "<div class=\"alert alert-danger\">Thay đổi thất bại!</div>") %>
                <%}%>
                <form action="<c:url value="/admin/order-management/editing"/>" method="post">
                    <div class="row">
                        <div class="col-6">
                            <label for="email"></label>
                            <input type="text" id="email" name="email" value="<%=orderBean.getId()%>" disabled>
                        </div>

                        <div class="col-3">
                            <label for="createdDate">Ngày đặt</label>
                            <input type="date" id="createdDate" name="createdDate" value="<%=formatCreatedDate%>" disabled>
                        </div>

                        <div class="col-3">
                            <label for="shipToDate">Ngày giao</label>
                            <input type="date" id="shipToDate" name="shipToDate" value="<%=formatShipToDate%>">
                        </div>

                        <div class="col-6">
                            <label for="total">Tổng trị giá</label>
                            <input type="email" id="total" name="total" value="<fmt:formatNumber value="<%=orderBean.getTotal()%>" pattern="#,##0.0"/>đ" disabled>
                        </div>

                        <div class="col-6">
                            <label for="status">Trạng thái</label>
                            <select type="text" id="status" name="status">
                                <option value="1" <%= (orderBean.getStatus() == 1) ? "selected" : "" %>>Chờ xác nhận</option>
                                <option value="2" <%= (orderBean.getStatus() == 2) ? "selected" : "" %>>Đã xác nhận</option>
                                <option value="3" <%= (orderBean.getStatus() == 3) ? "selected" : "" %>>Đang vận chuyển</option>
                                <option value="4" <%= (orderBean.getStatus() == 4) ? "selected" : "" %>>Thành công</option>
                                <option value="0" <%= (orderBean.getStatus() == 0) ? "selected" : "" %>>Hủy bỏ</option>
                            </select>
                        </div>
                    </div>
                    <input type="hidden" name="id" value="<%=orderBean.getId()%>">

                    <input type="submit" value="Chỉnh sửa đơn hàng" class="adding button">
                    <a href="<c:url value="/admin/order-management"/>">Quay về trang quản lý</a>
                    <a href="<c:url value="/admin/home"/>">Quay về trang chủ</a>
                </form>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
</body>
</html>
