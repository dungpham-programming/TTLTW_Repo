<%@ page import="com.ltw.bean.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <jsp:include page="/common/client/using-resource-header.jsp"/>
    <title>DDD. - Thông tin tài khoản</title>
</head>

<body>

<!-- Start Header/Navigation -->
<jsp:include page="/common/client/header.jsp"/>
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
                    String addressLineErr = (String) request.getAttribute("alErr");
                    String addressWardErr = (String) request.getAttribute("awErr");
                    String addressDistrictErr = (String) request.getAttribute("adErr");
                    String addressProvinceErr = (String) request.getAttribute("apErr");

                    String notify = (String) request.getAttribute("notify");

                    UserBean userInfo = (UserBean) request.getAttribute("userInfo");

                    // Lấy ra email gốc khi cập nhật info vào blank
                    String originalEmail = userInfo.getEmail();
                %>
                <form action="<c:url value="/user-info?action=update"/>" method="post" id="updateInfoForm" accept-charset="UTF-8">
                    <% if (notify != null && notify.equals("success")) { %>
                    <div><p class="success">Cập nhật tài khoản thành công!</p></div>
                    <% } %>

                    <!--                    Cập nhật firstname-->

                    <div class="firsttname">
                        <label for="newFirsttname">Họ </label>
                        <input type="text" name="firstName" id="newFirsttname" value="<%=(userInfo.getFirstName() == null) ? "" : userInfo.getFirstName()%>">
                    </div>
                    <% if (firstNameErr != null && firstNameErr.equals("e")) { %>
                    <div><p class="error">Không được để trống!</p></div>
                    <% } %>

                    <!--                    cập nhật lastname-->
                    <div class="lastname">
                        <label for="newLastname">Tên </label>
                        <input type="text" name="lastName" id="newLastname" value="<%=(userInfo.getLastName() == null) ? "" : userInfo.getLastName()%>">
                    </div>
                    <% if (lastNameErr != null && lastNameErr.equals("e")) { %>
                    <div><p class="error">Không được để trống!</p></div>
                    <% } %>

                    <!--  cập nhật email-->
                    <div class="email">
                        <label for="newEmaill">Email </label>
                        <input type="email" name="email" id="newEmaill" value="<%=userInfo.getEmail()%>" readonly>
                    </div>

                    <!--                    Cập nhật AddressLine-->
                    <div class="addressLine">
                        <label for="newAddressLine">Đường/Số nhà </label>
                        <input type="text" name="addressLine" id="newAddressLine" value="<%=(userInfo.getAddressLine() == null) ? "" : userInfo.getAddressLine()%>">
                    </div>
                    <% if (addressLineErr != null && addressLineErr.equals("e")) { %>
                    <div><p class="error">Không được để trống!</p></div>
                    <% } %>

                    <!--                    Cập nhật AddressWard-->
                    <div class="addressWard">
                        <label for="newAddressWard">Phường </label>
                        <input type="text" name="addressWard" id="newAddressWard" value="<%=(userInfo.getAddressWard() == null) ? "" : userInfo.getAddressWard()%>">
                    </div>
                    <% if (addressWardErr != null && addressWardErr.equals("e")) { %>
                    <div><p class="error">Không được để trống!</p></div>
                    <% } %>

                    <!--                    Cập nhật AddressDistrict-->
                    <div class="addressDistrict">
                        <label for="newAddressDistrict">Quận/huyện </label>
                        <input type="text" name="addressDistrict" id="newAddressDistrict" value="<%=(userInfo.getAddressDistrict() == null) ? "" : userInfo.getAddressDistrict()%>">
                    </div>
                    <% if (addressDistrictErr != null && addressDistrictErr.equals("e")) { %>
                    <div><p class="error">Không được để trống!</p></div>
                    <% } %>

                    <!--                    Cập nhật AddressProvince-->
                    <div class="addressProvince">
                        <label for="newAddressProvince">Tỉnh </label>
                        <input type="text" name="addressProvince" id="newAddressProvince" value="<%=(userInfo.getAddressLine() == null) ? "" : userInfo.getAddressProvince()%>">
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

<jsp:include page="/common/client/footer.jsp"/>

<jsp:include page="/common/client/using-resource-footer.jsp"/>
</body>
</html>