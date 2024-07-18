<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>DDD. Admin - Thêm sản phẩm</title>
    <jsp:include page="/common/admin/using-resource-header.jsp"/>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Thêm sản phẩm</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <%
                    ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");
                    String oPrErr = (String) request.getAttribute("oPrErr");
                    String dPrErr = (String) request.getAttribute("dPrErr");
                    String dPeErr = (String) request.getAttribute("dPeErr");
                    String qErr = (String) request.getAttribute("qErr");
                    String nameErr = (String) request.getAttribute("nameErr");
                %>
                <%
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                <%= (msg.equals("success") ? "<div class=\"alert alert-success\">Thêm thành công!</div>" : "<div class=\"alert alert-danger\">Thêm thất bại!</div>") %>
                <%}%>
                <form action="<c:url value="/admin/product-management/adding"/>" method="post">
                    <div class="row">
                        <div class="col-12">
                            <label for="name">Tên sản phẩm</label>
                            <input type="text" id="name" name="name" placeholder="Tên sản phẩm" required>
                            <% if (errors != null && errors.get(0) != null) { %>
                            <div class="error" id="error1">Không được để trống!</div>
                            <% } %>
                            <% if (nameErr != null) { %>
                            <div class="error" id="nameErr">Trùng tên sản phẩm!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="description">Mô tả</label>
                            <textarea name="description" id="description" placeholder="Mô tả"></textarea>
                            <% if (errors != null && errors.get(1) != null) { %>
                            <div class="error" id="error2">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="categoryTypeId">Mã phân loại sản phẩm</label>
                            <input type="text" id="categoryTypeId" placeholder="Mã phân loại" name="categoryTypeId" required>
                            <% if (errors != null && errors.get(2) != null) { %>
                            <div class="error" id="error3">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="originalPrice">Giá gốc</label>
                            <input type="text" id="originalPrice" placeholder="Chia phần nghìn (.) hoặc không" name="originalPrice" required>
                            <% if (errors != null && errors.get(3) != null) { %>
                            <div class="error" id="error4">Không được để trống!</div>
                            <% } %>
                            <% if (oPrErr != null) { %>
                            <div class="error" id="oPrError">Phải là số và lớn hơn 0!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="discountPrice">Giá giảm</label>
                            <input type="text" id="discountPrice" placeholder="Chia phần nghìn (.) hoặc không" name="discountPrice" required>
                            <% if (errors != null && errors.get(4) != null) { %>
                            <div class="error" id="error5">Không được để trống!</div>
                            <% } %>
                            <% if (dPrErr != null) { %>
                            <div class="error" id="dPrError">Phải là số và lớn hơn 0!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="discountPercent">Phần trăm giảm</label>
                            <input type="text" id="discountPercent" placeholder="Không chứa thập phân" name="discountPercent" required>
                            <% if (errors != null && errors.get(5) != null) { %>
                            <div class="error" id="error6">Không được để trống!</div>
                            <% } %>
                            <% if (dPeErr != null) { %>
                            <div class="error" id="dPeError">Phải là số lớn hơn 0 và nhỏ hơn 100!</div>
                            <%}%>
                        </div>

                        <div class="col-3">
                            <label for="quantity">Số lượng còn</label>
                            <input type="text" id="quantity" placeholder="Chia phần nghìn (.) hoặc không" name="quantity" required>
                            <% if (errors != null && errors.get(6) != null) { %>
                            <div class="error" id="error7">Không được để trống!</div>
                            <% } %>
                            <% if (qErr != null) { %>
                            <div class="error" id="qError">Phải là số nguyên lớn hơn 0!</div>
                            <%}%>
                        </div>

                        <div class="col-3">
                            <label for="size">Size</label>
                            <input type="text" id="size" placeholder="Kích thước" name="size" required>
                            <% if (errors != null && errors.get(7) != null) { %>
                            <div class="error" id="error8">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="otherSpec">Thông số khác</label>
                            <input type="text" id="otherSpec" name="otherSpec" placeholder="Thông số khác">
                        </div>

                        <div class="col-3">
                            <label for="status">Trạng thái</label>
                            <select id="status" name="status">
                                <option value="1">Còn hàng</option>
                                <option value="2">Hết hàng</option>
                                <option value="3">Vô hiệu hóa</option>
                            </select>
                            <% if (errors != null && errors.get(8) != null) { %>
                            <div class="error" id="error10">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="keyword">Từ khóa tìm kiếm</label>
                            <input type="text" id="keyword" name="keyword" placeholder="Phân cách từ khóa bằng dấu phẩy">
                        </div>

                        <div class="col-12">
                            <label for="imgUrls">Các ảnh của sản phẩm</label>
                            <input type="text" id="imgUrls" name="imgUrls" placeholder="Phân cách url bằng dấu phẩy" required>
                            <% if (errors != null && errors.get(9) != null) { %>
                            <div class="error" id="error12">Không được để trống!</div>
                            <% } %>
                        </div>
                    </div>

                    <input type="submit" value="Thêm sản phẩm" class="adding button">
                    <input type="reset" value="Đặt lại biểu mẫu" class="adding button">
                    <a href="<c:url value="/admin/product-management"/>">Quay về trang quản lý</a>
                    <a href="<c:url value="/admin/home"/>">Quay về trang chủ</a>
                </form>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/common/admin/using-resource-footer.jsp"/>
</body>
</html>
