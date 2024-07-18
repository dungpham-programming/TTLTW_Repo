<%@ page import="com.ltw.bean.OrderBean" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>DDD. Admin - Quản lý đơn hàng</title>
  <jsp:include page="/common/admin/using-resource-header.jsp"/>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
  <jsp:include page="/common/admin/left-navigation.jsp"/>
  <div id="layoutSidenav_content" class="gray-bg">
    <main>
      <div class="container-fluid px-4">
        <h1 class="mt-4">Quản lý đơn hàng</h1>
        <ol class="breadcrumb mb-4">
          <li class="breadcrumb-item active">DDD. Administrator</li>
        </ol>
        <div class="card mb-4 mt-4">
          <div class="card-header">
            <i class="fas fa-table me-1"></i>
            Quản lý đơn hàng
          </div>
          <div class="list-button">
            <a href="<c:url value="/admin/order-management/adding"/>" data-bs-toggle="tooltip"
               title="Thêm bài viết" class="add"><i class="fa-solid fa-plus" style="color: #e3bd74;"></i>Thêm
              đơn hàng</a>
          </div>
          <div class="table-responsive">
            <table id="orderData" class="table table-striped" style="width:100%">
              <thead>
              <tr>
                <th>#</th>
                <th>ID Khách hàng</th>
                <th>Tổng trị giá</th>
                <th>Phơng thức thanh toán</th>
                <th>Trạng thái</th>
                <th>Tạo ngày</th>
                <th>Ngày giao</th>
                <th>Tạo bởi</th>
                <th>Sửa ngày</th>
                <th>Sửa bởi</th>
                <th>Chức năng</th>
              </tr>
              </thead>
              <tfoot>
              <tr>
                <th>#</th>
                <th>ID Khách hàng</th>
                <th>Tổng trị giá</th>
                <th>Phơng thức thanh toán</th>
                <th>Trạng thái</th>
                <th>Tạo ngày</th>
                <th>Ngày giao</th>
                <th>Tạo bởi</th>
                <th>Sửa ngày</th>
                <th>Sửa bởi</th>
                <th>Chức năng</th>
              </tr>
              </tfoot>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>
<jsp:include page="/common/admin/using-resource-footer.jsp"/>
<script src="<c:url value="/templates/logic-datatable/admin/datatable-order.js"/>"></script>
<script src="<c:url value="/templates/logic-datatable/service-logic.js"/>"></script>
</body>
</html>


