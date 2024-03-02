<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.BlogBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
    <jsp:include page="/common/client/using-resource-header.jsp"/>
    <title>DDD. - Bài viết</title>
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


<!-- Start Blog Section -->
<div class="blog-section position-relative-top-84px">
    <div class="container">
        <div class="row">
            <%
                List<BlogBean> listBlogs = (List<BlogBean>) request.getAttribute("listBlogs");
                for (BlogBean blog : listBlogs) {
            %>
            <div class="col-12 col-sm-6 col-md-4 mb-5">
                <div class="post-entry">
                    <a href="<c:url value="/blog-detail"><c:param name="id" value="<%=String.valueOf(blog.getId())%>"/></c:url>" class="post-thumbnail"><img src="../images/blog/post-1.jpg" alt="Image" class="img-fluid"></a>
                    <div class="post-content-entry">
                        <h3><a href="<c:url value="/blog-detail"><c:param name="id" value="<%=String.valueOf(blog.getId())%>"/></c:url>"><%=blog.getTitle()%></a></h3>
                        <div class="meta">
                            <span>Tác giả: <a href="#"><%=blog.getAuthor()%></a></span><span> on <a href="#"><fmt:formatDate value="<%= blog.getCreatedDate() %>" pattern="dd/MM/yyyy" /></a></span>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>
<!-- End Blog Section -->

<jsp:include page="/common/client/footer.jsp"/>

<jsp:include page="/common/client/using-resource-footer.jsp"/><jsp:include page="/common/client/using-resource-footer.jsp"/>
</body>

</html>

