package com.ltw.controller.admin;

import com.ltw.bean.ProductBean;
import com.ltw.service.ProductService;
import com.ltw.util.BlankInputUtil;
import com.ltw.util.NumberValidateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

// TODO: Làm thêm chức nằng hiển thị các sản phẩm theo status (Hết hàng, Còn hàng, Vô hiệu hóa,...) và tất cả các loại status
// TODO: Thực hiện thay đổi giá giảm thì tự cập nhật % và ngược lại
@WebServlet(value = {"/admin/product-management"})
public class ProductController extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action != null) {
            switch (action) {
                case "go-to-add":
                    req.getRequestDispatcher("/adding-product.jsp").forward(req, resp);
                    break;

                case "go-to-edit":
                    int id = Integer.parseInt(req.getParameter("id"));
                    ProductBean productBean = productService.findProductById(id);
                    if (productBean == null) {
                        // Phòng trường hợp truyền id không đúng (Từ URL) sẽ bị null bean
                        resp.sendRedirect("/admin/product-management");
                    } else {
                        req.setAttribute("productBean", productBean);
                        req.getRequestDispatcher("/editing-product.jsp").forward(req, resp);
                    }
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
    // TODO: Gom các util validate làm 1 (Sau khi sửa xong)
    // TODO: Thêm thông báo thành công
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action != null) {
            // Sử dụng vòng lặp để set lỗi để trống theo index,
            // tuy nhiên cần phải giữ đúng thứ tự của input theo form và theo database (Vì sử dụng vòng lặp theo i để set lỗi)
            int id = Integer.parseInt(req.getParameter("id"));
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
            // Lỗi nhập liệu cho giá và phần trăm
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

            if (action.equals("adding-product")) {
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

                    productService.updateProduct(productBean);
                    resp.sendRedirect(req.getContextPath() + "/admin/product-management?action=adding&success=" + success);
                } else {
                    req.getRequestDispatcher("/adding-product.jsp").forward(req, resp);
                }
            }

            if (action.equals("editing-product")) {
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

                    productService.updateProduct(productBean);
                    resp.sendRedirect(req.getContextPath() + "/admin/product-management?id=" + id + "&action=go-to-edit&success=" + success);
                } else {
                    ProductBean productBean = productService.findProductById(id);
                    req.setAttribute("productBean", productBean);
                    req.getRequestDispatcher("/editing-product.jsp").forward(req, resp);
                }
            }
        }
    }
}
