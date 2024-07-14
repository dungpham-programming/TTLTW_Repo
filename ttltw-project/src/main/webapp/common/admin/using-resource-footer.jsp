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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="<c:url value="/templates/admin/js/scripts.js"/>"></script>
