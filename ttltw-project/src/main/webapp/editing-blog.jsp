<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 12/04/2024
  Time: 2:36 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.ltw.bean.BlogBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>DDD. Admin - Chỉnh sửa tài khoản</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <div id="layoutSidenav_nav">
        <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Chỉnh sửa bài viết</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <%
                    String success = request.getParameter("success");
                    if (success != null) {
                %>
                <div class="alert alert-success">Thay đổi thành công!</div>
                <%}%>
                <form action="<c:url value="/admin/blog-management/editing"/>" method="post">
                    <%
                        BlogBean blog = (BlogBean) request.getAttribute("blogBean");
                    %>
                    <div class="row">
                        <div class="col-12">
                            <label for="title">Tiêu đề bài viết</label>
                            <input type="text" id="title" name="title" value="4 kiểu túi xách cói đẹp dành cho những ngày hè rực rỡ" required>
                        </div>

                        <div class="col-12">
                            <label for="description">Mô tả ngắn</label>
                            <textarea type="text" id="description" name="description" required>
hè đã đến tới mông rồi, bạn đã chuẩn bị thời trang cho những ngày này chưa? Nếu bạn đã chuẩn bị sẵn sàng rồi thì còn túi xách như thế nào? Đã chọn được item nào ưng ý chưa? Nếu bạn còn đang băn khoăn thì các nàng phải tham khảo4 kiểu túi xách cói xinh xắn được gợi ý dưới đây nhé.
                            </textarea>
                        </div>

                        <div class="col-6">
                            <label for="categoryID">Mã loại sản phẩm</label>
                            <input type="text" id="categoryID" name="categoryID" value="10001" required>
                        </div>

                        <div class="col-6">
                            <label for="status">Trạng thái</label>
                            <select name="status" id="status">
                                <option value="1" <%= (blog.getStatus() == 1) ? "selected" : "" %>>Ẩn</option>
                                <option value="2" <%= (blog.getStatus() == 2) ? "selected" : "" %>>Hiện</option>
                            </select>
                        </div>

                        <div class="col-12">
                            <label for="content">Nội dung</label>
                            <textarea name="content" id="content" > <%=blog.getContent()%></textarea>
                        </div>
                    </div>

                    <input type="submit" value="Chỉnh sửa bài viết" class="adding button">
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