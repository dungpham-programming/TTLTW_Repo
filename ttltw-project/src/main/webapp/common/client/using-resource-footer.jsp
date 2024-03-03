<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
// Thêm contextPath để phù hợp
<script>
    const contextPath = "<%=request.getContextPath()%>";
</script>
<script src="<c:url value="/templates/client/js/ajax/suggest.js"/>"></script>
<script src="<c:url value="/templates/client/js/bootstrap.bundle.min.js"/>"></script>
<script src="<c:url value="/templates/client/js/custom.js"/>"></script>
