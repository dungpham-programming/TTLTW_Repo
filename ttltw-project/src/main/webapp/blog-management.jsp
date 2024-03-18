<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.BlogBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DDD. Admin - Management Blog</title>

    <jsp:include page="/common/admin/using-resource-header.jsp"/>
</head>
<body class="sb-nav-fixed">
<%-- Include navigation --%>
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý tin tức</h1>
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
                        Quản lý tin tức
                    </div>
                    <div class="list-button">
                        <a href="<c:url value="/admin/blog-management/adding"/>" data-bs-toggle="tooltip" title="Thêm bài viết" class="add"><i class="fa-solid fa-plus" style="color: #e3bd74;"></i>Thêm bài viết</a>
                    </div>
                    <div class="table-responsive">
                        <table id="manageAccountTable">
                            <thead>
                            <tr>
                                <th>ID Tin tức</th>
                                <th>Tiêu đề</th>
                                <th>Mô tả</th>
                                <th>Nội dung</th>
                                <th>Mã Loại</th>
                                <th>Tạo ngày</th>
                                <th>Tạo bởi</th>
                                <th>Sửa ngày</th>
                                <th>Sửa bởi</th>
                                <th>Chức năng</th>
                            </tr>
                            </thead>
                            <%
                                List<BlogBean> listBlog = (List<BlogBean>) request.getAttribute("listBlog");

                                for (BlogBean blog : listBlog) {
                                    String idStr = String.valueOf(blog.getId());
                            %>
                            <tbody>
                            <tr>
                                <td><%=blog.getId()%></td>
                                <td><%=blog.getTitle()%></td>
                                <td><%=blog.getDescription()%></td>
                                <td><%=blog.getContent()%></td>
                                <td><%=blog.getCategoryId()%></td>
                                <td><%=blog.getCreatedDate()%></td>
                                <td><%=blog.getCreatedBy()%></td>
                                <td><%=blog.getModifiedDate()%></td>
                                <td><%=blog.getModifiedBy()%></td>
                                <td>
                                    <a href="<c:url value="/admin/blog-management/editing"/>" data-bs-toggle="tooltip" title="Chỉnh sửa bài viết" class="edit"><i class="fa-regular fa-pen-to-square" style="color: #e3bd74;"></i></a>
                                    <a href="<c:url value="/admin/blog-management/delete"/>" data-bs-toggle="tooltip" title="Xóa bài viết" class="delete"><i class="fa-solid fa-trash" style="color: #e3bd74;"></i></a>
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