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

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
</body>
</html>


