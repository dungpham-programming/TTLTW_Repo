package com.ltw.controller.client;

import com.ltw.bean.ImageBean;
import com.ltw.bean.ProductBean;
import com.ltw.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = {"/product-detail"})
public class ProductDetailController extends HttpServlet {
    private final ProductDAO productDetailDAO = new ProductDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("id"));

        ProductBean productDetailBean = productDetailDAO.findProductById(productId);
        List<ImageBean> imageBeans = productDetailDAO.findImagesByProductId(productId);

        req.setAttribute("productDetails", productDetailBean);
        req.setAttribute("imageList", imageBeans);

        req.getRequestDispatcher("product-detail.jsp").forward(req, resp);
    }
}
