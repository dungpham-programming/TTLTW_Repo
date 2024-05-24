<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
    <jsp:include page="/common/client/using-resource-header.jsp"/>
    <title>DDD. - Nghệ thuật mỹ nghệ</title>
</head>

<body>

<jsp:include page="/common/client/header.jsp"/>

<!-- Start Hero Section -->
<div class="hero home position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-12">
                <div class="intro-excerpt">
                    <h1>Đặt mật khẩu mới</h1>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Hero Section -->

<!-- Start Renew Password -->
<div class="renew-password position-relative-top-84px">
    <div class="container">
        <div class="contain-form p-4">
            <div class="dp-flex flex-column justify-content-center">
                <div class="renew-password-title">
                    <h3>Đặt mật khẩu mới</h3>
                </div>
                <form action="#" method="post" id="renewPwForm">
                    <div class="password">
                        <label for="oldPassword">Mật khẩu cũ</label>
                        <input type="password" name="oldPassword" id="oldPassword" oninput="renewPassword()">
                    </div>
                    <div id="oldpw-error"></div>

                    <div class="password">
                        <label for="newPassword">Mật khẩu mới</label>
                        <input type="password" name="newPassword" id="newPassword" oninput="renewPassword()">
                    </div>
                    <div id="newpw-error"></div>

                    <div class="password">
                        <label for="retypePassword">Nhập lại mật khẩu</label>
                        <input type="password" name="retypePassword" id="retypePassword" oninput="renewPassword()">
                    </div>
                    <div id="retype-error"></div>
                </form>
                <div class="dp-flex justify-content-between renew-button-group">
                    <a href="success-renew.jsp" class="passwd-button a-btn">Thay đổi mật khẩu</a>
                    <a href="index.jsp" class="passwd-button a-btn">Quay lại trang chủ</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Renew Password -->

<jsp:include page="/common/client/footer.jsp"/>

<jsp:include page="/common/client/using-resource-footer.jsp"/>

</body>
</html>
