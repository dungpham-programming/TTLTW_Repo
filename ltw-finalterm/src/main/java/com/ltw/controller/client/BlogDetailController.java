package com.ltw.controller.client;

import com.ltw.bean.BlogDetailBean;
import com.ltw.dao.BlogDetailDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(value = {"/blog-detail"})
public class BlogDetailController extends HttpServlet {
    private final BlogDetailDAO blogDetailDAO = new BlogDetailDAO();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int blogId = Integer.parseInt(request.getParameter("id"));

        BlogDetailBean blogDetailBean = blogDetailDAO.findBlogById(blogId);
        request.setAttribute("blogDetail", blogDetailBean);
        request.getRequestDispatcher("blog_detail.jsp").forward(request, response);


    }
}

