package com.ltw.controller.admin.product;

import com.ltw.bean.ProductBean;
import com.ltw.bean.UserBean;
import com.ltw.dao.ProductDAO;
import com.ltw.dto.LogAddressDTO;
import com.ltw.service.LogService;
import com.ltw.util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.ResourceBundle;

// TODO: Làm chức năng Lịch sử xóa cho mod và khôi phục cho admin (Sử dụng role của User để làm), thêm popup hỏi xem có chắc chắn muốn xóa không
// Ý tưởng: Gửi 1 type (Kiểu xóa) chỉ có admin được xóa về get, sau đó kiểm tra xem roleId của User trong session có là admin không. (Làm sau)
@WebServlet(value = {"/admin/product-management/delete"})
public class ProductDeleteController extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();
    private LogService<ProductBean> logService = new LogService<>();
    private ResourceBundle logBundle = ResourceBundle.getBundle("log-content");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        // Lấy ra UserBean từ session để lấy
        int id = Integer.parseInt(req.getParameter("id"));
        int affectedRows = productDAO.deleteProduct(id);

        LogAddressDTO addressObj;
        UserBean userLogin = (UserBean) SessionUtil.getInstance().getValue(req, "user");
        // Product trước đó (Trong db)
        ProductBean prevObj = productDAO.findProductById(id);
        if (affectedRows >= 0) {
            addressObj = new LogAddressDTO("admin-create-product", userLogin.getId(), logBundle.getString("admin-delete-product-success"));
            logService.createLog(req.getRemoteAddr(), "", "WARNING", addressObj, prevObj, null);
            req.setAttribute("success", "Xóa sản phẩm thành công!");
        } else {
            addressObj = new LogAddressDTO("admin-create-product", userLogin.getId(), logBundle.getString("admin-delete-product-fail"));
            logService.createLog(req.getRemoteAddr(), "", "WARNING", addressObj, prevObj, productDAO.findProductById(id));
            req.setAttribute("error", "Xóa sản phẩm thất bại!");
        }
        // Lấy danh sách sản phẩm lên để cập nhật hiển thị trên view
        List<ProductBean> listProduct = productDAO.findAllProducts();
        req.setAttribute("listProduct", listProduct);
        req.getRequestDispatcher("/product-management.jsp").forward(req, resp);
    }
}
