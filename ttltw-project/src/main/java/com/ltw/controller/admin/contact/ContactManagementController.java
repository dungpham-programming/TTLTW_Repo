package com.ltw.controller.admin.contact;

import com.ltw.bean.ContactBean;
import com.ltw.dao.ContactDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/contact-management")
public class ContactManagementController extends HttpServlet {
    private final ContactDAO contactDAO = new ContactDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ContactBean> contacts = contactDAO.findAllContacts();
        request.setAttribute("contacts", contacts);
        request.getRequestDispatcher("/contact-management.jsp").forward(request, response);
    }
}