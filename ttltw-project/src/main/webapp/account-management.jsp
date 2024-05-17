<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.UserBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>DDD. Admin - Manage Account</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
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

                                <td><%= (account.getFirstName() != null) ? account.getFirstName() : "" %></td>

                                <td><%= (account.getLastName() != null) ? account.getLastName() : "" %></td>

                                <%
                                    String role;
                                    switch (account.getRoleId()) {
                                        case 1:
                                            role = "Người dùng";
                                            break;
                                        case 2:
                                            role = "Quản trị";
                                            break;
                                        case 3:
                                            role = "Người chỉnh sửa";
                                            break;
                                        default:
                                            role = "";
                                            break;
                                    };
                                %>
                                <td>
                                    <%=role%>
                                </td>
                                <td>
                                    <%=account.getAddressLine() + ", " + account.getAddressWard() + ", " + account.getAddressDistrict() + ", " + account.getAddressProvince()%>
                                </td>
                                <%
                                    String status;
                                    switch (account.getStatus()) {
                                        case 1:
                                            status = "Đã active";
                                            break;
                                        case 2:
                                            status = "Cần xác thực";
                                            break;
                                        case 3:
                                            status = "Vô hiệu hóa";
                                            break;
                                        default:
                                            status = "";
                                            break;
                                    };
                                %>
                                <td><%=status%></td>
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

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
</body>
</html>