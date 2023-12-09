package com.ltw.service;

import com.ltw.bean.CategoryBean;
import com.ltw.dao.CategoryDAO;

import java.util.List;

public class CategoryService {
    private final CategoryDAO categoryDAO = new CategoryDAO();

    public List<CategoryBean> findAllCategories() {
        return categoryDAO.findAllCategories();
    }
}
