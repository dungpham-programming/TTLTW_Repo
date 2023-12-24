<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Form Dang Ky Tai Khoan</title>
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
                String id = request.getParameter("id");
                String codeError = (String) request.getAttribute("codeError");
                String email = request.getParameter("email");
                String confirm = request.getParameter("confirm");
            %>
            <% if (confirm != null) { %>
            <p class="alert alert-success">Mã xác thực mới đã gửi về email của bạn!</p>
            <% } %>

            <form action="<c:url value="/verification"/>" method="post" accept-charset="UTF-8">
                <div class="form-group">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="text" name="verifyInput" class="form-input" placeholder="Mã xác minh">
                    <% if (codeError != null) { %>
                    <div id="email_error" class="error-message">
                        <%= codeError %>
                    </div>
                    <% } %>
                </div>

                <input type="hidden" name="type" value="verified">
                <input type="hidden" name="id" value="<%= id %>">
                <input type="hidden" name="email" value="<%= email %>">
                <div class="form-group">
                    <input type="submit"/>
                </div>

            </form>
            <div>
                <a href="<c:url value="/verification">
                            <c:param name="id" value="<%= id %>"/>
                            <c:param name="type" value="resendCode"/>
                            <c:param name="email" value="<%= email %>"/>
                         </c:url>">
                    Gửi lại mã
                </a>
            </div>
        </div>
    </div>
</div>
<script src="<c:url value="/templates/login-signup-forget/signin/js/signin.js"/>"></script>
</body>
</html>
