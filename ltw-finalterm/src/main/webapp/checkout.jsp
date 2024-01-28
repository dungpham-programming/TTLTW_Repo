<%@ page import="com.ltw.bean.CustomizeBean" %>
<%@ page import="com.ltw.bean.UserBean" %>
<%@ page import="com.ltw.bean.Cart" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.Item" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="../favicon.png">

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

    <!-- Bootstrap CSS -->
    <link href="<c:url value="/templates/client/css/bootstrap.min.css"/>" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="<c:url value="/templates/client/css/tiny-slider.css"/>" rel="stylesheet">
    <link href="<c:url value="/templates/client/css/style.css"/>" rel="stylesheet">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <title>DDD. - Nghệ thuật mỹ nghệ</title>

    <% CustomizeBean customizeInfo = (CustomizeBean) request.getAttribute("customizeInfo"); %>
    <style>
        .hero.checkout {
            background-image: url("<%=customizeInfo.getBackground()%>");
            /* Các quy tắc CSS khác cho .hero.home nếu cần */
        }
    </style>
</head>

<body>
<jsp:include page="/common/client/header.jsp"/>

<!-- Start Hero Section -->
<div class="hero checkout position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-lg-5">
                <div class="intro-excerpt">
                    <h1>Kiểm tra mua hàng</h1>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Hero Section -->

