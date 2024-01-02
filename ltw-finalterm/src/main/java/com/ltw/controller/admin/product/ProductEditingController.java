package com.ltw.controller.admin.product;

import com.ltw.bean.ProductBean;
import com.ltw.dao.ProductDAO;
import com.ltw.util.BlankInputUtil;
import com.ltw.util.NumberValidateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(value = {"/admin/product-management/editing"})
public class ProductEditingController extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        ProductBean productBean = productDAO.findProductById(id);
        req.setAttribute("productBean", productBean);
        req.getRequestDispatcher("/editing-product.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        // Sử dụng vòng lặp để set lỗi để trống theo index,
        // tuy nhiên cần phải giữ đúng thứ tự của input theo form và theo database (Vì sử dụng vòng lặp theo i để set lỗi)
        String idStr = req.getParameter("id");
        // Lấy id kiểu int ra để lưu vào database
        int id = Integer.parseInt(idStr);
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

        // Các biến lưu giữ lỗi về giá
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
        if (!NumberValidateUtil.isNumeric(originalPrice)) {
            if (isValid) {
                isValid = false;
            }
            req.setAttribute("oPrErr", oPrErr);
        }
        if (!NumberValidateUtil.isNumeric(discountPrice)) {
            if (isValid) {
                isValid = false;
            }
            req.setAttribute("dPrErr", dPrErr);
        }
        if (!NumberValidateUtil.isNumeric(discountPercent)) {
            if (isValid) {
                isValid = false;
            }
            req.setAttribute("dPeErr", dPeErr);
        }

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
            productBean.setId(id);
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

            productDAO.updateProduct(productBean);
            resp.sendRedirect(req.getContextPath() + "/admin/product-management/editing?id=" + productBean.getId() + "&success=" + success);
        } else {
            ProductBean productBean = productDAO.findProductById(id);
            req.setAttribute("productBean", productBean);
            req.getRequestDispatcher("/editing-product.jsp").forward(req, resp);
        }
    }
}
