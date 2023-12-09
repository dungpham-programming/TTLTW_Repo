package com.ltw.controller.client;

import com.ltw.bean.BlogBean;
import com.ltw.bean.CategoryBean;
import com.ltw.service.BlogService;
import com.ltw.service.CategoryService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = {"/home"})
public class HomeController extends HttpServlet {
    private final CategoryService categoryService = new CategoryService();
    private final BlogService blogService = new BlogService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CategoryBean> listCategories = categoryService.findAllCategories();
        List<BlogBean> listThreeBlogs = blogService.findThreeBlogs();
        req.setAttribute("listCategories", listCategories);
        req.setAttribute("listBlogs", listThreeBlogs);
        req.getRequestDispatcher("client-home.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
