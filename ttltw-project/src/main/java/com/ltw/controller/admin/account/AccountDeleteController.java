package com.ltw.controller.admin.account;
import com.ltw.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/account-management/delete")
public class AccountDeleteController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int affectedRows = userDAO.deleteAccount(id);

        if (affectedRows > 0) {
            response.sendRedirect(request.getContextPath() + "/admin/account-management?success=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/account-management?error=true");
        }
    }
}
