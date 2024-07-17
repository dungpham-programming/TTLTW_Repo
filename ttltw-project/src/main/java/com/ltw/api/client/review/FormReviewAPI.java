package com.ltw.api.client.review;

import com.google.gson.Gson;
import com.ltw.bean.ProductBean;
import com.ltw.bean.ProductImageBean;
import com.ltw.bean.ReviewBean;
import com.ltw.constant.LogLevel;
import com.ltw.constant.LogState;
import com.ltw.dao.ImageDAO;
import com.ltw.dao.OrderDetailDAO;
import com.ltw.dao.ProductDAO;
import com.ltw.dao.ReviewDAO;
import com.ltw.service.LogService;
import com.ltw.util.BlankInputUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet(value = {"/api/client/review-form"})
public class FormReviewAPI extends HttpServlet {
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final ImageDAO imageDAO = new ImageDAO();
    private final ReviewDAO reviewDAO = new ReviewDAO();
    private final LogService<ReviewBean> logService = new LogService<>();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        List<ReviewBean> reviewForms = new ArrayList<>();

        List<Integer> productIdsUnreviewed = orderDetailDAO.getUnreviewedProductByOrderId(orderId);
        for (Integer productId : productIdsUnreviewed) {
            ProductBean productInfo = productDAO.findProductById(productId);

            List<ProductImageBean> productImages = imageDAO.findImagesByProductId(productId);
            productInfo.setImages(productImages);

            ReviewBean reviewForm = new ReviewBean();
            reviewForm.setProductId(productId);
            reviewForm.setProductName(productInfo.getName());
            reviewForm.setOrderId(orderId);
            List<String> imgUrls = new ArrayList<>();
            for (ProductImageBean productImg : productInfo.getImages()) {
                imgUrls.add(productImg.getLink());
            }
            reviewForm.setProductImgs(imgUrls);
            reviewForms.add(reviewForm);
        }

        // Gson không lấy giá trị null
        Gson gson = new Gson();
        String json = gson.toJson(reviewForms);

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        int userId = Integer.parseInt(req.getParameter("userId"));
        int productId = Integer.parseInt(req.getParameter("productId"));
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        int rating = Integer.parseInt(req.getParameter("rating"));
        String content = req.getParameter("content");
        String username = req.getParameter("username");
        String productName = req.getParameter("productName");
        boolean isValid = true;
        String status = "", notify = "";

        if (userId < 0) {
            isValid = false;
        }
        if (productId < 0) {
            isValid = false;
        }
        if (orderId < 0) {
            isValid = false;
        }
        if (rating < 0 || rating > 5) {
            isValid = false;
        }
        if (BlankInputUtil.isBlank(content) || BlankInputUtil.isBlank(username) || BlankInputUtil.isBlank(productName)) {
            isValid = false;
        }

        if (isValid) {
            ReviewBean reviewBean = new ReviewBean();
            reviewBean.setProductId(productId);
            reviewBean.setProductName(productName);
            reviewBean.setUserId(userId);
            reviewBean.setUsername(username);
            reviewBean.setOrderId(orderId);
            reviewBean.setRating(rating);
            reviewBean.setContent(content);
            reviewBean.setCreatedDate(new Timestamp(System.currentTimeMillis()));
            reviewBean.setCreatedBy(username);

            int id = reviewDAO.createReview(reviewBean);
            if (id <= 0) {
                status = "error";
                notify = "Có lỗi hệ thống khi gửi đánh giá!";
                logService.log(req, "user-review", LogState.FAIL, LogLevel.ALERT, null, null);
            } else {
                status = "success";
                notify = "Đánh giá thành công!";
                orderDetailDAO.setSuccessReview(productId, orderId);
                // Ơ trên đã update vào db nên ở đây ta chỉ cần lấy ra tính
                int rateTotalAfterUpdate = reviewDAO.getRateTotal(productId);
                int totalReviewAfterUpdate = reviewDAO.getRelatedReview(productId);
                double newRateTotal = ((double) rateTotalAfterUpdate / totalReviewAfterUpdate);
                productDAO.updateRateTotal(productId, newRateTotal, totalReviewAfterUpdate);
                logService.log(req, "user-review", LogState.SUCCESS, LogLevel.ALERT, null, reviewBean);
            }
        } else {
            status = "error";
            notify = "Thông tin không được để trống!";
        }

        String json = "{\"status\": \"" + status + "\", \"notify\": \"" + notify + "\"}";
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.getWriter().write(json);
    }
}
