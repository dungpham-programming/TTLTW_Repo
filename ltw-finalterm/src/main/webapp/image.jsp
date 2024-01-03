<%@ page import="com.ltw.bean.ProductImageBean" %>
<%@ page import="com.ltw.bean.ProductImageBean" %><%--
  Created by IntelliJ IDEA.
  User: Dũng Phạm
  Date: 29/12/2023
  Time: 3:02 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    ProductImageBean productImageBean = (ProductImageBean) request.getAttribute("productImageBean");

    if (productImageBean != null) {
%>
<div class="image">
    <div class="name">
        <p><%=productImageBean.getName()%></p>
    </div>

    <div class="present-image">
        <img src="<%=productImageBean.getLink()%>" alt="">
    </div>
</div>
<% } %>
</body>
</html>
