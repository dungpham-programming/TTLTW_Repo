<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.ContactBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DDD. Admin - Management Order</title>

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
                <h1 class="mt-4">Quản lý liên hệ</h1>
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
                        Quản lý liên hệ
                    </div>
                    <div class="table-responsive">
                        <table id="manageAccountTable">
                            <thead>
                            <tr>
                                <th>ID Tài khoản</th>
                                <th>Email</th>
                                <th>Tiêu đề</th>
                                <th>Tin nhắn</th>
                                <th>Trạng thái</th>
                                <th>Tạo ngày</th>
                                <th>Tạo bởi</th>
                                <th>Sửa ngày</th>
                                <th>Sửa bởi</th>
                                <th>Chức năng</th>
                            </tr>
                            </thead>
                            <%
                                List<ContactBean> listContact = (List<ContactBean>) request.getAttribute("listContact");
                                if (listContact != null) {
                                    for (ContactBean contact : listContact) {
                                        String idStr = String.valueOf(contact.getId());
                            %>
                            <tbody>
                            <tr>
                                <td><%=contact.getId()%>
                                </td>

                                <td><%=contact.getEmail()%>
                                </td>
                                <td><%=contact.getTitle()%>
                                </td>
                                <td><%=contact.getMessage()%>
                                </td>
                                <% if (contact.getStatus() == 1) { %>
                                <td>Đã phản hồi</td>
                                <% } else if (contact.getStatus() == 2) { %>
                                <td>Cần xác thực</td>
                                <% } else if (contact.getStatus() == 0) { %>
                                <td>Vô hiệu hóa</td>
                                <% } %>

                                <td><%=contact.getCreatedDate()%>
                                </td>
                                <td><%=contact.getCreatedBy()%>
                                </td>
                                <td><%=contact.getModifiedDate()%>
                                </td>
                                <td><%=contact.getModifiedBy()%>
                                </td>
                                <td>
                                    <a href="<c:url value="/admin/contact-management/adding"/>" data-bs-toggle="tooltip"
                                       title="Thêm liên hệ" class="edit"><i
                                            class="fa-regular fa-pen-to-square" style="color: #e3bd74;"></i></a>
                                    <a href="<c:url value="/admin/contact-management/editing"/>"
                                       data-bs-toggle="tooltip" title="Chỉnh sửa liên hệ" class="edit"><i
                                            class="fa-regular fa-pen-to-square" style="color: #e3bd74;"></i></a>
                                    <a href="<c:url value="/admin/contact-management/delete"/>" data-bs-toggle="tooltip"
                                       title="Xóa liên hệ" class="add"><i
                                            class="fa-solid fa-trash" style="color: #e3bd74;"></i></a>
                                </td>
                            </tr>
                            </tbody>
                                <% } %>
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
