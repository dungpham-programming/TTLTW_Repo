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
                            <th>Phương thức thanh toán</th>
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
                            <th>Phương thức thanh toán</th>
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

<div class="modal fade" id="reviewProduct" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5">Review sản phẩm</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/client/footer.jsp"/>
<jsp:include page="/common/client/using-resource-footer.jsp"/>
<script src="<c:url value="/templates/DataTables/datatables.min.js"/>"></script>
<script src="<c:url value="/templates/logic-datatable/client/dt-order-history.js"/>"></script>
<script src="<c:url value="/templates/logic-datatable/service-logic.js"/>"></script>
<script src="<c:url value="/templates/modal/show-modal.js"/>"></script>
</body>
</html>