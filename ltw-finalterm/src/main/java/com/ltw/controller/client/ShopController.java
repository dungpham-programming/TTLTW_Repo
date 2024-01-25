package com.ltw.controller.client;

import com.ltw.bean.CategoryBean;
import com.ltw.bean.CategoryTypeBean;
import com.ltw.bean.ProductBean;
import com.ltw.bean.ProductImageBean;
import com.ltw.dao.CategoryDAO;
import com.ltw.dao.CategoryTypeDAO;
import com.ltw.dao.ImageDAO;
import com.ltw.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(value = {"/shop"})
public class ShopController extends HttpServlet {
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final CategoryTypeDAO categoryTypeDAO = new CategoryTypeDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final ImageDAO imageDAO = new ImageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CategoryBean> categories = categoryDAO.findAllCategories();
        Map<Integer, List<CategoryTypeBean>> categoryTypeMap = new HashMap<>();
        Map<Integer, List<ProductBean>> productMap = new HashMap<>();
        Map<Integer, ProductImageBean> imageMap = new HashMap<>();

        // Đưa sản phẩm tương ứng với categoryId vào map
        for (CategoryBean category : categories) {
            int categoryId = category.getId();
            List<ProductBean> products = productDAO.findThreeProductByCategoryId(categoryId);
            productMap.put(categoryId, products);
            // Đưa ảnh tương ứng với productId vào map của ảnh
            for (ProductBean product : products) {
                imageMap.put(product.getId(), imageDAO.findOneByProductId(product.getId()));
            }
        }

        // Đưa phân loại sản phẩm tương ứng với categoryId vào map
        for (CategoryBean category : categories) {
            int categoryId = category.getId();
            List<CategoryTypeBean> categoryTypes = categoryTypeDAO.findCategoryTypeByCategoryId(categoryId);
            categoryTypeMap.put(categoryId, categoryTypes);
        }

        req.setAttribute("categories", categories);
        req.setAttribute("categoryTypeMap", categoryTypeMap);
        req.setAttribute("productMap", productMap);
        req.setAttribute("imageMap", imageMap);
        req.getRequestDispatcher("/shop.jsp").forward(req, resp);
    }
}
