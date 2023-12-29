<%@ page import="com.ltw.bean.ImageBean" %><%--
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
    ImageBean imageBean = (ImageBean) request.getAttribute("imageBean");

    if (imageBean != null) {
%>
<div class="image">
    <div class="name">
        <p><%=imageBean.getName()%></p>
    </div>

    <div class="present-image">
        <img src="<%=imageBean.getLink()%>" alt="">
    </div>
</div>
<% } %>
</body>
</html>
