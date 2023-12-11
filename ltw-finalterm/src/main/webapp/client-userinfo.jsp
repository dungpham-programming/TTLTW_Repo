<%@ page import="com.ltw.bean.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="../favicon.png">

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

    <!-- Bootstrap CSS -->
    <link href="<c:url value="templates/client/css/bootstrap.min.css"/>" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="<c:url value="templates/client/css/tiny-slider.css"/>" rel="stylesheet">
    <link href="<c:url value="templates/client/css/style.css"/>" rel="stylesheet">

    <title>DDD. - Nghệ thuật mỹ nghệ</title>
</head>

<body>

<!-- Start Header/Navigation -->
<nav id="navigation" class="custom-navbar navbar navbar-fixed navbar-expand-md navbar-dark bg-dark"
     aria-label="DDD Navigation Bar">

    <div class="container" id="container-nav">
        <a class="navbar-brand" href="index.html">DDD<span>.</span></a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni"
                aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsFurni">
            <ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
                <li class="nav-item active">
                    <a class="nav-link" href="index.html">Trang chủ</a>
                </li>
                <li><a class="nav-link" href="shop.html">Sản phẩm</a></li>
                <li><a class="nav-link" href="blog.html">Tin tức</a></li>
                <li><a class="nav-link" href="contact.html">Liên hệ</a></li>
                <li><a class="nav-link" href="about.html">Về chúng tôi</a></li>
            </ul>

            <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
                <li class="hv-li"><a class="nav-link yellow" href="#"><i class="fa-regular fa-user"></i></a>
                    <ul class="ul-drop-menu">
                        <li class="drop-menu hello-user">Xin chào, User!</li>
                        <li class="drop-menu hv-gray"><a href="<c:url value="/userinfo?action=view"/>" class="">Thông
                            tin tài khoản</a></li>
                        <li class="drop-menu hv-gray"><a href="order-history.html" class="">Lịch sử đơn hàng</a></li>
                        <li class="drop-menu hv-gray"><a href="#">Đăng xuất</a></li>
                    </ul>
                </li>
                <li class="hv-li"><a class="nav-link yellow" href="cart.html"><i class="fa-light fa-cart-shopping"></i></a>
                </li>
            </ul>
        </div>
    </div>

</nav>
<!-- End Header/Navigation -->

<!-- Start Hero Section -->
<div class="hero home position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-12">
                <div class="intro-excerpt">
                    <h1>Thông tin người dùng</h1>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Hero Section -->

<!-- Start update username -->
<div class="update-info position-relative-top-84px">
    <div class="container">
        <div class="contain-form p-4">
            <div class="dp-flex flex-column justify-content-center">
                <div class="update-info-title">
                    <h3>Thông tin</h3>
                </div>
                <%
                    String firstNameErr = (String) request.getAttribute("fnErr");
                    String lastNameErr = (String) request.getAttribute("lnErr");
                    String emailErr = (String) request.getAttribute("emailErr");
                    String addressLineErr = (String) request.getAttribute("alErr");
                    String addressWardErr = (String) request.getAttribute("awErr");
                    String addressDistrictErr = (String) request.getAttribute("adErr");
                    String addressProvinceErr = (String) request.getAttribute("apErr");
                    String existEmail = (String) request.getAttribute("existEmail");

                    String notify = (String) request.getAttribute("notify");

                    UserBean userInfo = (UserBean) request.getAttribute("userInfo");

                    // Lấy ra email gốc khi cập nhật info vào blank
                    String originalEmail = userInfo.getEmail();
                %>
                <form action="<c:url value="/userinfo?action=update"/>" method="post" id="updateInfoForm" accept-charset="UTF-8">
                    <% if (notify != null && notify.equals("success")) { %>
                    <div><p class="success">Cập nhật tài khoản thành công!</p></div>
                    <% } %>

                    <!--                    Cập nhật firstname-->

                    <div class="firsttname">
                        <label for="newFirsttname">Họ </label>
                        <input type="text" name="firstName" id="newFirsttname" value="<%%><%=userInfo.getFirstName()%><%  %>">
                    </div>
                    <% if (firstNameErr != null && firstNameErr.equals("e")) { %>
                    <div><p class="error">Không được để trống!</p></div>
                    <% } %>

                    <!--                    cập nhật lastname-->
                    <div class="lastname">
                        <label for="newLastname">Tên </label>
                        <input type="text" name="lastName" id="newLastname" value="<%%><%=userInfo.getLastName()%><%  %>">
                    </div>
                    <% if (lastNameErr != null && lastNameErr.equals("e")) { %>
                    <div><p class="error">Không được để trống!</p></div>
                    <% } %>

                    <!--  cập nhật email-->
                    <div class="email">
                        <label for="newEmaill">Email </label>
                        <input type="email" name="email" id="newEmaill" value="<%%><%=userInfo.getEmail()%><%  %>">
                    </div>
                    <% if (emailErr != null && emailErr.equals("e")) { %>
                    <div><p class="error">Không được để trống!</p></div>
                    <% } %>
                    <% if (existEmail != null) { %>
                    <div><p class="error">Email bạn vừa nhập đã tồn tại! Email vừa nhập: <%=existEmail%></p></div>
                    <% } %>

                    <!--                    Cập nhật AddressLine-->
                    <div class="addressLine">
                        <label for="newAddressLine">Đường/Số nhà </label>
                        <input type="text" name="addressLine" id="newAddressLine" value="<%%><%=userInfo.getAddressLine()%><%  %>">
                    </div>
                    <% if (addressLineErr != null && addressLineErr.equals("e")) { %>
                    <div><p class="error">Không được để trống!</p></div>
                    <% } %>

                    <!--                    Cập nhật AddressWard-->
                    <div class="addressWard">
                        <label for="newAddressWard">Phường </label>
                        <input type="text" name="addressWard" id="newAddressWard" value="<%%><%=userInfo.getAddressWard()%><%  %>">
                    </div>
                    <% if (addressWardErr != null && addressWardErr.equals("e")) { %>
                    <div><p class="error">Không được để trống!</p></div>
                    <% } %>

                    <!--                    Cập nhật AddressDistrict-->
                    <div class="addressDistrict">
                        <label for="newAddressDistrict">Quận/huyện </label>
                        <input type="text" name="addressDistrict" id="newAddressDistrict" value="<%%><%=userInfo.getAddressDistrict()%><%  %>">
                    </div>
                    <% if (addressDistrictErr != null && addressDistrictErr.equals("e")) { %>
                    <div><p class="error">Không được để trống!</p></div>
                    <% } %>

                    <!--                    Cập nhật AddressProvince-->
                    <div class="addressProvince">
                        <label for="newAddressProvince">Tỉnh </label>
                        <input type="text" name="addressProvince" id="newAddressProvince" value="<%%><%=userInfo.getAddressProvince()%><%  %>">
                    </div>
                    <% if (addressProvinceErr != null && addressProvinceErr.equals("e")) { %>
                    <div><p class="error">Không được để trống!</p></div>
                    <% } %>

                    <input type="hidden" name="originalEmail" value="<%=originalEmail%>">

                    <div class="dp-flex justify-content-between renew-button-group">
                        <button type="submit" class="infom-button a-btn">Cập nhật tài khoản</button>
                        <a href="<c:url value="/home"/>" class="infom-button a-btn">Quay lại trang chủ</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- End Renew Password -->

