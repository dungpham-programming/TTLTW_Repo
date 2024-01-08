<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.CategoryBean" %>
<%@ page import="com.ltw.bean.BlogBean" %>
<%@ page import="com.ltw.bean.CustomizeBean" %>
<%@ page import="com.ltw.bean.Content1Bean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

    <!-- Bootstrap CSS -->
    <link href="<c:url value="/templates/client/css/bootstrap.min.css"/>" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="<c:url value="/templates/client/css/tiny-slider.css"/>" rel="stylesheet">
    <link href="<c:url value="/templates/client/css/style.css"/>" rel="stylesheet">

    <title>DDD. - Nghệ thuật mỹ nghệ</title>
</head>

<body>
<%-- Start Header Session --%>
<jsp:include page="/common/client/header.jsp"/>
<%-- End Header Session --%>

<!-- Start Hero Section -->
<div class="hero home position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-12">
                <div class="intro-excerpt">
                    <h1>Nghệ thuật từ mỹ nghệ</h1>
                    <p class="mb-4 darkred_alpha">Mỗi một sản phẩm mỹ nghệ là một kiệt tác. Thưởng thức tinh túy của
                        nghệ thuật thông qua các sản phẩm mỹ nghệ tuyệt vời của chúng tôi.</p>
                    <p><a href="shop.html" class="btn-main btn-secondary me-2">Khám phá ngay</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Hero Section -->

<!-- Start Product Section -->
<div class="product-section position-relative-top-84px">
    <div class="container">
        <div class="row">

            <!-- Start Column 1 -->
            <div class="col-md-12 col-lg-3 mb-5 mb-lg-0">
                <h2 class="mb-4 section-title">Sản phẩm mỹ nghệ với chất lượng tuyệt vời.</h2>
                <p class="mb-4 darkred_alpha">Khám phá, lựa chọn và trải nghiệm sản phẩm mỹ nghệ với chất lượng hàng
                    đầu. Thưởng thức theo cách của bạn</p>
                <p><a href="shop.html" class="btn-main">Khám phá ngay</a></p>
            </div>
            <!-- End Column 1 -->

            <!-- Start Column 2 -->
            <%
                List<CategoryBean> listCategories = (List<CategoryBean>) request.getAttribute("listCategories");
                for (CategoryBean category : listCategories) {
            %>
            <div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
                <a class="product-item center-text" href="wood.html">
                    <img src="../images/wooden/binh_go_cam_2_1.jpg"
                         class="img-fluid product-thumbnail fix-size-thumbnail">
                    <h3 class="center-text">Các sản phẩm làm từ</h3>
                    <strong class="center-text big-category"><%= category.getName() %>
                    </strong>

                    <span class="btn-pop">
                            <p class="content-btn-pop">Tìm hiểu ngay!</p>
                        </span>
                </a>
            </div>
            <% } %>
            <!-- End Column 2 -->
        </div>
    </div>
</div>
<!-- End Product Section -->

