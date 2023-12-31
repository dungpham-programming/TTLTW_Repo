package com.ltw.controller.admin;

import com.ltw.bean.ProductBean;
import com.ltw.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

// TODO: Làm thêm chức nằng hiển thị các sản phẩm theo status (Hết hàng, Còn hàng, Vô hiệu hóa,...) và tất cả các loại status
@WebServlet(value = {"/admin/product-management"})
public class ProductController extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action != null) {
            switch (action) {
                case "adding":
                    req.getRequestDispatcher("/adding-product.jsp").forward(req, resp);
                    break;

                case "editing":
                    int id = Integer.parseInt(req.getParameter("id"));
                    ProductBean productBean = productService.findProductById(id);
                    req.setAttribute("productBean", productBean);
                    req.getRequestDispatcher("/editing-product.jsp").forward(req, resp);
                    break;

                default:
                    resp.sendRedirect("/admin/product-management");
                    break;
            }
        } else {
            List<ProductBean> listProduct = productService.findAllProducts();
            req.setAttribute("listProduct", listProduct);
            req.getRequestDispatcher("/product-management.jsp").forward(req, resp);
        }
    }


    // TODO: Xử lý trường hợp không nhập discount price hoặc nhập số âm
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("action");
        if (type != null) {
            if (type.equals("adding")) {
                // Sử dụng vòng lặp để set lỗi theo index,
                // tuy nhiên cần phải giữ đúng thứ tự của input theo form và theo database (Vì sử dụng vòng lặp theo i để set lỗi)
                String name = req.getParameter("name");
                String description = req.getParameter("description");
                String categoryTypeId = req.getParameter("categoryTypeId");
                String originalPrice = req.getParameter("originalPrice");
                String discountPrice = req.getParameter("discountPrice");
                String discountPercent = req.getParameter("discountPercent");
                String quantity = req.getParameter("quantity");
                String size = req.getParameter("size");
                String otherSpec = req.getParameter("otherSpec");
                String status = req.getParameter("status");
                String keyword = req.getParameter("keyword");

                // Đặt các thuộc tính đúng thứ tự
                String[] inputsForm = new String[]{name, description, categoryTypeId, originalPrice, discountPrice, discountPercent, quantity, size, otherSpec,  status, keyword};
                // Mảng lưu trữ lỗi
                String[] errors = new String[]{};
            }
        }
    }
}
