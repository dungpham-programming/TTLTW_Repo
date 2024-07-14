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
<div class="renew-password position-relative-top-84px" style="background-color: #eeeeee; padding-top: 2rem">
    <div class="container">
        <div class="card">
            <div class="card-body">
                <div class="table table-striped">
                    <table id="orderDetailHistory" class="table table-striped" style="width: 100%;">
                        <thead>
                        <th>Mã sản phẩm</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá gốc</th>
                        <th>Giá giảm</th>
                        <th>Phần trăm giảm</th>
                        <th>Số lượng</th>
                        </thead>
                        <tbody>
                        </tbody>
                        <tfoot>
                        <th>Mã sản phẩm</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá gốc</th>
                        <th>Giá giảm</th>
                        <th>Phần trăm giảm</th>
                        <th>Số lượng</th>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
        <div class="return-btn">
            <a href="<c:url value="/order-history"/>" class="checking-order-detail">Quay về đơn hàng</a>
            <a href="<c:url value="/home"/>" class="checking-order-detail">Quay về trang chủ</a>
        </div>
    </div>
</div>
<!-- End Renew Password -->

<%
    int orderId = (int) request.getAttribute("orderId");
%>

<script>
    const orderId = <%=orderId%>;
</script>
<jsp:include page="/common/client/footer.jsp"/>

<jsp:include page="/common/client/using-resource-footer.jsp"/>
<script src="<c:url value="/templates/DataTables/datatables.min.js"/>"></script>
<script src="<c:url value="/templates/logic-datatable/client/dt-order-detail-history.js"/>"></script>
<script src="<c:url value="/templates/logic-datatable/service-logic.js"/>"></script>
</body>
</html>