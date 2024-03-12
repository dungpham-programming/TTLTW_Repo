<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.ProductBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>DDD. Admin - Quản lý sản phẩm</title>
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
                <h1 class="mt-4">Quản lý sản phẩm</h1>
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
                        Quản lý sản phẩm
                    </div>
                    <div class="list-button">
                        <a href="<c:url value="/admin/product-management/adding"/>" data-bs-toggle="tooltip" title="Thêm sản phẩm" class="add"><i
                                class="fa-solid fa-plus" style="color: #e3bd74;"></i>Thêm sản phẩm</a>
                    </div>
                    <div class="table-responsive">
                        <table id="manageAccountTable">
                            <thead>
                            <tr>
                                <th>ID Sản phẩm</th>
                                <th>Tên sản phẩm</th>
                                <th>Miêu tả</th>
                                <th>Mã danh mục</th>
                                <th>Giá gốc</th>
                                <th>Giá giảm</th>
                                <th>Phần trăm giảm</th>
                                <th>Số lượng còn</th>
                                <th>Kích thước</th>
                                <th>Thông tin khác</th>
                                <th>Từ khóa</th>
                                <th>Trạng thái</th>
                                <th>Ảnh</th>
                                <th>Tạo ngày</th>
                                <th>Tạo bởi</th>
                                <th>Sửa ngày</th>
                                <th>Sửa bởi</th>
                                <th>Chức năng</th>
                            </tr>
                            </thead>
                            <%
                                List<ProductBean> listProduct = (List<ProductBean>) request.getAttribute("listProduct");

                                for (ProductBean product : listProduct) {
                                    String idStr = String.valueOf(product.getId());
                            %>
                            <tbody>
                            <tr>
                                <td><%=product.getId()%></td>

                                <% if (product.getName() != null) { %>
                                <td><%=product.getName()%></td>
                                <% } %>

                                <% if (product.getDescription() != null) { %>
                                <td><%=product.getDescription()%></td>
                                <% } %>

                                <td><%=product.getCategoryTypeId()%></td>
                                <td><fmt:formatNumber value="<%=product.getOriginalPrice()%>" pattern="#,##0.##"/>đ</td>
                                <td><fmt:formatNumber value="<%=product.getDiscountPrice()%>" pattern="#,##0.##"/>đ</td>
                                <td><fmt:formatNumber value="<%=product.getDiscountPercent()%>" pattern="#.##"/>%</td>
                                <td><%=product.getQuantity()%></td>
                                <td><%=product.getSize()%></td>
                                <td><%=product.getOtherSpec()%></td>
                                <td><%=product.getKeyword()%></td>
                                <% if (product.getStatus() == 1) { %>
                                <td>Còn hàng</td>
                                <% } else if (product.getStatus() == 2) { %>
                                <td>Vô hiệu hóa</td>
                                <% } else if (product.getStatus() == 0) { %>
                                <td>Hết hàng</td>
                                <% } %>
                                <%-- TODO: Ảnh chỉ là để link tạm thời --%>
                                <td>
                                </td>
                                <td><%=product.getCreatedDate()%></td>
                                <td><%=product.getCreatedBy()%></td>
                                <td><%=product.getModifiedDate()%></td>
                                <td><%=product.getModifiedBy()%></td>
                                <td>
                                    <a href="<c:url value="/admin/product-management/editing">
                                                <c:param name="id" value="<%=idStr%>"/>
                                             </c:url>"
                                       data-bs-toggle="tooltip" title="Chỉnh sửa sản phẩm" class="edit"><i
                                            class="fa-regular fa-pen-to-square" style="color: #e3bd74;"></i></a>
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