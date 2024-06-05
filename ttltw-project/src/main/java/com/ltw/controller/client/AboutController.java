package com.ltw.controller.client;

import javax.servlet.http.HttpServlet;
import com.ltw.bean.CustomizeBean;
import com.ltw.dao.CustomizeDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet(value = {"/about-us"})
public class AboutController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();

        req.setAttribute("customizeInfo", customizeInfo);
        req.getRequestDispatcher("/about.jsp").forward(req, resp);
    }
}
