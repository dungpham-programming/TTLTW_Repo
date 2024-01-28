<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.BlogBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="../favicon.png">

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

    <!-- Bootstrap CSS -->
    <link href="<c:url value="/templates/client/css/bootstrap.min.css" /> "rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="<c:url value="/templates/client/css/tiny-slider.css" />"rel="stylesheet">
    <link href="<c:url value="/templates/client/css/style.css" />"rel="stylesheet">
    <title>DDD. - Nghệ thuật mỹ nghệ</title>
</head>

<body>

<jsp:include page="/common/client/header.jsp"/>

<!-- Start Hero Section -->
<div class="hero blog position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-12">
                <div class="intro-excerpt">
                    <h1>Tin tức</h1>
                </div>
            </div>

        </div>
    </div>
</div>
<!-- End Hero Section -->

<div class="blog-content position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-center">
            <% BlogBean blogdetails = (BlogBean)
                    request.getAttribute("blogDetail");
            %>
            <div class="col-8">
                <div class="author-n-date">
                    <h5> <%=blogdetails.getAuthor()%></h5>
                </div>

                <div class="title">
                    <h2><%=blogdetails.getTitle()%></h2>
                </div>


                <div class="blog-img">
                    <%=blogdetails.getProfilePic()%>
                </div>

                <div class="news-content">
                    <p><%=blogdetails.getContent()%></p>
                </div>

                <div class="row justify-content-center"><a href="<c:url value="/blog"/>"><h5 style="color: #e3bd74">Quay về trang blog</h5></a></div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/client/footer.jsp"/>

<script src="<c:url value="/templates/client/js/bootstrap.bundle.min.js"/>"></script>
<script src="<c:url value="/templates/client/js/tiny-slider.js"/>"> </script>
<script src="<c:url value="/templates/client/js/custom.js"/>"></script>

</body>
</html>