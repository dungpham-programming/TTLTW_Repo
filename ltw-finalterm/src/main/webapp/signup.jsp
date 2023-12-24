<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Form Dang Ky Tai Khoan</title>
    <link rel="stylesheet" href="<c:url value="/templates/login-signup-forget/signup/css/DangKicss.css"/>">
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
                    <input type="text" name="email" class="form-input" placeholder="Địa chỉ email">
                    <% if (emailError != null) { %>
                    <div id="email_error" class="error-message">
                        <%= emailError %>
                    </div>
                    <% } %>


                </div>
                <div class="form-group">
                    <i class="fa-solid fa-key"></i>
                    <input type="password" name="password" class="form-input" placeholder="Mật khẩu" id="passwordInput">
                    <i id="togglePassword" onclick="togglePassword('passwordInput')"></i>
                    <% if (passwordError != null) { %>
                    <div id="password_error" class="error-message">
                        <%= passwordError %>
                    </div>
                    <% } %>
                </div>

                <div class="form-group">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" name="retypePassword" class="form-input" placeholder="Nhập lại mật khẩu" id="password2Input">
                    <i id="togglePassword2" onclick="togglePassword('password2Input')"></i>
                </div>

                <input type="hidden" name="type" value="sendRegister">
                <div class="form-group">
                    <input type="submit"/>
                </div>

            </form>
            <div>
                <a href="<c:url value="signin.jsp"/>">Bạn có tài khoản? Đăng nhập </a>
            </div>
        </div>
    </div>
</div>
<script src="<c:url value="/templates/login-signup-forget/signup/js/DangKiJS.js"/>"></script>
</body>
</html>