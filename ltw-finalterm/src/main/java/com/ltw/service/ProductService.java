package com.ltw.service;

import com.ltw.bean.ProductBean;
import com.ltw.dao.ProductDAO;

import java.util.List;

public class ProductService {
    private final ProductDAO productDAO = new ProductDAO();

    public List<ProductBean> findAllProducts() {
        return productDAO.findAllProducts();
    }

    public ProductBean findProductById(int id) {
        return productDAO.findProductById(id);
    }

    public void updateProduct(ProductBean productBean) {
        productDAO.updateProduct(productBean);
    }

    public void createProduct(ProductBean productBean) {
        productDAO.createProduct(productBean);
    }
}
