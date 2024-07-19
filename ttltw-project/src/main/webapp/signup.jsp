<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Form Dang Ky Tai Khoan</title>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="<c:url value="/templates/login-signup-forget/signup/css/signup.css"/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
<div id="page">
    <div class="form-account">
        <div class="input-group">
            <div class="logo">
                <h1>DDD.</h1>
            </div>
            <div class="header">

                <p>ĐĂNG KÝ TÀI KHOẢN</p>
            </div>

            <form action="<c:url value="/register"/>" method="post" accept-charset="UTF-8">
                <%
                    String emailError = (String) request.getAttribute("emailError");
                    String passwordError = (String) request.getAttribute("passwordError");
                %>

                <div class="form-group">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="text" id="email" name="email" class="form-input" oninput="checking()"
                           placeholder="Địa chỉ email">
                </div>

                <div id="emailError" class="error-message">
                    <% if (emailError != null) { %>
                        <%= emailError %>
                    <% } %>
                </div>

                <div class="form-group">
                    <i class="fa-solid fa-key"></i>
                    <input type="password" id="password" name="password" class="form-input" oninput="checking()"
                           placeholder="Mật khẩu">
                    <i id="toggle_password" class="fa-light fa-eye eye" onclick="togglePassword('password')"></i>
                </div>

                <div id="passwordError" class="error-message">
                    <% if (passwordError != null) { %>
                    <%= passwordError %>
                    <% } %>
                </div>


                <div class="form-group">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" id="retypePassword" name="retypePassword" class="form-input"
                           placeholder="Nhập lại mật khẩu" oninput="checking()">
                    <i id="toggle_retypePassword" class="fa-light fa-eye eye"
                       onclick="togglePassword('retypePassword')"></i>
                </div>

                <div id="retypePasswordError" class="error-message">
                    <% if (passwordError != null) { %>
                    <%= passwordError %>
                    <% } %>
                </div>


                <input type="hidden" name="type" value="sendRegister">
                <div class="form-group">
                    <input style="background-color: #e8b949" type="submit"/>
                </div>

            </form>
            <div>
                <a href="<c:url value="signin.jsp"/>">Bạn có tài khoản? Đăng nhập </a>
            </div>
        </div>
        <div class="via-oauth mt-3">
            <div class="d-flex align-items-center justify-content-between">
                <hr class="flex-fill m-0">
                <span class="mx-3">Hoặc đăng nhập bằng</span>
                <hr class="flex-fill m-0">
            </div>
            <div class="list-unstyled d-flex align-items-center justify-content-around flex-wrap mt-2">
                <form action="<c:url value="/signin-via-google"/>" class="mt-0">
                    <button type="submit" class="oauth-btn">
                        <i class="fa-brands fa-google" style="color: #e11414;"></i>
                        <span>Google</span>
                    </button>
                </form>

                <form action="<c:url value="/signin-via-facebook"/>" class="mt-0">
                    <button type="submit" class="oauth-btn">
                        <i class="fa-brands fa-facebook-f" style="color: #045be7;"></i>
                        <span>Facebook</span>
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="<c:url value="/templates/login-signup-forget/signup/js/signup.js"/>"></script>
</body>
</html>