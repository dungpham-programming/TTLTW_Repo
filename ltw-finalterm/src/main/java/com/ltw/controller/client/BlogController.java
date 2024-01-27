package com.ltw.controller.client;

import javax.servlet.http.HttpServlet;
import com.ltw.bean.BlogBean;
import com.ltw.dao.BlogDAO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
@WebServlet(value = {"/blog"})
public class BlogController extends HttpServlet {
    private final BlogDAO BlogDAO = new BlogDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<BlogBean> listBlogs = BlogDAO.findAllBlogs();
        req.setAttribute("listBlogs", listBlogs);
        req.getRequestDispatcher("blog.jsp").forward(req, resp);
    }
}