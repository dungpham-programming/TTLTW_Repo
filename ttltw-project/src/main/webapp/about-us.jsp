<%--
  Created by IntelliJ IDEA.
  User: Dũng Phạm
  Date: 22/05/2024
  Time: 11:34 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <jsp:include page="/common/client/using-resource-header.jsp"/>
    <title>DDD. - Bài viết</title>

<body>
<jsp:include page="/common/client/header.jsp"/>

<!-- Start Hero Section -->
<div class="hero aboutus position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-12">
                <div class="intro-excerpt">
                    <h1>Về chúng tôi</h1>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Hero Section -->


<!-- Start Team Section -->
<div class="untree_co-section">
    <div class="container">

        <div class="row mb-5">
            <div class="col-lg-5 mx-auto text-center">
                <h2 class="section-title">Về nhóm</h2>
            </div>
        </div>

        <div class="row">

            <!-- Start Column 1 -->
            <div class="col-12 col-md-4 col-lg-4 mb-5 mb-md-0">
                <img src="https://drive.google.com/uc?id=1zCc2jMFJBG-235L7ruVgM2R87Ya5yRKW" class="img-fluid mb-5" alt="Lawson Arnold">
                <h3 class><a href="#"><span class="">Phạm</span> Minh Dũng</a></h3>
                <span class="d-block position mb-4">Nhà sáng lập, thiết kế.</span>
                <p>Hiện là sinh viên năm 3 khoa CNTT trường Đại Học Nông Lâm Thành Phố Hồ Chí Minh. Tôi cung cấp những sản phẩm về gỗ với vẻ đẹp cổ kính, chúng hứa hẹn sẽ mang lại sự thích thú cho khách hàng. </p>
            </div>
            <!-- End Column 1 -->

            <!-- Start Column 2 -->
            <div class="col-12 col-md-4 col-lg-4 mb-5 mb-md-0">
                <img src="https://drive.google.com/uc?id=184Wz41-RJ0dF16ZFSP5htBrnbBJg6wpp" class="img-fluid mb-5" alt="Lawson Arnold">
                <h3 class><a href="#"><span class="">Lê</span> Ngọc Thanh Đào</a></h3>
                <span class="d-block position mb-4">Nhà sáng lập, thiết kế.</span>
                <p>Hiện là sinh viên năm 3 khoa CNTT trường Đại Học Nông Lâm Thành Phố Hồ Chí Minh. Là một người thích cái đẹp và sự chỉnh chu, tôi chung cấp những sản phẩm về gốm & sứ đã được chọn lọc kĩ càng</p>
            </div>
            <!-- End Column 2 -->

            <!-- Start Column 3 -->
            <div class="col-12 col-md-4 col-lg-4 mb-5 mb-md-0">
                <img src="https://drive.google.com/uc?id=1MFAGL_jxodfuKWBaS07PYZkuaamdRH7V" class="img-fluid mb-3" alt="Lawson Arnold" style="width: 300px; height: 400px;">
                <h3 class><a href="#"><span class="">Nguyễn</span> Thị Mỹ Duyên</a></h3>
                <span class="d-block position mb-4">Nhà sáng lập, thiết kế.</span>
                <p>Hiện là sinh viên năm 3 khoa CNTT trường Đại Học Nông Lâm Thành Phố Hồ Chí Minh. Là bên cung cấp sản phẩm về đan lát, gần gũi với môi trường và đem một phần nét nổi bậc của quê hương Đồng Tháp đến với mọi người.</p>
            </div>
            <!-- End Column 3 -->
        </div>
    </div>
</div>
<!-- End Team Section -->

<jsp:include page="/common/client/footer.jsp"/>

<jsp:include page="/common/client/using-resource-footer.jsp"/>
</body>

</html>

