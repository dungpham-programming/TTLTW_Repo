package com.ltw.controller.admin.blog;

import com.ltw.bean.BlogBean;
import com.ltw.bean.UserBean;
import com.ltw.dao.BlogDAO;
import com.ltw.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/blog-management")

public class BlogManagementController extends HttpServlet {

    private final BlogDAO blogDAO = new BlogDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<BlogBean> blogs = blogDAO.findAllBlogs();
        request.setAttribute("blogs", blogs);
        request.getRequestDispatcher("/blog-management.jsp").forward(request, response);
    }
}
