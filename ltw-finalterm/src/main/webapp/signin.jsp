<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><style data-styles="">ion-icon{visibility:hidden}.hydrated{visibility:inherit}</style>
    <title>login</title>
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule="" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap">
    <link rel="stylesheet" href="<c:url value="/templates/login-signup-forget/signin/css/Dangnhap.css"/>">
</head>
<style>
    .error-message {
        color: red;
        font-size: 80%;
    }
</style>
<body>
<div class="screen-1">
    <div class="logo">
        <h1>DDD.</h1>
    </div>
    <div class="header">
        <h2>Đăng nhập</h2>
    </div>
    <form action="<c:url value="/signin"/> " method="post" accept-charset="UTF-8">
    <div class="email">
        <label for="email">Địa chỉ Email</label>
        <div class="sec-2">
            <ion-icon name="mail-outline" role="img" class="md hydrated" aria-label="mail outline"></ion-icon>
            <input type="email" name="email" id="emailInput" placeholder="Nhập địa chỉ email" oninput="checking()">
            <div id="emailError" class="error-message"></div>
        </div>
    </div>

    <div class="password">
        <label for="password">Mật khẩu</label>
        <div class="sec-2">
            <ion-icon name="lock-closed-outline" role="img" class="md hydrated" aria-label="lock closed outline"></ion-icon>
            <input class="pas" type="password" name="password" id="passwordInput" placeholder="············" oninput="checking()">
            <!--            <ion-icon class="show-hide md hydrated" name="eye-outline" role="img" aria-label="eye outline"></ion-icon>-->
            <div id="passwordError" class="error-message"></div>
        </div>
    </div>
        <div class="form-group">
            <input type="submit"/>
        </div>
    </form>
    <div class="footer">
        <a href="../signup/DangKi.html" class="link">Đăng ký</a>
        <a href="../forget_password/QuenMatKhau.html" class="link">Quên mật khẩu</a>
    </div>
</div>

<script src="<c:url value="/templates/login-signup-forget/signin/js/script.js"/>"></script>
</body>
</html>
