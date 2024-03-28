package com.ltw.api.cart;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ltw.bean.ProductBean;
import com.ltw.bean.ProductImageBean;
import com.ltw.dao.ImageDAO;
import com.ltw.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// Todo: Hiện thông báo khi hết sản phẩm trong db, Thêm "Đã bán" trên view
@WebServlet(value = {"/api/product-suggest"})
public class ProductSuggestAPI extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();
    private final ImageDAO imageDAO = new ImageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int currentPos = Integer.parseInt(req.getParameter("currentPos"));
        int categoryTypeId = Integer.parseInt(req.getParameter("categoryTypeId"));

        List<ProductBean> productSuggest = productDAO.findSixProductsForSuggest(categoryTypeId, currentPos);
        for (ProductBean product : productSuggest) {
            List<ProductImageBean> thumbnail = imageDAO.getThumbnailByProductId(product.getId());
            product.setImages(thumbnail);
        }
        currentPos += 6;

        ObjectMapper objectMapper = new ObjectMapper();
        String productsJson = objectMapper.writeValueAsString(productSuggest);
        String responseJson = "{\"productList\": " + productsJson + ", \"currentPos\": " + currentPos + "}";

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.getWriter().write(responseJson);
    }
}
