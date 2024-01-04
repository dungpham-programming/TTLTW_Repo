package com.ltw.controller.client;

import com.ltw.bean.BlogBean;
import com.ltw.bean.CategoryBean;
import com.ltw.bean.CustomizeBean;
import com.ltw.dao.BlogDAO;
import com.ltw.dao.CategoryDAO;
import com.ltw.dao.CustomizeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = {"/home"})
public class HomeController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final BlogDAO blogDAO = new BlogDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();
        List<CategoryBean> listCategories = categoryDAO.findAllCategories();
        List<BlogBean> listThreeBlogs = blogDAO.findThreeBlogs();
        req.setAttribute("customizeInfo", customizeInfo);
        req.setAttribute("listCategories", listCategories);
        req.setAttribute("listBlogs", listThreeBlogs);
        req.getRequestDispatcher("client-home.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
