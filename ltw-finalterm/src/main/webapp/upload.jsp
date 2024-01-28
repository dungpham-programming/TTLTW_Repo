<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="<c:url value="/upload"/>" method="post" enctype="multipart/form-data">
    <input type="file" name="image">
    <button type="submit">Gửi</button>
</form>
</body>
</html>
