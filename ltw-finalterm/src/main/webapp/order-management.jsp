<%@ page import="com.ltw.bean.OrderBean" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>DDD. Admin - Management Order</title>

  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

  <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"/>
  <link rel="stylesheet" href="<c:url value="/templates/admin/css/styles.css"/>">
  <link rel="stylesheet" href="<c:url value="/templates/admin/css/admin-custom.css"/>">
  <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
<nav class="sb-topnav navbar navbar-expand navbar-darkred">
  <!-- Navbar Brand-->
  <a class="navbar-brand ps-3 logo fs-4" href=""<c:url value="/home"/>">DDD. Admin</a>
  <!-- Sidebar Toggle-->
    <button class="btn btn-lg yellow-hv gray order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i
          class="fas fa-bars"></i></button>
  <ul class="navbar-nav ms-auto me-3 me-lg-4">
    <li class="nav-item dropdown">
      <a class="nav-link dropdown yellow-hv" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown"
         aria-expanded="false"><i class="fa-thin fa-user fa-lg" style="color: #f0f0f0;"></i></a>
      <ul class="dropdown-menu dropdown-menu-end navbar-darkred" aria-labelledby="navbarDropdown">
        <li class="hi-admin light-text">Xin chào, <a class="highlight-admin" href="admin-info.html">quản trị viên!</a></li>
        <li><hr class="dropdown-divider" /></li>
        <li><a class="dropdown-item light-text" href="admin-info.html">Tài khoản hiện tại</a></li>
        <li><a class="dropdown-item light-text" href="#">Đăng xuất</a></li>
      </ul>
    </li>
  </ul>
</nav>
<div id="layoutSidenav">
  <div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark navbar-darkred mt-3" id="sidenavAccordion">
      <div class="sb-sidenav-menu">
        <div class="nav">
          <div class="sb-sidenav-menu-heading gray">Quản trị viên</div>
          <a class="nav-link pt-3 pb-3" href="index.html">
            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
            Trang chủ
          </a>
          <a class="nav-link light-text pt-3 pb-3 " href="manage-account.html">
            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
            Quản lý tài khoản
          </a>
          <a class="nav-link light-text pt-3 pb-3 " href="management-product.html">
            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
            Quản lý sản phẩm
          </a>
          <a class="nav-link light-text pt-3 pb-3 yellow-active" href="<c:url value="/admin/order-management"/>">
            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
            Quản lý đơn hàng
          </a>
          <a class="nav-link light-text pt-3 pb-3" href="management-blog.html">
            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
            Quản lý tin tức
          </a>
          <a class="nav-link light-text pt-3 pb-3" href="management-contact.html">
            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
            Quản lý liên hệ
          </a>
          <a class="nav-link light-text pt-3 pb-3" href="manage-image.html">
            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
            Quản lý ảnh sản phẩm
          </a>
          <a class="nav-link light-text pt-3 pb-3" href="order-detail.html">
            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
            Kiểm tra chi tiết đơn hàng
          </a>
        </div>
      </div>
      <div class="sb-sidenav-footer mb-3">
        <div class="small">Logged in as:</div>
        Admin3
      </div>
    </nav>
  </div>
  <div id="layoutSidenav_content" class="gray-bg">
    <main>
      <div class="container-fluid px-4">
        <h1 class="mt-4">Quản lý đơn hàng</h1>
        <ol class="breadcrumb mb-4">
          <li class="breadcrumb-item active">DDD. Administrator</li>
        </ol>
        <%
          String success = (String) request.getAttribute("success");
          String error = (String) request.getAttribute("error");
        %>
        <% if (success != null) { %>
        <div class="alert alert-success"><%=success%></div>
        <% } %>
        <% if (error != null) { %>
        <div class="alert alert-error"><%=error%></div>
        <% } %>
        <div class="card mb-4 mt-4">
          <div class="card-header">
            <i class="fas fa-table me-1"></i>
            Quản lý đơn hàng
          </div>
          <div class="table-responsive">
            <table id="manageAccountTable">
              <thead>
              <tr>
                <th>ID Đơn hàng</th>
                <th>ID Khách hàng</th>
                <th>Ngày đặt</th>
                <th>Ngày giao</th>
                <th>Tổng trị giá</th>
                <th>Trạng thái</th>
                <th>Tạo ngày</th>
                <th>Tạo bởi</th>
                <th>Sửa ngày</th>
                <th>Sửa bởi</th>
                <th>Chức năng</th>
              </tr>
              </thead>
              <%
                List<OrderBean> listOrders = (List<OrderBean>) request.getAttribute("listOrders");

                for (OrderBean order : listOrders) {
                  String idStr = String.valueOf(order.getId());
              %>
              <tbody>
              <tr>
                <td><%=order.getId()%></td>
                <td><%=order.getUserId()%></td>
                <td>13/11/2022</td>
                <td><%=order.getShipToDate()%></td>
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
                <td>Hủy bỏ</td>
                <% } %>
                <td><%=order.getCreatedDate()%></td>
                <td><%=order.getCreatedBy()%></td>
                <td><%=order.getModifiedDate()%></td>
                <td><%=order.getModifiedBy()%></td>
                <td>
                  <a href="<c:url value="/admin/order-management/editing">
                              <c:param name="id" value="<%=idStr%>"/>
                           </c:url>"
                     data-bs-toggle="tooltip" title="Chỉnh sửa đơn hàng" class="edit"><i
                          class="fa-regular fa-pen-to-square" style="color: #e3bd74;"></i></a>
                  <a href="<c:url value="/admin/order-management/delete">
                              <c:param name="id" value="<%=idStr%>"/>
                           </c:url>"
                     data-bs-toggle="tooltip" title="Xóa đơn hàng" class="add"><i
                          class="fa-solid fa-trash" style="color: #e3bd74;"></i></a>
                </td>
              </tr>
              </tbody>
<% }%>
            </table>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="<c:url value="/templates/admin/js/scripts.js"/>"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="../assets/demo/chart-area-demo.js"></script>
<script src="../assets/demo/chart-bar-demo.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
        crossorigin="anonymous"></script>
<script src="../js/datatables-simple-demo.js"></script>
</body>
</html>


