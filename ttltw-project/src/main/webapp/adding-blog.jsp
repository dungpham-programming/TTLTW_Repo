<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 11/04/2024
  Time: 12:58 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DDD. Admin - Thêm bài viết</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
        <jsp:include page="/common/admin/left-navigation.jsp"/>
        <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Thêm bài viết</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <%
                    ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");
                    String success = request.getParameter("success");
                %>
                <form action="<c:url value="/admin/blog-management/adding"/>" method="post">
                    <div class="row">
                        <div class="col-12">
                            <label for="title">Tiêu đề bài viết</label>
                            <input type="text" id="title" name="title" required>
                            <% if (errors != null && errors.get(0) != null) { %>
                            <div class="error" id="error5">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="description">Mô tả ngắn</label>
                            <input type="text" id="description" name=description" required>
                            <% if (errors != null && errors.get(0) != null) { %>
                            <div class="error" id="error5">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-6">
                            <label for="categoryID">Mã loại sản phẩm</label>
                            <input type="text" id="categoryID" name="categoryID" required>
                            <% if (errors != null && errors.get(0) != null) { %>
                            <div class="error" id="error5">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-6">
                            <label for="status">Trạng thái</label>
                            <input type="text" id="status" name="status" required>
                            <% if (errors != null && errors.get(0) != null) { %>
                            <div class="error" id="error5">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="content">Nội dung</label>
                            <textarea name="content" id="content"></textarea>
                            <% if (errors != null && errors.get(0) != null) { %>
                            <div class="error" id="error5">Không được để trống!</div>
                            <% } %>
                        </div>
                    </div>

                    <input type="submit" value="Thêm bài viết" class="adding button">
                    <input type="reset" value="Đặt lại biểu mẫu" class="adding button">
                    <a href="<c:url value="/admin/blog-management"/>">Quay về trang quản lý</a>
                    <a href="<c:url value="/admin/home"/>">Quay về trang chủ</a>
                </form>
            </div>
        </main>
    </div>
</div>
    <jsp:include page="/common/admin/using-resource-footer.jsp"/>

</body>
</html>