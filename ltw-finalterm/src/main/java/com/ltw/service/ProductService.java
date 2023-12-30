package com.ltw.service;

import com.ltw.bean.ProductBean;
import com.ltw.dao.ProductDAO;

import java.util.List;

public class ProductService {
    private final ProductDAO productDAO = new ProductDAO();

    public List<ProductBean> findAllProducts() {
        return productDAO.findAllProducts();
    }
}
