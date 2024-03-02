<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.BlogBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% BlogBean blogdetails = (BlogBean)
        request.getAttribute("blogDetail");
%>
<html lang="en">
<head>
    <jsp:include page="/common/client/using-resource-header.jsp"/>
    <title>DDD. - <%=blogdetails.getTitle()%></title>
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

<jsp:include page="/common/client/using-resource-footer.jsp"/>
</body>
</html>