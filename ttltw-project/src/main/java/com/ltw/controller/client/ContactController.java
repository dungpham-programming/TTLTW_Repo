package com.ltw.controller.client;

import com.ltw.bean.ContactBean;
import com.ltw.bean.CustomizeBean;
import com.ltw.dao.ContactDAO;
import com.ltw.dao.CustomizeDAO;
import com.ltw.util.BlankInputUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = {"/contact"})
public class ContactController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();
    private final ContactDAO contactDAO = new ContactDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();
        req.setAttribute("customizeInfo", customizeInfo);
        req.getRequestDispatcher("contact.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();
        String email = req.getParameter("email");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String message = req.getParameter("message");

        String emailError = "";
        String firstNameError = "";
        String lastNameError = "";
        String messageError = "";

        String success = "";
        boolean isValid = true;

        if (BlankInputUtil.isBlank(email)) {
            req.setAttribute("emailError", emailError);
            isValid = false;
        }
        if (BlankInputUtil.isBlank(firstName)) {
            req.setAttribute("emailError", firstNameError);
            isValid = false;
        }
        if (BlankInputUtil.isBlank(lastName)) {
            req.setAttribute("emailError", lastNameError);
            isValid = false;
        }
        if (BlankInputUtil.isBlank(message)) {
            req.setAttribute("emailError", messageError);
            isValid = false;
        }

        if (!isValid) {
            req.getRequestDispatcher("contact.jsp").forward(req, resp);
        }
        // Hợp lệ thì set thành công và forward về trang
        else {
            ContactBean contactBean=new ContactBean();
            contactBean.setEmail(email);
            contactBean.setFirstName(firstName);
            contactBean.setLastName(lastName);
            contactBean.setMessage(message);
            contactDAO.createContact(contactBean);

            req.setAttribute("success", success);
            req.setAttribute("customizeInfo", customizeInfo);
            req.getRequestDispatcher("contact.jsp").forward(req, resp);
        }
    }
}