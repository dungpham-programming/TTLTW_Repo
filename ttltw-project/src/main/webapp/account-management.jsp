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
                <div class="alert alert-success"><%=success%>
                </div>
                <% } %>
                <% if (error != null) { %>
                <div class="alert alert-error"><%=error%>
                </div>
                <% } %>
                <div class="card mb-4 mt-4">
                    <div class="card-header">
                        <i class="fas fa-table me-1"></i>
                        Quản lý tài khoản
                    </div>
                    <div class="list-button">
                        <a href="<c:url value="/admin/account-management/adding"/>" data-bs-toggle="tooltip"
                           title="Thêm tài khoản" class="add"><i
                                class="fa-solid fa-plus" style="color: #e3bd74;"></i>Thêm tài khoản</a>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <table id="userData" class="table table-striped" style="width:100%">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Email</th>
                                    <th>Họ</th>
                                    <th>Tên</th>
                                    <th>Phân quyền</th>
                                    <th>Trạng thái</th>
                                    <th>Địa chỉ đầy đủ</th>
                                    <th>Tạo ngày</th>
                                    <th>Chức năng</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th>#</th>
                                    <th>Email</th>
                                    <th>Họ</th>
                                    <th>Tên</th>
                                    <th>Phân quyền</th>
                                    <th>Trạng thái</th>
                                    <th>Địa chỉ đầy đủ</th>
                                    <th>Tạo ngày</th>
                                    <th>Chức năng</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
<script src="<c:url value="/templates/logic-datatable/admin/datatable-account.js"/>"></script>
<script src="<c:url value="/templates/logic-datatable/service-logic.js"/>"></script>
</body>
</html>