<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.Item" %>
<%@ page import="com.ltw.bean.Cart" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/client/using-resource-header.jsp"/>
    <title>DDD. - Giỏ hàng</title>
</head>

<body>
<jsp:include page="/common/client/header.jsp"/>
<!-- Start Hero Section -->
<div class="hero cart position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-lg-5">
                <div class="intro-excerpt">
                    <h1>Thanh toán</h1>
                </div>
            </div>
            <div class="col-lg-7">

            </div>
        </div>
    </div>
</div>
<!-- End Hero Section -->


<div class="untree_co-section before-footer-section">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-9">
                <div class="row mb-5">
                    <div class="site-blocks-table">
                        <table class="table">
                            <thead>
                            <tr>
                                <th class="product-remove"></th>
                                <th class="product-name">Sản phẩm</th>
                                <th class="product-price">Đơn giá</th>
                                <th class="product-quantity">Số lượng</th>
                                <th class="product-total">Thành tiền</th>
                            </tr>
                            </thead>
                            <tbody id="table-content">
                            <%
                                Cart cart = (Cart) request.getSession().getAttribute("cart");
                                if (cart != null) {
                                    List<Item> items = cart.getItems();
                                    if (items != null) {
                                        if (!items.isEmpty()) {
                                            for (int i = 0; i < cart.getTotalItem(); i++) {
                                                String linkImage = items.get(i).getProduct().getImages().get(0).getLink();
                            %>
                            <tr>
                                <td>
                                    <input type="hidden" name="productId" value="<%=items.get(i).getProduct().getId()%>">
                                    <button class="btn btn-black btn-sm">X</button>
                                </td>
                                <td class="product-name">
                                    <div class="d-flex align-items-center">
                                        <img src="<%=linkImage%>" alt="Image" class="img-config">
                                        <h2 class="h5 m-0 ps-4 text-black"><%=items.get(i).getProduct().getName()%>
                                        </h2>
                                    </div>
                                </td>
                                <td>
                                    <div class="d-flex flex-column mb-2">
                                        <div class="main-price d-flex justify-content-start">
                                            <f:formatNumber
                                                    value="<%=items.get(i).getProduct().getDiscountPrice()%>"
                                                    pattern="#,##0.##"/>đ
                                        </div>
                                        <div class="d-flex flex-row">
                                            <div class="original-price">
                                                <del><f:formatNumber
                                                        value="<%=items.get(i).getProduct().getOriginalPrice()%>"
                                                        pattern="#,##0.##"/>đ
                                                </del>
                                            </div>
                                            <div class="discount-percent">
                                                <f:formatNumber
                                                        value="<%=items.get(i).getProduct().getDiscountPercent()%>"
                                                        pattern="#,##0.##"/>%
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="input-group d-flex align-items-center quantity-container"
                                         style="max-width: 120px;">
                                        <div class="input-group-prepend">
                                            <button class="btn btn-outline-black decrease" type="button">&minus;
                                            </button>
                                        </div>
                                        <input type="hidden" class="productId" name="productId"
                                               value="<%=items.get(i).getProduct().getId()%>">
                                        <input type="text" class="form-control text-center quantity-amount"
                                               name="quantity-<%=i+1%>" value="<%=items.get(i).getQuantity()%>"
                                               placeholder="" aria-label="Example text with button addon"
                                               aria-describedby="button-addon1">
                                        <div class="input-group-append">
                                            <button class="btn btn-outline-black increase" type="button">&plus;
                                            </button>
                                        </div>
                                    </div>
                                </td>
                                <td class="total"><f:formatNumber value="<%=items.get(i).getTotalWithDiscount()%>"
                                                                  pattern="#,##0.##"/>đ
                                </td>
                            </tr>
                            <% }
                            }
                            }
                            }
                            %>
                            </tbody>
                        </table>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <div class="row mb-5">
                                <div class="col-md-6">
                                    <div class="cart-btn d-inline-block">
                                        <a style="color: #e3bd74;" href="<c:url value="/shop"/>">Tiếp tục mua</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-3 total">
                <div class="row">
                    <div class="row">
                        <div class="col-md-12 text-right border-bottom mb-5">
                            <h3 class="text-black h4 text-uppercase">Tổng cộng</h3>
                        </div>
                    </div>
                    <div id="total-container" class="row flex-column">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <span class="text-black">Tổng giá gốc</span>
                            </div>
                            <div class="col-md-6 text-right">
                                <del class="text-black original-total"><f:formatNumber
                                        value="<%=cart != null ? cart.getOriginalPriceTotal() : 0%>"
                                        pattern="#,##0.##"/>đ
                                </del>
                            </div>
                        </div>
                        <div class="row mb-5">
                            <div class="col-md-6">
                                <span class="text-black">Tổng giá sau giảm</span>
                            </div>
                            <div class="col-md-6 text-right">
                                <strong class="text-danger discount-total"><f:formatNumber
                                        value="<%=cart != null ? cart.getDiscountPriceTotal() : 0%>"
                                        pattern="#,##0.##"/>đ</strong>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <a href="<c:url value="/checkout"/>" class="cart-btn">Đi đến kiểm tra
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/client/footer.jsp"/>

<%-- Icon --%>
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
    <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
        <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"></path>
    </symbol>
    <symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
        <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"></path>
    </symbol>
    <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
        <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"></path>
    </symbol>
</svg>

<jsp:include page="/common/client/using-resource-footer.jsp"/>
<script src="<c:url value="/templates/client/js/ajax/cart/cart-update.js"/>"></script>
<script src="<c:url value="/templates/client/js/ajax/cart/cart-delete.js"/>"></script>
</body>
</html>
