package com.ltw.service;

import com.ltw.bean.BlogBean;
import com.ltw.dao.BlogDAO;

import java.util.List;

public class BlogService {
    private final BlogDAO blogDAO = new BlogDAO();

    // Service lấy 3 bài viết từ database
    public List<BlogBean> findThreeBlogs() {
        return blogDAO.findThreeBlogs();
    }
}
