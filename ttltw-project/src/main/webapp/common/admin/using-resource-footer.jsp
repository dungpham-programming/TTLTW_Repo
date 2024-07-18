<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.1/js/bootstrap.min.js"></script>
<script src="<c:url value="/templates/admin/js/scripts.js"/>"></script>
