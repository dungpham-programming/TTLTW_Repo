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
        <%
            String error = request.getParameter("error");
            String productId = request.getParameter("productId");
            String quantity = request.getParameter("quantity");
        %>
        <div id="notify" class="alert alert-info"><% if (error != null) { %>Mặt hàng mã <%=productId%> chỉ còn <%=quantity%> sản phẩm!<%}%></div>
        <div class="row mb-5">
            <form action="<c:url value="/cart-updating"/>" class="col-md-12" method="post">
                <div class="site-blocks-table">
                    <table class="table">

                        <thead>
                        <tr>
                            <th class="product-thumbnail">Ảnh</th>
                            <th class="product-name">Sản phẩm</th>
                            <th class="product-price">Giá gốc</th>
                            <th class="product-dprice">Giá giảm</th>
                            <th class="product-quantity">Số lượng</th>
                            <th class="product-total">Tổng cộng (Giá giảm)</th>
                            <th class="product-remove">Xóa</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            Cart cart = (Cart) request.getSession().getAttribute("cart");
                            if (cart != null) {
                                List<Item> items = cart.getItems();
                                if (items != null) {
                                    if (!items.isEmpty()) {
                                        for (int i = 0; i < cart.getTotalItem(); i++) {
                        %>
                        <tr>
                            <td class="product-thumbnail">
                                <img src="images/product-1.png" alt="Image" class="img-fluid">
                            </td>
                            <td class="product-name">
                                <h2 class="h5 text-black"><%=items.get(i).getProduct().getName()%></h2>
                            </td>
                            <td class="original-price"><f:formatNumber value="<%=items.get(i).getProduct().getOriginalPrice()%>" pattern="#,##0.##"/>đ</td>
                            <td class="discount-price"><f:formatNumber value="<%=items.get(i).getProduct().getDiscountPrice()%>" pattern="#,##0.##"/>đ</td>
                            <td>
                                <div class="input-group mb-3 d-flex align-items-center quantity-container"
                                     style="max-width: 120px;">
                                    <div class="input-group-prepend">
                                        <button class="btn btn-outline-black decrease" type="button">&minus;</button>
                                    </div>
                                    <input type="text" class="form-control text-center quantity-amount" name="quantity-<%=i+1%>" value="<%=items.get(i).getQuantity()%>"
                                           placeholder="" aria-label="Example text with button addon"
                                           aria-describedby="button-addon1">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-black increase" type="button">&plus;</button>
                                    </div>
                                </div>
                            </td>
                            <td class="total"><f:formatNumber value="<%=items.get(i).getTotalWithDiscount()%>" pattern="#,##0.##"/>đ</td>
                            <td><a href="<c:url value="/cart-deleting"><c:param name="productId" value="<%=String.valueOf(items.get(i).getProduct().getId())%>"/></c:url>" class="btn btn-black btn-sm">X</a></td>
                        </tr>
                        <%              }
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
                                <input class="cart-btn" type="submit" value="Cập nhật giỏ hàng">
                            </div>
                            <div class="col-md-6">
                                <div class="cart-btn d-inline-block">
                                    <a style="color: #e3bd74;" href="<c:url value="/product"/>">Tiếp tục mua</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <div class="row flex-row-reverse">
            <div class="col-md-6 pl-5">
                <div class="row justify-content-end">
                    <div class="col-md-7">
                        <div class="row">
                            <div class="col-md-12 text-right border-bottom mb-5">
                                <h3 class="text-black h4 text-uppercase">Tổng cộng</h3>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <span class="text-black">Tổng giá gốc</span>
                            </div>
                            <div class="col-md-6 text-right">
                                <del class="text-black original-total"><f:formatNumber value="<%=cart.getOriginalPriceTotal()%>" pattern="#,##0.##"/>đ</del>
                            </div>
                        </div>
                        <div class="row mb-5">
                            <div class="col-md-6">
                                <span class="text-black">Tổng giá sau giảm</span>
                            </div>
                            <div class="col-md-6 text-right">
                                <strong class="text-black discount-total"><f:formatNumber value="<%=cart.getDiscountPriceTotal()%>" pattern="#,##0.##"/>đ</strong>
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
</div>

<jsp:include page="/common/client/footer.jsp"/>

<jsp:include page="/common/client/using-resource-footer.jsp"/>
</body>
</html>
