package com.ltw.controller.admin.product;

import com.ltw.bean.ProductBean;
import com.ltw.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// TODO: Thực hiện thay đổi giá giảm thì tự cập nhật % và ngược lại
@WebServlet(value = {"/admin/product-management"})
public class ProductManagementController extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    // Todo: Hiển thị soldQuantity và không cho phép thuộc tính này thay đổi
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ProductBean> listProduct = productDAO.findAllProducts();
        req.setAttribute("listProduct", listProduct);
        req.getRequestDispatcher("/product-management.jsp").forward(req, resp);
    }
}
