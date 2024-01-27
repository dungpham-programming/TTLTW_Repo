<%@ page import="com.ltw.bean.CustomizeBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Start Footer Section -->
<footer class="footer-section position-relative-top-84px">
    <div class="container relative">
        <div class="row g-5 mb-5">
            <div class="col-4">
                <%
                    CustomizeBean customizeInfo = (CustomizeBean) request.getAttribute("customizeInfo");
                    String facebookLink = (customizeInfo.getFacebookLink().isEmpty()) ? "#" : customizeInfo.getFacebookLink();
                    String twitterLink = (customizeInfo.getTwitterLink().isEmpty()) ? "#" : customizeInfo.getTwitterLink();
                    String instagramLink = (customizeInfo.getInstagramLink().isEmpty()) ? "#" : customizeInfo.getInstagramLink();
                    String linkedinLink = (customizeInfo.getLinkedinLink().isEmpty()) ? "#" : customizeInfo.getLinkedinLink();
                %>
                <div class="mb-4"><p href="#" class="footer-head">DDD<span>.</span></p></div>
                <p class="mb-4 light-text footer-content"><%=customizeInfo.getFooterLeft()%></p>
            </div>

            <div class="col-4 center-text">
                <div class="mb-4"><p id="mxh-changing" class="footer-head">Mạng xã hội</p></div>
                <p class="mb-4 light-text footer-content"><%=customizeInfo.getFooterMiddle()%></p>
                <ul class="list-unstyled custom-social">
                    <li><a href="<%=facebookLink%>"><span class="fa fa-brands fa-facebook-f footer-content"></span></a></li>
                    <li><a href="<%=twitterLink%>"><span class="fa fa-brands fa-twitter footer-content"></span></a></li>
                    <li><a href="<%=instagramLink%>"><span class="fa fa-brands fa-instagram footer-content"></span></a></li>
                    <li><a href="<%=linkedinLink%>"><span class="fa fa-brands fa-linkedin footer-content"></span></a></li>
                </ul>
            </div>

            <div class="col-4">
                <div class="row links-wrap">
                    <div class="right-text">
                        <div class="mb-4"><p class="footer-head">Nội dung</p></div>
                        <ul class="list-unstyled ">
                            <li><a class="light-text footer-content" href="#">Sản phẩm</a></li>
                            <li><a class="light-text footer-content" href="#">Tin tức</a></li>
                            <li><a class="light-text footer-content" href="#">Liên hệ</a></li>
                            <li><a class="light-text footer-content" href="#">Về chúng tôi</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="border-top copyright">
            <div class="row pt-4">
                <div class="col-lg-6">
                    <p class="mb-2 text-center text-lg-start light-text footer-content">Copyright &copy;<script>document.write(new Date().getFullYear());</script>. All Rights Reserved.</p>
                    <!-- License information: https://untree.co/license/ -->
                </div>

                <div class="col-lg-6 text-center text-lg-end light-text">
                    <ul class="list-unstyled d-inline-flex ms-auto">
                        <li class="me-4 footer-content"><a  href="#">Terms &amp; Conditions</a></li>
                        <li><a href="#" class="footer-content">Privacy Policy</a></li>
                    </ul>
                </div>
            </div>
        </div>

    </div>
</footer>
<!-- End Footer Section -->

<button id="scroll-to-top"><i class="fa-solid fa-chevron-up" style="color: #e3bd74;"></i></button>
