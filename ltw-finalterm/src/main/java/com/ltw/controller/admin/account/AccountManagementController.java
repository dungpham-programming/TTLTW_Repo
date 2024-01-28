package com.ltw.controller.admin.account;

import com.ltw.bean.AccountBean;
import com.ltw.dao.AccountDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/account-management")
public class AccountManagementController extends HttpServlet {
    private final AccountDAO accountDAO = new AccountDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<AccountBean> accounts = AccountDAO.findAllAccounts();
        request.setAttribute("accounts", accounts);
        request.getRequestDispatcher("/admin/account-management.jsp").forward(request, response);
    }
}
