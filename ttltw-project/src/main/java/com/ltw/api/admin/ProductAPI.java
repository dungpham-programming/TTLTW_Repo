package com.ltw.api.admin;

import com.ltw.bean.ProductBean;
import com.ltw.constant.LogLevel;
import com.ltw.constant.LogState;
import com.ltw.dao.ProductDAO;
import com.ltw.service.LogService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.ResourceBundle;

@WebServlet(value = {"/api/product"})
public class ProductAPI extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();
    private LogService<ProductBean> logService = new LogService<>();
    private ResourceBundle logBundle = ResourceBundle.getBundle("log-content");

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String msg = "";
        // Lấy ra UserBean từ session để lấy
        int id = Integer.parseInt(req.getParameter("id"));
        int affectedRows = productDAO.deleteProduct(id);

        // Product trước đó (Trong db)
        ProductBean prevProduct = productDAO.findProductById(id);
        if (affectedRows > 0) {
            logService.log(req, "admin-delete-product", LogState.SUCCESS, LogLevel.WARNING, prevProduct, null);
            msg = "success";
        } else {
            logService.log(req, "admin-delete-product", LogState.FAIL, LogLevel.ALERT, prevProduct, prevProduct);
            msg = "fail";
        }
        // Lấy danh sách sản phẩm lên để cập nhật hiển thị trên view
        List<ProductBean> listProduct = productDAO.findAllProducts();
        req.setAttribute("msg", msg);
        req.setAttribute("listProduct", listProduct);
        req.getRequestDispatcher("/product-management.jsp").forward(req, resp);
    }
}