<div class="untree_co-section position-relative-top-84px">
    <div class="container">
        <%
            String insertError = (String) request.getAttribute("insertError");
            if (insertError != null) {
        %>
        <div class="alert alert-danger">Lỗi hệ thống, không thể thêm Order!</div>
        <%}%>
        <%
            UserBean user = (UserBean) request.getSession().getAttribute("user");
            Cart cart = (Cart) request.getSession().getAttribute("cart");
            List<String> errors = (List<String>) request.getAttribute("errors");
        %>
        <form action="<c:url value="/checkout"/>" method="post">
            <div class="row">
                <div class="col-md-6 mb-5 mb-md-0">
                    <h2 class="h3 mb-3 text-black">Thông tin hóa đơn</h2>
                    <div class="border bg-white p-3 p-lg-5">
                        <div class="form-group row">
                            <div class="col-md-6">
                                <label for="c_fname" class="text-black">Họ <span
                                        class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="c_fname" name="firstName" value="<%=(user.getFirstName() == null) ? "" : user.getFirstName()%>" required>
                                <% if (errors != null && errors.get(0) != null) {%>
                                <div class="error-message">Không được để trống!</div>
                                <%}%>
                            </div>

                            <div class="col-md-6">
                                <label for="c_lname" class="text-black">Tên <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="c_lname" name="lastName" value="<%=(user.getLastName() == null) ? "" : user.getLastName()%>" required>
                                <% if (errors != null && errors.get(1) != null) {%>
                                <div class="error-message">Không được để trống!</div>
                                <%}%>
                            </div>

                            <div class="col-md-12">
                                <label for="c_email_address" class="text-black">Email <span
                                        class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="c_email_address" name="email" value="<%=(user.getEmail() == null) ? "" : user.getEmail()%>" readonly>
                            </div>
                        </div>


                        <div class="form-group row">
                            <div class="col-md-12">
                                <label for="c_address" class="text-black">Số nhà/Tên đường <span
                                        class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="c_address" name="addressLine" value="<%=(user.getAddressLine() == null) ? "" : user.getAddressLine()%>" required>
                                <% if (errors != null && errors.get(2) != null) {%>
                                <div class="error-message">Không được để trống!</div>
                                <%}%>
                            </div>


                            <div class="col-md-12">
                                <label for="c_state_country" class="text-black">Phường/Xã <span
                                        class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="c_state_country" name="addressWard" value="<%=(user.getAddressWard() == null) ? "" : user.getAddressWard()%>" required>
                            </div>
                            <% if (errors != null && errors.get(3) != null) {%>
                            <div class="error-message">Không được để trống!</div>
                            <%}%>

                            <div class="col-md-12">
                                <label for="c_postal_zip" class="text-black">Quận/Huyện <span
                                        class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="c_postal_zip" name="addressDistrict" value="<%=(user.getAddressDistrict() == null) ? "" : user.getAddressDistrict()%>" required>
                                <% if (errors != null && errors.get(4) != null) {%>
                                <div class="error-message">Không được để trống!</div>
                                <%}%>
                            </div>

                            <div class="col-md-12">
                                <label for="province" class="text-black">Tỉnh/Thành phố <span
                                        class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="province" name="addressProvince" value="<%=(user.getAddressProvince() == null) ? "" : user.getAddressProvince()%>">
                                <% if (errors != null && errors.get(5) != null) {%>
                                <div class="error-message">Không được để trống!</div>
                                <%}%>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row mb-5">
                        <div class="col-md-12">
                            <h2 class="h3 mb-3 text-black">Đơn hàng của bạn</h2>
                            <div class="p-3 p-lg-5 border bg-white">
                                <table class="table site-block-order-table mb-5">
                                    <thead>
                                    <th>Sản phẩm</th>
                                    <th>Tổng tiền</th>
                                    </thead>
                                    <tbody>
                                    <%
                                        List<Item> items = cart.getItems();
                                        for (Item item : items) {
                                    %>
                                    <tr>
                                        <td><%=item.getProduct().getName()%> <strong class="mx-2">x</strong> <%=item.getQuantity()%></td>
                                        <td><fmt:formatNumber value="<%=item.getTotalWithDiscount()%>" pattern="#,##0.##"/>đ</td>
                                    </tr>
                                    <%}%>
                                    <tr>
                                        <td class="text-black font-weight-bold"><strong>Tổng cộng</strong></td>
                                        <td class="text-black font-weight-bold"><strong><fmt:formatNumber value="<%=cart.getDiscountPriceTotal()%>" pattern="#,##0.##"/>đ</strong></td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div><h5>Phương thức thanh toán</h5></div>

                                <!-- Thay đổi action và method tùy thuộc vào cách bạn xử lý biểu mẫu -->
                                <div class="border p-3 mb-3">
                                    <h3 class="h6 mb-0">
                                        <label class="d-block">
                                            <input type="radio" name="paymentMethod" value="paymentOnDelivery"
                                                   data-bs-toggle="collapse"
                                                   href="#paymentOnDelivery" role="button" aria-expanded="false"
                                                   aria-controls="paymentOnDelivery" checked>
                                            Thanh toán khi nhận hàng
                                        </label>
                                    </h3>

                                    <div class="collapse" id="paymentOnDelivery">
                                        <div class="py-2">
                                            <p class="mb-0">Thanh toán trực tiếp sau khi đã nhận hàng. Hoàn tiền trong
                                                vòng 30 ngày kể từ khi đặt haàng nếu có sự cố do chúng tôi.</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="border p-3 mb-3">
                                    <h3 class="h6 mb-0">
                                        <label class="d-block">
                                            <input type="radio" name="paymentMethod" value="paymentByBanking"
                                                   data-bs-toggle="collapse"
                                                   href="#paymentByBanking" role="button" aria-expanded="false"
                                                   aria-controls="paymentByBanking">
                                            Thanh toán bằng Internet Banking (sắp có)
                                        </label>
                                    </h3>

                                    <div class="collapse" id="paymentByBanking">
                                        <div class="py-2">
                                            <p class="mb-0">Thanh toán thông qua Internet Banking. Hoàn tiền trong vòng
                                                30 ngày kể từ khi đặt haàng nếu có sự cố do chúng tôi.</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <button class="btn btn-outline-secondary btn-lg py-3 btn-block" type="submit">Đặt hàng
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <!-- </form> -->
    </div>
</div>

<jsp:include page="/common/client/footer.jsp"/>

<script>
    $(document).ready(function () {
        $('input[name="paymentMethod"]').click(function () {
            if ($(this).val() === 'paymentByBanking' && $(this).is(':checked')) {
                $('input[name="paymentMethod"][value="paymentOnDelivery"]').closest('.collapse').collapse('hide');
            }
        });
    });
</script>

<script src="<c:url value="/templates/client/js/bootstrap.bundle.min.js"/>"></script>
<script src="<c:url value="/templates/client/js/tiny-slider.js"/>"></script>
<script src="<c:url value="/templates/client/js/custom.js"/>"></script>
</body>
</html>

