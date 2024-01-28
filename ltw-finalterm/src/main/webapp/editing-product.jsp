<%@ page import="com.ltw.bean.ProductBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DDD. Admin - Thêm tài khoản</title>

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
<%-- Include navigation --%>
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Chỉnh sửa sản phẩm</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <%
                    ProductBean productBean = (ProductBean) request.getAttribute("productBean");
                    ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");
                    String success = request.getParameter("success");
                    String oPrErr = request.getParameter("oPrErr");
                    String dPrErr = request.getParameter("dPrErr");
                    String dPeErr = request.getParameter("dPeErr");
                %>
                <% if (success != null) { %>
                <div class="alert alert-success">
                    Chỉnh sửa sản phẩm thành công!
                </div>
                <% } %>
                <form action="<c:url value="/admin/product-management/editing"/>" method="post">
                    <div class="row">
                        <div class="col-12">
                            <label for="name">Tên sản phẩm</label>
                            <input type="text" id="name" name="name" placeholder="Tên sản phẩm" value="<%=productBean.getName()%>" required>
                            <% if (errors != null && errors.get(0) != null) { %>
                            <div class="error" id="error1">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="description">Mô tả</label>
                            <textarea name="description" id="description" placeholder="Mô tả"><%=productBean.getDescription()%></textarea>
                            <% if (errors != null && errors.get(1) != null) { %>
                            <div class="error" id="error2">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="categoryTypeId">Mã phân loại sản phẩm</label>
                            <input type="text" id="categoryTypeId" name="categoryTypeId" placeholder="Mã phân loại" value="<%=productBean.getCategoryTypeId()%>" required>
                            <% if (errors != null && errors.get(2) != null) { %>
                            <div class="error" id="error3">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="originalPrice">Giá gốc</label>
                            <input type="text" id="originalPrice" name="originalPrice" placeholder="Chia phần nghìn (.) hoặc không" value="<fmt:formatNumber value="<%=productBean.getOriginalPrice()%>" pattern="#,##0.##"/>" required>
                            <% if (errors != null && errors.get(3) != null) { %>
                            <div class="error" id="error4">Không được để trống!</div>
                            <% } %>
                            <% if (oPrErr != null) { %>
                            <div class="error" id="oPrError">Phải là số và lớn hơn 0!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="discountPrice">Giá giảm</label>
                            <input type="text" id="discountPrice" name="discountPrice" placeholder="Chia phần nghìn (.) hoặc không" value="<fmt:formatNumber value="<%=productBean.getDiscountPrice()%>" pattern="#,##0.##"/>">
                            <% if (errors != null && errors.get(4) != null) { %>
                            <div class="error" id="error5">Không được để trống!</div>
                            <% } %>
                            <% if (dPrErr != null) { %>
                            <div class="error" id="dPrError">Phải là số và lớn hơn 0!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="discountPercent">Phần trăm giảm</label>
                            <input type="text" id="discountPercent" name="discountPercent" placeholder="Không có phần thập phân" value="<fmt:formatNumber value="<%=productBean.getDiscountPercent()%>" pattern="#,##0.##"/>" required>
                            <% if (errors != null && errors.get(5) != null) { %>
                            <div class="error" id="error6">Không được để trống!</div>
                            <% } %>
                            <div class="error" id="dPeError"></div>
                        </div>

                        <div class="col-3">
                            <label for="quantity">Số lượng còn</label>
                            <input type="text" id="quantity" name="quantity" placeholder="Chia phần nghìn (.) hoặc không" value="<%=productBean.getQuantity()%>">
                            <% if (errors != null && errors.get(6) != null) { %>
                            <div class="error" id="error7">Không được để trống!</div>
                            <% } %>
                            <div class="error" id="qError"></div>
                        </div>

                        <div class="col-3">
                            <label for="size">Size</label>
                            <input type="text" id="size" name="size" placeholder="Kích thước" value="<%=productBean.getSize()%>" required>
                            <% if (errors != null && errors.get(7) != null) { %>
                            <div class="error" id="error8">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="otherSpec">Thông số khác</label>
                            <input type="text" id="otherSpec" name="otherSpec" placeholder="Thông số khác" value="<%=productBean.getOtherSpec()%>">
                            <% if (errors != null && errors.get(8) != null) { %>
                            <div class="error" id="error9">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-3">
                            <label for="status">Trạng thái</label>
                            <select id="status" name="status">
                                <option value="1" <%= (productBean.getStatus() == 1) ? "selected" : "" %>>Còn hàng</option>
                                <option value="2" <%= (productBean.getStatus() == 2) ? "selected" : "" %>>Hết hàng</option>
                                <option value="3" <%= (productBean.getStatus() == 3) ? "selected" : "" %>>Vô hiệu hóa</option>
                            </select>
                            <% if (errors != null && errors.get(9) != null) { %>
                            <div class="error" id="error10">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="keyword">Từ khóa tìm kiếm</label>
                            <input type="text" id="keyword" name="keyword" value="<%=productBean.getKeyword()%>" placeholder="Phân cách từ khóa bằng dấu phẩy" required>
                            <% if (errors != null && errors.get(10) != null) { %>
                            <div class="error" id="error11">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="images">Các ảnh của sản phẩm</label>
                            <input type="file" name="images" id="images" multiple>
                            <div class="error" id="error12"></div>
                        </div>
                    </div>

                    <input type="hidden" name="id" value="<%=productBean.getId()%>">

                    <input type="submit" value="Chỉnh sửa sản phẩm" class="adding button">
                    <a href="<c:url value="/admin/product-management"/>">Quay về trang quản lý</a>
                    <a href="<c:url value="/admin/home"/>">Quay về trang chủ</a>
                </form>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="<c:url value="/templates/admin/js/scripts.js"/>"></script>
</body>
</html>