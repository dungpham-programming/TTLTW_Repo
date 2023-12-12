<%@ page import="com.ltw.bean.BlogBean" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blog</title>
</head>
<body>

<div>
    <h1>List of Blogs</h1>
    <% List<BlogBean> listBlogs = (List<BlogBean>) request.getAttribute("listBlogs");
        if (listBlogs != null && !listBlogs.isEmpty()) {
            for (BlogBean blog : listBlogs) { %>
    <div>
        <h2><a href="blog-content.html?id=<%= blog.getId() %>"><%= blog.getTitle() %></a></h2>
        <p>Category: <%= blog.getCategoryId() %></p>
        <p>Created Date: <%= blog.getCreatedDate() %></p>
    </div>
    <% }
    } else { %>
    <p>No blogs found!</p>
    <% } %>
</div>

</body>
</html>

