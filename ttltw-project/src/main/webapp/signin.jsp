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
    <title>DDD. - Login</title>
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule="" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

    <link rel="stylesheet" type="text/css" href="<c:url value="/templates/login-signup-forget/signin/css/Dangnhap.css"/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap">
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

    <%
        String notify = request.getParameter("notify");
        if (notify != null ) {
            if (notify.equals("registed-by-page")) {
    %>
    <div class="alert alert-danger">
        Email này đã được đăng ký thông qua page!
    </div>
        <%} else if (notify.equals("error-oauth")) {%>
        <div class="alert alert-danger">
            Lỗi OAuth 2.0!
        </div>
        <%} else if (notify.equals("access-denied")) {%>
        <div class="alert alert-danger">
            Từ chối bởi Google!
        </div>
        <%}%>
    <%}%>

    <%
        String emailError = (String) request.getAttribute("emailError");
        String message = (String) request.getAttribute("message");
        if (emailError != null) {
    %>
    <div id="staticError" class="error-message"><%= emailError %></div>
    <% } %>

    <% if (message != null) {%>
    <div id="staticError" class="error-message"><%= message %></div>
    <% } %>

    <form action="<c:url value="/signin"/> " method="post" accept-charset="UTF-8">
        <div class="email">
            <label for="email">Địa chỉ Email</label>
            <div class="sec-2">
                <ion-icon name="mail-outline" role="img" class="md hydrated" aria-label="mail outline"></ion-icon>
                <input type="email" name="email" id="email" placeholder="Nhập địa chỉ email" oninput="checking()">
            </div>
            <div id="emailError" class="error-message"></div>
        </div>

        <div class="password">
            <label for="password">Mật khẩu</label>
            <div class="sec-2">
                <ion-icon name="lock-closed-outline" role="img" class="md hydrated"
                          aria-label="lock closed outline"></ion-icon>
                <input class="pas" type="password" name="password" id="password" placeholder="············"
                       oninput="checking()">
                <i id="toggle_password" class="fa-light fa-eye eye" onclick="togglePassword('password')"></i>
            </div>
            <div id="passwordError" class="error-message"></div>
        </div>

        <div class="form-group">
            <input class="submit-button" type="submit" value="Đăng nhập"/>
        </div>
    </form>
    <div class="footer">
        <a href="<c:url value="/register"/>" class="link">Đăng ký</a>
        <a href="<c:url value="forget.jsp"/>" class="link">Quên mật khẩu</a>
    </div>
    <div class="via-oauth">
        <div class="d-flex align-items-center justify-content-between">
            <hr class="flex-fill m-0">
            <span class="mx-3">Hoặc đăng nhập bằng</span>
            <hr class="flex-fill m-0">
        </div>
        <div class="list-unstyled d-flex align-items-center justify-content-between flex-wrap mt-2">
            <form action="<c:url value="/signin-via-google"/>" class="mt-0">
                <button type="submit" class="oauth-btn">
                    <i class="fa-brands fa-google" style="color: #e11414;"></i>
                    <span>Google</span>
                </button>
            </form>

            <form action="<c:url value="/signin-via-facebook"/>" class="mt-0">
                <button type="button" class="oauth-btn">
                    <i class="fa-brands fa-facebook-f" style="color: #045be7;"></i>
                    <span>Facebook</span>
                </button>
            </form>
        </div>
    </div>
</div>

<script src="<c:url value="/templates/login-signup-forget/signin/js/script.js"/>"></script>
</body>
</html>
