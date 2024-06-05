package com.ltw.controller.admin.product;

import com.ltw.bean.ProductBean;
import com.ltw.bean.UserBean;
import com.ltw.dao.ProductDAO;
import com.ltw.dto.LogAddressDTO;
import com.ltw.service.LogService;
import com.ltw.util.BlankInputUtil;
import com.ltw.util.NumberValidateUtil;
import com.ltw.util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.ResourceBundle;

@WebServlet(value = {"/admin/product-management/adding"})
public class ProductAddingController extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();
    private LogService<ProductBean> logService = new LogService<>();
    private ResourceBundle logBundle = ResourceBundle.getBundle("log-content");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/adding-product.jsp").forward(req, resp);
    }

    // TODO: Xử lý trường hợp không nhập discount price hoặc nhập số âm
    // TODO: Gom các util validate làm 1 (Sau khi sửa xong)
    // TODO: Thêm thông báo thành công
    // TODO: Sticky cho nút add và thẻ td trong table
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        // Sử dụng vòng lặp để set lỗi để trống theo index,
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

        // Các biến lưu giữ lỗi về giá (Tên biến là viết tắt của
        // originalPriceErr, discountPriceErr, discountPercentErr)
        String oPrErr = "e", dPrErr = "e", dPeErr = "e";

        // Biến thông báo thành công
        String success = "success";

        // Đặt các thuộc tính đúng thứ tự
        String[] inputsForm = new String[]{name, description, categoryTypeId, originalPrice, discountPrice, discountPercent, quantity, size, otherSpec, status, keyword};
        // Mảng lưu trữ lỗi
        ArrayList<String> errors = new ArrayList<>();

        // Biến bắt lỗi
        boolean isValid = true;

        for (String string : inputsForm) {
            if (BlankInputUtil.isBlank(string)) {
                errors.add("e");
                if (isValid) {
                    isValid = false;
                }
            } else {
                errors.add(null);
            }
        }
        req.setAttribute("errors", errors);

        // Kiểm tra các lỗi nhập liệu khác
        // Lỗi nhập liệu cho giá và phần trăm (Là phần số)
        if (!NumberValidateUtil.isNumeric(originalPrice) || NumberValidateUtil.isValidPrice(originalPrice)) {
            if (isValid) {
                isValid = false;
            }
            req.setAttribute("oPrErr", oPrErr);
        }

        if (!NumberValidateUtil.isNumeric(discountPrice) || NumberValidateUtil.isValidPrice(discountPrice)) {
            if (isValid) {
                isValid = false;
            }
            req.setAttribute("oPrErr", dPrErr);
        }

        if (!NumberValidateUtil.isNumeric(discountPercent)) {
            if (isValid) {
                isValid = false;
            }
            req.setAttribute("dPeErr", dPeErr);
        }

        // Kiểm tra tên sản phẩm (Không được trùng tên)
        if (productDAO.isExistProductName(name)) {
            // TODO: Thêm bắt lỗi trên JSP khi xử lý lỗi db
            String nameErr = "e";
            if (isValid) {
                isValid = false;
            }
            req.setAttribute("nameErr", nameErr);
        }

        LogAddressDTO addressObj;
        UserBean userLogin = (UserBean) SessionUtil.getInstance().getValue(req, "user");
        // Nếu không lỗi thì lưu vào database
        if (isValid) {
            // Đổi String về số
            int categoryTypeIdInt = NumberValidateUtil.toInt(categoryTypeId);
            int quantityInt = NumberValidateUtil.toInt(quantity);
            int statusInt = NumberValidateUtil.toInt(status);
            double originalPriceDouble = NumberValidateUtil.toDouble(originalPrice);
            double discountPriceDouble = NumberValidateUtil.toDouble(discountPrice);
            double discountPercentDouble = NumberValidateUtil.toDouble(discountPercent);

            // Set thuộc tính vào bean
            ProductBean productBean = new ProductBean();
            productBean.setName(name);
            productBean.setDescription(description);
            productBean.setCategoryTypeId(categoryTypeIdInt);
            productBean.setOriginalPrice(originalPriceDouble);
            productBean.setDiscountPrice(discountPriceDouble);
            productBean.setDiscountPercent(discountPercentDouble);
            productBean.setQuantity(quantityInt);
            productBean.setSize(size);
            productBean.setOtherSpec(otherSpec);
            productBean.setStatus(statusInt);
            productBean.setKeyword(keyword);

            int affectedRows = productDAO.createProduct(productBean);
            if (affectedRows < 0) {
                // TODO: Thêm bắt lỗi trên JSP khi xử lý lỗi db
                addressObj = new LogAddressDTO("admin-create-product", userLogin.getId(), logBundle.getString("admin-create-product-fail"));
                logService.createLog(req.getRemoteAddr(), "", "ALERT", addressObj, null, null);
                String createErr = "e";
                req.setAttribute("createErr", createErr);
                req.getRequestDispatcher("/adding-product.jsp").forward(req, resp);
            } else {
                addressObj = new LogAddressDTO("admin-create-product", userLogin.getId(), logBundle.getString("admin-create-product-success"));
                logService.createLog(req.getRemoteAddr(), "", "ALERT", addressObj, null, productDAO.findProductByName(name));
                resp.sendRedirect(req.getContextPath() + "/admin/product-management/adding?success=" + success);
            }
        } else {
            addressObj = new LogAddressDTO("admin-create-product", userLogin.getId(), logBundle.getString("admin-create-product-fail"));
            logService.createLog(req.getRemoteAddr(), "", "ALERT", addressObj, null, null);
            req.getRequestDispatcher("/adding-product.jsp").forward(req, resp);
        }
    }
}
