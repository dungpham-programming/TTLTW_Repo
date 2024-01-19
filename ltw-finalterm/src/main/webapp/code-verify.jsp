<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DDD. - Xác thực tài khoản</title>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

    <link rel="stylesheet" href="<c:url value="/templates/login-signup-forget/signup/css/signup.css"/>">
    <link rel="stylesheet" href="<c:url value="/templates/login-signup-forget/signin/css/login-custom.css"/>">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
<div id="page">
    <div class="form-account">
        <div class="input">
            <div class="logo">
                <h1>DDD.</h1>
            </div>
            <div class="header">

                <p>Xác thực tài khoản</p>
            </div>

            <%
                String codeError = (String) request.getAttribute("codeError");
                String email = request.getParameter("email");
                String confirm = request.getParameter("confirm");
            %>
            <% if (confirm != null) { %>
            <p class="alert alert-success">Mã xác thực mới đã gửi về email của bạn!</p>
            <% } %>

            <form action="<c:url value="/code-verification"/>" method="post" accept-charset="UTF-8">
                <div class="input-place d-flex flex-row align-items-center">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="text" name="verifyInput" class="form-input" placeholder="Mã xác minh">
                </div>
                <% if (codeError != null) { %>
                <div id="email_error" class="error error-message">
                    <%= codeError %>
                </div>
                <% } %>

                <input type="hidden" name="type" value="verified">
                <input type="hidden" name="email" value="<%= email %>">
                <input type="submit"/>

            </form>
            <div>
                <a href="<c:url value="/verification">
                            <c:param name="type" value="resendCode"/>
                            <c:param name="email" value="<%= email %>"/>
                         </c:url>">
                    Gửi lại mã
                </a>
            </div>
        </div>
    </div>
</div>
<script src="<c:url value="/templates/login-signup-forget/signin/js/script.js"/>"></script>
</body>
</html>
