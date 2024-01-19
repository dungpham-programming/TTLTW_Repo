<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style data-styles="">ion-icon {
        visibility: hidden
    }

    .hydrated {
        visibility: inherit
    }</style>
    <title>Quên mật khẩu</title>
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule="" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link rel="stylesheet" href="<c:url value="/templates/login-signup-forget/forget/css/bootstrap.min.css"/>">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap">
    <link rel="stylesheet" href="<c:url value="/templates/login-signup-forget/forget/css/QuenMatKhau.css"/>">

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
        <h2>Quên mật khẩu</h2>
    </div>
    <%
        String emailError = (String) request.getAttribute("emailError");
    %>
    <form action="<c:url value="/forget"/> " method="post" accept-charset="UTF-8">
        <div class="email">
            <label for="emailInput">Địa chỉ Email</label>
            <div class="sec-2">
                <ion-icon name="mail-outline" role="img" class="md hydrated" aria-label="mail outline"></ion-icon>
                <input type="email" name="email" id="emailInput" placeholder="Nhập địa chỉ email"
                       oninput="checkEmail()">
                <% if (emailError != null) { %>
                <div id="emailError" class="error-message"><%=emailError%></div>
                <% } %>
            </div>
        </div>

        <button class="sending" type="submit">Gửi</button>
        <div class="back-to-login d-flex justify-content-center mt-3">
            <a href="<c:url value="signin.jsp"/>">Quay về trang đăng nhập</a>
        </div>
    </form>
</div>
<script src="<c:url value="/templates/login-signup-forget/forget/js/QuenMatKhau.js"/>"></script>
</body>
</html>