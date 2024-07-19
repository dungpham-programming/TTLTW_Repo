<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.WarehouseBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>DDD. Admin - Manage Warehouse</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý kho</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <div class="card mb-4 mt-4">
                    <div class="card-header">
                        <i class="fas fa-table me-1"></i>
                        Quản lý chi tiết kho
                    </div>
                    <div class="list-button">
                        <a href="<c:url value="/admin/warehouse-management/adding"/>" data-bs-toggle="tooltip"
                           title="Thêm kho" class="add"><i
                                class="fa-solid fa-plus" style="color: #e3bd74;"></i>Thêm kho</a>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <table id="warehouseDetailData" class="table table-striped" style="width:100%">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Id nhập kho</th>
                                    <th>Id sản phẩm</th>
                                    <th>Số lượng</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th>#</th>
                                    <th>Id nhập kho</th>
                                    <th>Id sản phẩm</th>
                                    <th>Số lượng</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="return-btn">
                <a href="<c:url value="/admin/warehouse-management"/>" class="checking-order-detail">Quay về đơn hàng</a>
                <a href="<c:url value="/admin/home"/>" class="checking-order-detail">Quay về trang chủ</a>
            </div>
        </main>
    </div>
</div>

<%
    int warehouseId = (int) request.getAttribute("warehouseId");
%>

<script>
    const warehouseId = <%=warehouseId%>;
</script>

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
<script src="<c:url value="/templates/DataTables/datatables.min.js"/>"></script>
<script src="<c:url value="/templates/logic-datatable/admin/datatable-warehouse-detail.js"/>"></script>
<script src="<c:url value="/templates/logic-datatable/service-logic.js"/>"></script>
</body>
</html>
