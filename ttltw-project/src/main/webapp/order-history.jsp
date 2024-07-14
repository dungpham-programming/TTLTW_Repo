<%@ page import="com.ltw.bean.OrderBean" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <jsp:include page="/common/client/using-resource-header.jsp"/>
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
<div class="renew-password position-relative-top-84px" style="background-color: #eeeeee; padding-top: 2rem">
    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
    <div class="alert alert-danger">Lỗi hệ thống</div>
    <%}%>
    <div class="container">
        <div class="card">
            <div class="card-body">
                <div class="table table-striped" style="margin-top: 20px;">
                    <table id="orderHistory" class="table table-striped">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Ngày tạo</th>
                            <th>Ngày nhận</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Chức năng</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                        <tfoot>
                        <tr>
                            <th>#</th>
                            <th>Ngày tạo</th>
                            <th>Ngày nhận</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Chức năng</th>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
        <div class="return-btn">
            <a href="<c:url value="/home"/>" class="checking-order-detail">Quay về trang chủ</a>
        </div>
    </div>
</div>
<!-- End Renew Password -->

<jsp:include page="/common/client/footer.jsp"/>
<jsp:include page="/common/client/using-resource-footer.jsp"/>
<script src="<c:url value="/templates/DataTables/datatables.min.js"/>"></script>
<script src="<c:url value="/templates/logic-datatable/client/dt-order-history.js"/>"></script>
<script src="<c:url value="/templates/logic-datatable/service-logic.js"/>"></script>
</body>
</html>