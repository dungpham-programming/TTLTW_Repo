package com.ltw.controller.admin.account;


import com.ltw.bean.UserBean;
import com.ltw.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/account-management/deleting")
public class AccountDeletingController {
    private final UserDAO userDAO = new UserDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        // Lấy ra UserBean từ session để lấy
        int id = Integer.parseInt(req.getParameter("id"));
        int affectedRows = userDAO.deleteAccount(id);
        if (affectedRows > 0) {
            req.setAttribute("success", "Xóa sản phẩm thành công!");
        } else if (affectedRows == -1) {
            req.setAttribute("error", "Lỗi hệ thống!");
        } else if (affectedRows == 0){
            req.setAttribute("error", "Sản phẩm không tồn tại!");
        }
        // Lấy danh sách sản phẩm lên để cập nhật hiển thị trên view
        List<UserBean> listAccount = userDAO.findAllAccounts();
        req.setAttribute("listAccount", listAccount);
        req.getRequestDispatcher("/account-management.jsp").forward(req, resp);
    }
}
