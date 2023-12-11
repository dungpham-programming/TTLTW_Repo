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

<%-- Loop through the list of blogs to display them --%>
<div>
    <h1>List of Blogs</h1>
    <% List<BlogBean> listBlogs = (List<BlogBean>) request.getAttribute("listBlogs");
        if (listBlogs != null) {
            for (BlogBean blog : listBlogs) { %>
    <div>
        <h2><a href="blog-content.html?id=<%=blog.setId(resultSet.getInt("id")); %>"><%=blog.setTitle(resultSet.getString("title"));%></a></h2>
        <%=blog.setCategoryId(resultSet.getInt("categoryId"))%>
        <%=blog.setCreatedDate(resultSet.getTimestamp("createdDate"));%>
    </div>
    <% }
    } else { %>
    <p>No blogs found!</p>
    <% } %>
</div>

</body>
</html>