<%
    CustomizeBean customizeInfo = (CustomizeBean) request.getAttribute("customizeInfo");
    List<Content1Bean> listContent1 = (List<Content1Bean>) request.getAttribute("listContent1");
    String[] prContent2List = (String[]) request.getAttribute("prContent2List");

    if (customizeInfo != null) {
%>
<!-- Start Why Choose Us Section -->
<div class="why-choose-section position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-lg-6">
                <h2 class="section-title"><% if (customizeInfo.getPrTitle1() != null) {%><%=customizeInfo.getPrTitle1()%><% } %></h2>
                <p class="light-text"><% if (customizeInfo.getPrDes1() != null) {%><%=customizeInfo.getPrDes1()%><% } %></p>

                <div class="row my-5">
                    <%  if (listContent1 != null) {
                            for (Content1Bean content : listContent1) {
                    %>
                    <div class="col-6 col-md-6">
                        <div class="feature">
                            <div class="icon">
                                <%=content.getPrIcon1()%>
                            </div>
                            <h3 class="yellow-text"><%=content.getPrContentTitle1()%></h3>
                            <p class="light-text"><%=content.getPrContentDes1()%></p>
                        </div>
                    </div>
                        <% } %>
                    <% } %>

<%--                    <div class="col-6 col-md-6">
                        <div class="feature">
                            <div class="icon">
                                <i class="fa-thin fa-bag-shopping fa-2xl" style="color: #e3bd74;"></i>
                            </div>
                            <h3 class="yellow-text">Dễ dàng mua sắm</h3>
                            <p class="light-text">Dễ dàng chọn lựa thông qua trang web cũng như tại cửa hàng trực tiếp.
                                Sản phẩm được cập nhật thường xuyên.</p>
                        </div>
                    </div>

                    <div class="col-6 col-md-6">
                        <div class="feature">
                            <div class="icon">
                                <i class="fa-thin fa-question fa-2xl" style="color: #e3bd74;"></i>
                            </div>
                            <h3 class="yellow-text">Hỗ trợ 24/7</h3>
                            <p class="light-text">Chúng tôi luôn sẵn sàng tư vấn và giải đáp cho bạn về việc mua hàng
                                trực tuyến và các sản phẩm mỹ nghệ.</p>
                        </div>
                    </div>

                    <div class="col-6 col-md-6">
                        <div class="feature">
                            <div class="icon">
                                <i class="fa-thin fa-arrows-repeat fa-2xl" style="color: #e3bd74;"></i>
                            </div>
                            <h3 class="yellow-text">Đổi trả miễn phí</h3>
                            <p class="light-text">Đối với các đơn hàng bị lỗi do nhà sản xuất, chúng tôi sẵn sàng đổi
                                trả sản phẩm mới cho bạn.</p>
                        </div>
                    </div>--%>

                </div>
            </div>

            <div class="col-lg-5">
                <div class="img-wrap">
                    <img src="<% if (customizeInfo.getPrLink1() != null) {%><%=customizeInfo.getPrLink1()%><% } %>" alt="Image" class="img-fluid">
                </div>
            </div>

        </div>
    </div>
</div>
<!-- End Why Choose Us Section -->

<!-- Start We Help Section -->
<div class="we-help-section position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-lg-5 mb-5 mb-lg-0">
                <div><img class="img-wrap" src="<c:url value="/templates/client/images/client_home/checking_wooden.jpg"/>" alt="DDD."></div>
            </div>
            <div class="col-lg-7 ps-lg-5">
                <h2 class="section-title mb-4"><% if (customizeInfo.getPrTitle2() != null) {%><%=customizeInfo.getPrTitle2()%><% } %></h2>
                <p class="darkred-text"><% if (customizeInfo.getPrDes2() != null) {%><%=customizeInfo.getPrDes2()%><% } %></p>

                <ul class="list-unstyled custom-list my-4">
                    <%
                        if (prContent2List != null) {
                            for (String content : prContent2List) {
                    %>
                    <li class="darkred-text"><%=content%></li>
<%--                    <li class="darkred-text">Chọn loại hàng bạn quan tâm</li>
                    <li class="darkred-text">Thêm sản phẩm vào giỏ hàng</li>
                    <li class="darkred-text">Vào giỏ hàng và thanh toán</li>--%>
                        <% } %>
                    <% } %>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- End We Help Section -->

<!-- Start Blog Section -->
<div class="blog-section position-relative-top-84px">
    <div class="container">
        <div class="row mb-5">
            <div class="col-md-6">
                <h2 class="section-title">Tin tức</h2>
            </div>
            <div class="col-md-6 text-start text-md-end">
                <a href="blog.html" class="more">Xem tất cả bài viết</a>
            </div>
        </div>

        <div class="row">
            <%
                List<BlogBean> listBlogs = (List<BlogBean>) request.getAttribute("listBlogs");
                for (BlogBean blog : listBlogs) {
            %>
            <div class="col-12 col-sm-6 col-md-4 mb-4 mb-md-0">
                <div class="post-entry">
                    <a href="blog-content.html" class="post-thumbnail"><img src="../images/blog/post-1.jpg" alt="Image"
                                                                            class="img-fluid"></a>
                    <div class="post-content-entry">
                        <h3><a href="blog-content.html"><%= blog.getTitle() %>
                        </a></h3>
                        <div class="meta">
                            <span>by <a href="#">Kristin Watson</a></span> <span>on <a href="#">Dec 19, 2021</a></span>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>
<!-- End Blog Section -->
<% } %>

<%-- Start Footer Session --%>
<jsp:include page="/common/client/footer.jsp"/>
<%-- End Footer Session --%>

<script src="<c:url value="/templates/client/js/bootstrap.bundle.min.js"/>"></script>
<script src="<c:url value="/templates/client/js/tiny-slider.js"/>"></script>
<script src="<c:url value="/templates/client/js/custom.js"/>"></script>
</body>
</html>


