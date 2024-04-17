<%@ page import="com.ltw.bean.ContactBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chỉnh sửa thông tin liên hệ</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Chỉnh sửa thông tin liên hệ</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">Admin</li>
                </ol>
                <form action="<c:url value="/admin/contact-management/editing"/>" method="post">
                    <%
                        ContactBean contact = (ContactBean) request.getAttribute("contactBean");
                    %>
                    <div class="row">
                        <div class="col-12">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" value="<%=contact.getEmail()%>" readonly>
                        </div>

                        <div class="col-12">
                            <label for="firstName">Họ</label>
                            <input type="text" id="firstName" name="firstName" value="<%=contact.getFirstName()%>" readonly>
                        </div>

                        <div class="col-12">
                            <label for="lastName">Tên</label>
                            <input type="text" id="lastName" name="lastName" value="<%=contact.getLastName()%>" readonly>
                        </div>

                        <div class="col-12">
                            <label for="message">Tin nhắn</label>
                            <textarea id="message" name="message" rows="4"><%=contact.getMessage()%></textarea>
                        </div>

                        <div class="col-12">
                            <label for="status">Trạng thái</label>
                            <select name="status" id="status">
                                <option value="1" <%= (contact.getStatus() == 1) ? "selected" : "" %>>Đã xử lý</option>
                                <option value="2" <%= (contact.getStatus() == 2) ? "selected" : "" %>>Chưa xử lý</option>
                            </select>
                        </div>
                    </div>
                    <input type="hidden" name="id" value="<%=contact.getId()%>">
                    <input type="submit" value="Cập nhật thông tin" class="button">
                    <a href="<c:url value="/admin/contact-management"/>">Quay về trang quản lý</a>
                    <a href="<c:url value="/admin/home"/>">Quay về trang chủ</a>
                </form>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
</body>
</html>

