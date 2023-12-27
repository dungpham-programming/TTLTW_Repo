package com.ltw.controller.client;

import com.ltw.bean.ProductDetailBean;
import com.ltw.dao.ProductDetailDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = {"/product-detail"})
public class ProductDetailController extends HttpServlet {
    private final ProductDetailDAO productDetailDAO = new ProductDetailDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       ProductDetailBean productDetailBean = productDetailDAO.findProductById(int id);
        req.setAttribute("productDetails", productDetails);
        req.getRequestDispatcher("product-detail.jsp").forward(req, resp);
    }
}
