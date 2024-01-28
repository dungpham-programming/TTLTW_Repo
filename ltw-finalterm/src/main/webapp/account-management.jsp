<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.UserBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DDD. Admin - Manage Account</title>

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
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý tài khoản</h1>
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
                        Quản lý tài khoản
                    </div>
                    <div class="list-button">
                        <a href="<c:url value="/admin/account-management/adding"/>" data-bs-toggle="tooltip" title="Thêm tài khoản" class="add"><i
                                class="fa-solid fa-plus" style="color: #e3bd74;"></i>Thêm tài khoản</a>
                    </div>
                    <div class="table-responsive">
                        <table id="manageAccountTable">
                            <thead>

                            <tr>
                                <th>ID Tài khoản</th>
                                <th>Email</th>
                                <th>Họ</th>
                                <th>Tên</th>
                                <th>Phân quyền</th>
                                <th>Địa chỉ đầy đủ</th>
                                <th>Trạng thái</th>
                                <th>Tạo ngày</th>
                                <th>Sửa ngày</th>
                                <th>Chức năng</th>
                            </tr>
                            </thead>
                            <%
                                List<UserBean> listAccount = (List<UserBean>) request.getAttribute("accounts");

                                for (UserBean account : listAccount) {
                                    String idStr = String.valueOf(account.getId());
                            %>
                            <tbody>
                            <tr>
                                <td><%=account.getId()%></td>

                                <td><%=account.getEmail()%></td>

                                <% if (account.getFirstName() != null) { %>
                                <td><%=account.getFirstName()%></td>
                                <% } %>

                                <% if (account.getLastName() != null) { %>
                                <td><%=account.getLastName()%></td>
                                <% } %>

                                <td>
                                    <%if (account.getRoleId() == 1) {%>Người dùng<%} else if (account.getRoleId() == 2) { %>Quản trị viên<%}%>
                                </td>
                                <td><%=account.getAddressLine() + ", " + account.getAddressWard() + ", " + account.getAddressDistrict() + ", " + account.getAddressProvince()%></td>
                                <% if (account.getStatus() == 1) { %>
                                <td>Đã active</td>
                                <% } else if (account.getStatus() == 2) { %>
                                <td>Cần xác thực</td>
                                <% } else if (account.getStatus() == 0) { %>
                                <td>Vô hiệu hóa</td>
                                <% } %>
                                <td><%=account.getCreatedDate()%></td>
                                <td><%=account.getModifiedDate()%></td>
                                <td>
                                    <a href="<c:url value="/admin/account-management/editing">
                                                <c:param name="id" value="<%=idStr%>"/>
                                             </c:url>"
                                       data-bs-toggle="tooltip" title="Chỉnh sửa tài khoản" class="edit"><i
                                            class="fa-regular fa-pen-to-square" style="color: #e3bd74;"></i></a>
                                    <a href="<c:url value="/admin/account-management/deleting">
                                                <c:param name="id" value="<%=idStr%>"/>
                                             </c:url>" data-bs-toggle="tooltip" title="Xóa tài khoản" class="delete"><i
                                            class="fa-solid fa-trash" style="color: #e3bd74;"></i></a>
                                </td>
                            </tr>
                            </tbody>
                            <% } %>
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
</body>
</html>