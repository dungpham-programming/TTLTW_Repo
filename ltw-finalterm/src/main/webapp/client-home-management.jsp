<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DDD. Admin - Quản lý giao diện client</title>

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
<%-- Start top header --%>
<jsp:include page="/common/admin/top-header.jsp"/>
<%-- End top header --%>

<div id="layoutSidenav">
    <%-- Start left navigation --%>
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <%-- End left navigation --%>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý giao diện người dùng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <%
                    ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");
                    String success = request.getParameter("success");
                %>
                <% if (success != null) { %>
                <div class="alert alert-success">
                    Thêm sản phẩm thành công!
                </div>
                <% } %>
                <form id="client-home-management" action="<c:url value="/admin/product-management/adding"/>" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <p>Hiển thị riêng trên trang chủ</p>
                        <hr>
                        <div class="col-12">
                            <label for="welcomeTitle">Tiêu đề giới thiệu</label>
                            <input type="text" id="welcomeTitle" name="welcomeTitle" placeholder="Tiêu đề" required>
                            <% if (errors != null && errors.get(0) != null) { %>
                            <div class="error" id="error1">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="welcomeDes">Mô tả giới thiệu</label>
                            <textarea name="welcomeDes" id="welcomeDes" placeholder="Mô tả" required></textarea>
                            <% if (errors != null && errors.get(1) != null) { %>
                            <div class="error" id="error2">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="productTitle">Tiêu đề khu vực sản phẩm</label>
                            <input type="text" id="productTitle" placeholder="Tiêu đề" name="categoryTypeId"
                                   required>
                            <% if (errors != null && errors.get(2) != null) { %>
                            <div class="error" id="error3">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="productDes">Mô tả khu vực sản phẩm</label>
                            <textarea name="productDes" id="productDes" placeholder="Mô tả" required></textarea>
                            <% if (errors != null && errors.get(3) != null) { %>
                            <div class="error" id="error4">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="prTitle1">Tiêu đề giới thiệu 1</label>
                            <input type="text" id="prTitle1" placeholder="Tiêu đề"
                                   name="prTitle1" required>
                            <% if (errors != null && errors.get(4) != null) { %>
                            <div class="error" id="error5">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="prContent1">Nội dung (Mỗi một nội dung hiển thị cách nhau bởi dấu phẩy)</label>
                            <textarea name="prContent1" id="prContent1" placeholder="Nội dung" required></textarea>
                            <% if (errors != null && errors.get(5) != null) { %>
                            <div class="error" id="error7">Không được để trống!</div>
                            <% } %>
                            <div class="error" id="qError"></div>
                        </div>

                        <div class="col-6">
                            <label for="prDes1">Mô tả giới thiệu 1</label>
                            <textarea name="prDes1" id="prDes1" placeholder="Mô tả" required></textarea>
                            <% if (errors != null && errors.get(6) != null) { %>
                            <div class="error" id="error6">Không được để trống!</div>
                            <% } %>
                            <div class="error" id="dPeError"></div>
                        </div>

                        <div class="col-6">
                            <label for="prIcon1">Icon(Lấy icon ở <a class="link" href="https://fontawesome.com/search" target="_blank">đây</a>, xóa dấu xuống dòng)</label>
                            <textarea name="prIcon1" id="prIcon1" placeholder="Mỗi icon cách nhau bởi dấu phẩy, 1 icon/nội dung" required></textarea>
                            <% if (errors != null && errors.get(7) != null) { %>
                            <div class="error" id="error8">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-4">
                            <label for="prLink1">Thay đổi ảnh</label>
                            <input type="file" name="prLink1" id="prLink1">
                        </div>
                        
                        <div class="col-4">
                            <label for="updatingImg1">Ảnh bạn muốn đổi 1</label>
                            <img id="updatingImg1" src="" alt="">
                        </div>

                        <div class="col-4">
                            <label for="nowImg1">Ảnh hiện tại 1</label>
                            <img id="nowImg1" src="" alt="">
                        </div>

                        <div class="col-12">
                            <label for="prTitle2">Tiêu đề giới thiệu 2</label>
                            <input type="text" id="prTitle2" placeholder="Tiêu đề"
                                   name="prTitle2" required>
                            <% if (errors != null && errors.get(8) != null) { %>
                            <div class="error" id="error5">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="prContent2">Nội dung (Mỗi một nội dung hiển thị cách nhau bởi dấu phẩy)</label>
                            <textarea name="prContent2" id="prContent2" placeholder="Nội dung" required></textarea>
                            <% if (errors != null && errors.get(9) != null) { %>
                            <div class="error" id="error7">Không được để trống!</div>
                            <% } %>
                            <div class="error" id="qError"></div>
                        </div>

                        <div class="col-12">
                            <label for="prDes2">Mô tả giới thiệu 2</label>
                            <textarea name="prDes2" id="prDes2" placeholder="Mô tả" required></textarea>
                            <% if (errors != null && errors.get(10) != null) { %>
                            <div class="error" id="error6">Không được để trống!</div>
                            <% } %>
                            <div class="error" id="dPeError"></div>
                        </div>

                        <div class="col-4">
                            <label for="prLink2">Thay đổi ảnh 2</label>
                            <input type="file" name="prLink2" id="prLink2">
                        </div>

                        <div class="col-4">
                            <label for="updatingImg2">Ảnh bạn muốn đổi</label>
                            <img id="updatingImg2" src="" alt="">
                        </div>

                        <div class="col-4">
                            <label for="nowImg2">Ảnh hiện tại</label>
                            <img id="nowImg2" src="" alt="">
                        </div>

                        <p>Hiển thị chung cho các trang client</p>
                        <hr>

                        <div class="col-4">
                            <label for="background">Thay đổi background</label>
                            <input type="file" name="background" id="background">
                        </div>

                        <div class="col-4">
                            <label for="updatingBg">Ảnh bạn muốn đổi</label>
                            <img id="updatingBg" src="" alt="">
                        </div>

                        <div class="col-4">
                            <label for="nowBg">Ảnh hiện tại</label>
                            <img id="nowBg" src="" alt="">
                        </div>

                        <div class="col-12">
                            <label for="footerLeft">Miêu tả dưới logo footer</label>
                            <textarea name="footerLeft" id="footerLeft" placeholder="Miêu tả bên trái cuối trang (Dưới logo)" required></textarea>
                            <% if (errors != null && errors.get(11) != null) { %>
                            <div class="error" id="error8">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-12">
                            <label for="footerMiddle">Miêu tả giữa (Về chúng tôi)</label>
                            <textarea name="footerMiddle" id="footerMiddle" placeholder="Miêu tả giữa của cuối trang (Về chúng tôi)" required></textarea>
                            <% if (errors != null && errors.get(12) != null) { %>
                            <div class="error" id="error8">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-6">
                            <label for="facebookLink">Đường dẫn Facebook của trang</label>
                            <input type="text" id="facebookLink" name="facebookLink" placeholder="Đường dẫn Facebook" required>
                            <% if (errors != null && errors.get(13) != null) { %>
                            <div class="error" id="error1">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-6">
                            <label for="twitterLink">Đường dẫn Twitter của trang</label>
                            <input type="text" id="twitterLink" name="twitterLink" placeholder="Đường dẫn Twitter" required>
                            <% if (errors != null && errors.get(14) != null) { %>
                            <div class="error" id="error1">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-6">
                            <label for="instagramLink">Đường dẫn Instagram của trang</label>
                            <input type="text" id="instagramLink" name="instagramLink" placeholder="Đường dẫn Instagram" required>
                            <% if (errors != null && errors.get(15) != null) { %>
                            <div class="error" id="error1">Không được để trống!</div>
                            <% } %>
                        </div>

                        <div class="col-6">
                            <label for="linkedinLink">Đường dẫn Linkedin của trang</label>
                            <input type="text" id="linkedinLink" name="linkedinLink" placeholder="Đường dẫn Linkedin" required>
                            <% if (errors != null && errors.get(16) != null) { %>
                            <div class="error" id="error1">Không được để trống!</div>
                            <% } %>
                        </div>
                    </div>

                    <input type="submit" value="Cập nhật thay đổi" class="adding button">
                    <input type="reset" value="Đặt lại biểu mẫu" class="adding button">
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