<!-- Start Footer Section -->
<footer class="footer-section position-relative-top-84px">
    <div class="container relative">
        <div class="row g-5 mb-5">
            <div class="col-4">
                <div class="mb-4"><p href="#" class="footer-head">DDD<span>.</span></p></div>
                <p class="mb-4 light-text footer-content">Với chúng tôi, mỗi một sản phẩm mỹ nghệ đều là một kiệt tác,
                    là một tác phẩm nghệ thuật. Cảm ơn bạn đã ghé thăm DDD. - Nghệ thuật mỹ nghệ. Mua sắm với chúng tôi
                    trong mục sản phẩm, hoặc bấm vào nút Khám phá trên trang chủ.</p>
            </div>

            <div class="col-4 center-text">
                <div class="mb-4"><p id="mxh-changing" class="footer-head">Mạng xã hội</p></div>
                <p class="mb-4 light-text footer-content">Đừng quên theo dõi chúng tôi qua các kênh mạng xã hội sau để
                    không bỏ lỡ nhưng thông tin mới nhất của DDD. - Nghệ thuật mỹ nghệ</p>
                <ul class="list-unstyled custom-social">
                    <li><a href="#"><span class="fa fa-brands fa-facebook-f footer-content"></span></a></li>
                    <li><a href="#"><span class="fa fa-brands fa-twitter footer-content"></span></a></li>
                    <li><a href="#"><span class="fa fa-brands fa-instagram footer-content"></span></a></li>
                    <li><a href="#"><span class="fa fa-brands fa-linkedin footer-content"></span></a></li>
                </ul>
            </div>

            <div class="col-4">
                <div class="row links-wrap">
                    <div class="right-text">
                        <div class="mb-4"><p class="footer-head">Nội dung</p></div>
                        <ul class="list-unstyled ">
                            <li><a class="light-text footer-content" href="#">Sản phẩm</a></li>
                            <li><a class="light-text footer-content" href="#">Tin tức</a></li>
                            <li><a class="light-text footer-content" href="#">Liên hệ</a></li>
                            <li><a class="light-text footer-content" href="#">Về chúng tôi</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="border-top copyright">
            <div class="row pt-4">
                <div class="col-lg-6">
                    <p class="mb-2 text-center text-lg-start light-text footer-content">Copyright &copy;<script>document.write(new Date().getFullYear());</script>
                        . All Rights Reserved.
                    </p>
                    <!-- License information: https://untree.co/license/ -->
                </div>

                <div class="col-lg-6 text-center text-lg-end light-text">
                    <ul class="list-unstyled d-inline-flex ms-auto">
                        <li class="me-4 footer-content"><a href="#">Terms &amp; Conditions</a></li>
                        <li><a href="#" class="footer-content">Privacy Policy</a></li>
                    </ul>
                </div>
            </div>
        </div>

    </div>
</footer>
<!-- End Footer Section -->

<button id="scroll-to-top"><i class="fa-solid fa-chevron-up" style="color: #e3bd74;"></i></button>

<script src="<c:url value="/templates/client/js/bootstrap.bundle.min.js"/>"></script>
<script src="<c:url value="/templates/client/js/reset-password.js"/>"></script>
<script src="<c:url value="/templates/client/js/custom.js"/>"></script>
</body>

</html>