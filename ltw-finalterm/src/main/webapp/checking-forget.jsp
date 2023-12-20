<%@ page import="com.ltw.bean.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Quên mật khẩu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap">
    <link rel="stylesheet" href="<c:url value="/templates/login-signup-forget/forget/css/bootstrap.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/templates/login-signup-forget/forget/css/QuenMatKhau.css"/>">

    <style>
        .error-message {
            color: red;
            font-size: 80%;
        }
    </style>

</head>

<body>
<div class="screen-1">
    <div class="logo">
        <h1>DDD.</h1>
    </div>
    <div class="header">
        <h2>Quên mật khẩu</h2>
    </div>
    <%
        String email = request.getParameter("email");
        String confirm = request.getParameter("confirm");
    %>
    <form action="<c:url value="/forget-verify"/>" method="post">
        <% if (confirm != null) { %>
        <div class="resend"><p class="success">Mã xác thực mới đã được gửi về email của bạn</p></div>
        <% } %>
        <div class="email">
            <label for="codeInput">Mã xác thực</label>
            <div class="sec-2">
                <ion-icon name="lock-closed-outline" role="img" class="md hydrated"
                          aria-label="lock closed outline"></ion-icon>
                <input type="text" name="code" id="codeInput" placeholder="Nhập mã xác thực" oninput="checkEmail()">
                <div id="emailError" class="error-message"></div>
            </div>
        </div>

        <input type="hidden" name="email" value="<%=email%>">
        <button class="sending" type="submit">Gửi</button>
    </form>
    <div class="link">
        <a class="a-link" href="<c:url value="/forget-verify">
                <c:param name="email" value="<%= email %>"/>
                <c:param name="type" value="resendCode" />
            </c:url>">
            Gửi lại mã
        </a>

        <a class="a-link" href="#">
            Quay về đăng nhập
        </a>
    </div>
</div>

<script src="<c:url value="/templates/login-signup-forget/forget/js/QuenMatKhau.js"/>"></script>
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule="" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>
</html>