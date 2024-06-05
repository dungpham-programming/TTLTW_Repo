<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    // Thêm contextPath để phù hợp
    const contextPath = "<%=request.getContextPath()%>";
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/numeral.js/2.0.6/numeral.min.js"></script>
<script>
    // Set lại cách định dạng dấu phân cách hàng nghìn và thập phân
    numeral.register('locale', 'custom', {
        delimiters: {
            thousands: '.',
            decimal: ','
        }
    });
    numeral.locale('custom');
</script>
<script src="<c:url value="/templates/client/js/ajax/suggest.js"/>"></script>
<script src="<c:url value="/templates/client/js/bootstrap.bundle.min.js"/>"></script>
<script src="<c:url value="/templates/client/js/custom.js"/>"></script>