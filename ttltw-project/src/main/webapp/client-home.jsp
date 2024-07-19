<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.CategoryBean" %>
<%@ page import="com.ltw.bean.BlogBean" %>
<%@ page import="com.ltw.bean.CustomizeBean" %>
<%@ page import="com.ltw.bean.Content1Bean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="en">
<head>
    <jsp:include page="/common/client/using-resource-header.jsp"/>
    <title>DDD. - Nghệ thuật mỹ nghệ</title>
</head>

<body>
<%-- Start Header Session --%>
<jsp:include page="/common/client/header.jsp"/>
<%-- End Header Session --%>

<%
    CustomizeBean customizeInfo = (CustomizeBean) request.getAttribute("customizeInfo");
%>
<!-- Start Hero Section -->
<div class="hero home position-relative-top-84px" >
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-12">
                <div class="intro-excerpt">
                    <h1><%=customizeInfo.getWelcomeTitle()%></h1>
                    <p class="mb-4 darkred_alpha"><%=customizeInfo.getWelcomeDes()%></p>
                    <p><a href="<c:url value="/shop"/>" class="btn-main btn-secondary me-2">Khám phá ngay</a>
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
                <h2 class="mb-4 section-title"><%=customizeInfo.getProductTitle()%></h2>
                <p class="mb-4 darkred_alpha"><%=customizeInfo.getProductDes()%></p>
                <p><a href="<c:url value="/shop"/>" class="btn-main">Khám phá ngay</a></p>
            </div>
            <!-- End Column 1 -->

            <!-- Start Column 2 -->
            <%
                List<CategoryBean> listCategories = (List<CategoryBean>) request.getAttribute("listCategories");
                for (CategoryBean category : listCategories) {
            %>
            <div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
                <a class="product-item center-text" href="<c:url value="/shop-detail-by-category">
                                                              <c:param name="categoryId" value="<%=String.valueOf(category.getId())%>"/>
                                                          </c:url>">
                    <img src="<%=category.getProfilePic()%>"
                         class="img-fluid product-thumbnail fix-size-thumbnail">
                    <h3 class="center-text cate-home">Các sản phẩm làm từ</h3>
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
                </div>
            </div>

            <div class="col-lg-5">
                <div class="img-wrap">
                    <img src="https://img.freepik.com/free-photo/man-working-cutting-mdf-board_23-2149384827.jpg?t=st=1721241941~exp=1721245541~hmac=b98c7d939be50f3d401d9e9fabe76c0ac5a89916fed054d8bf8722057ea0b7d1&w=360" alt="Image" class="img-fluid">
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
                <div><img class="img-wrap" src="https://img.freepik.com/free-photo/preparing-sake-japanese-beverage_23-2150158608.jpg?size=626&ext=jpg&ga=GA1.2.2092897014.1721241907&semt=ais_user" alt="DDD."></div>
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
                <a href="<c:url value="/blog"/>" class="more">Xem tất cả bài viết</a>
            </div>
        </div>

        <div class="row">
            <%
                List<BlogBean> listBlogs = (List<BlogBean>) request.getAttribute("listBlogs");
                for (BlogBean blog : listBlogs) {
            %>
            <div class="col-12 col-sm-6 col-md-4 mb-4 mb-md-0">
                <div class="post-entry">
                    <a href="<c:url value="/blog-detail">
                                <c:param name="id" value="<%=String.valueOf(blog.getId())%>"/>
                             </c:url>" class="post-thumbnail"><img src="#" alt="Image"
                                                                            class="img-fluid"></a>
                    <div class="post-content-entry">
                        <h3><a href="<c:url value="/blog-detail">
                                        <c:param name="id" value="<%=String.valueOf(blog.getId())%>"/>
                                     </c:url>"><%= blog.getTitle() %>
                        </a></h3>
                        <div class="meta">
                            <span>by <a href="#"><%=blog.getAuthor()%></a></span><span> on <a href="#"><fmt:formatDate value="<%= blog.getCreatedDate() %>" pattern="dd/MM/yyyy" /></a></span>
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

<jsp:include page="/common/client/using-resource-footer.jsp"/>v
</body>
</html>