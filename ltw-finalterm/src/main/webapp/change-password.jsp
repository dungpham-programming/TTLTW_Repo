<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style data-styles="">ion-icon {
        visibility: hidden
    }

    .hydrated {
        visibility: inherit
    }</style>
    <title>Đặt lại mật khẩu</title>
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule="" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap">
    <link rel="stylesheet" href="<c:url value="/templates/login-signup-forget/forget/css/DatLaiMK.css"/>">
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
        <h2>Đặt lại mật khẩu</h2>
    </div>
    <%
        String email = request.getParameter("email");
        String key = request.getParameter("key");
    %>
    <form action="<c:url value="/change-password"/>" method="post">
        <div class="password2">
            <label for="newPassword">Mật khẩu mới</label>
            <div class="sec-2">
                <ion-icon name="lock-closed-outline" role="img" class="md hydrated"
                          aria-label="lock closed outline"></ion-icon>
                <input class="pas" type="password" name="newPassword" id="newPassword" placeholder="············"
                       oninput="inputingCheck()">
                <div id="newPasswordSpaceErr" class="error-message"></div>
                <div id="newPasswordInputErr" class="error-message"></div>
            </div>
        </div>
        <div class="password3">
            <label for="retypePassword">Nhập lại mật khẩu mới</label>
            <div class="sec-2">
                <ion-icon name="lock-closed-outline" role="img" class="md hydrated"
                          aria-label="lock closed outline"></ion-icon>
                <input class="pas" type="password" name="retypePassword" id="retypePassword" placeholder="············"
                       oninput="inputingCheck()">
                <div id="retypePasswordSpaceErr" class="error-message"></div>
                <div id="retypePasswordInputErr" class="error-message"></div>
            </div>
        </div>

        <input type="hidden" name="key" value="<%=key%>">
        <input type="hidden" name="email" value="<%=email%>">
        <button type="submit" class="sending">Cập nhật mật khẩu</button>
    </form>
    <!-- Thêm sau nút cập nhật mật khẩu -->
</div>
<script src="<c:url value="/templates/login-signup-forget/forget/js/DatLaiMK.js"/>"></script>
</body>
</html>