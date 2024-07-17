package com.ltw.api.client.review;

import com.google.gson.Gson;
import com.ltw.bean.ProductBean;
import com.ltw.bean.ProductImageBean;
import com.ltw.bean.ReviewBean;
import com.ltw.dao.ImageDAO;
import com.ltw.dao.OrderDetailDAO;
import com.ltw.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(value = {"/api/client/review-form"})
public class FormReviewAPI extends HttpServlet {
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final ImageDAO imageDAO = new ImageDAO();

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
}
