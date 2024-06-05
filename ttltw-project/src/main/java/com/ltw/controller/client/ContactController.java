package com.ltw.controller.client;

import com.ltw.bean.ContactBean;
import com.ltw.bean.CustomizeBean;
import com.ltw.bean.UserBean;
import com.ltw.dao.ContactDAO;
import com.ltw.dao.CustomizeDAO;
import com.ltw.dto.LogAddressDTO;
import com.ltw.service.LogService;
import com.ltw.util.BlankInputUtil;
import com.ltw.util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ResourceBundle;

@WebServlet(value = {"/contact"})
public class ContactController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();
    private final ContactDAO contactDAO = new ContactDAO();
    private LogService<ContactDAO> logService = new LogService<>();
    private ResourceBundle logBundle = ResourceBundle.getBundle("log-content");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();
        req.setAttribute("customizeInfo", customizeInfo);
        req.getRequestDispatcher("contact.jsp").forward(req, resp);
    }

    // TODO: Chưa gọi xuống DAO để lưu vào CSDL
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

            int id = contactDAO.createContact(contactBean);

            UserBean modifyUser = (UserBean) SessionUtil.getInstance().getValue(req, "user");
            LogAddressDTO address = new LogAddressDTO("user-contact", modifyUser.getId(), logBundle.getString("user-contact-success"));
            logService.createLog(req.getRemoteAddr(), "", "ALERT", address, null, contactDAO.findContactById(id));

            req.setAttribute("success", success);
            req.setAttribute("customizeInfo", customizeInfo);
            req.getRequestDispatcher("contact.jsp").forward(req, resp);
        }
    }
}