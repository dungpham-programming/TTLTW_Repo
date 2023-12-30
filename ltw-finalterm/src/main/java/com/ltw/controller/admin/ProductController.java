package com.ltw.controller.admin;

import com.ltw.bean.ProductBean;
import com.ltw.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// TODO: Làm thêm chức nằng hiển thị các sản phẩm theo status (Hết hàng, Còn hàng, Vô hiệu hóa,...) và tất cả các loại status
@WebServlet(value = {"/admin/product-management"})
public class ProductController extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("action");
        if (type == null) {
            List<ProductBean> listProduct = productService.findAllProducts();
            req.setAttribute("listProduct", listProduct);
            req.getRequestDispatcher("/product-management.jsp").forward(req, resp);
        }
    }
}
