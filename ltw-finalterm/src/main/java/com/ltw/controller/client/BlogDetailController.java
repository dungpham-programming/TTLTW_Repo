package com.ltw.controller.client;

import com.ltw.bean.BlogBean;
import com.ltw.dao.BlogDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = {"/blog-detail"})
public class BlogDetailController extends HttpServlet {
    private final BlogDAO blogDetailDAO = new BlogDAO();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int blogId = Integer.parseInt(request.getParameter("id"));

        BlogBean blogDetailBean = blogDetailDAO.findBlogById(blogId);
        request.setAttribute("blogDetail", blogDetailBean);
        request.getRequestDispatcher("blog_detail.jsp").forward(request, response);


    }
}

