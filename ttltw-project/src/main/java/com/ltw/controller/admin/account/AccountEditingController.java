package com.ltw.controller.admin.account;

import com.ltw.bean.UserBean;
import com.ltw.dao.UserDAO;
import com.ltw.util.NumberValidateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/account-management/editing")
public class AccountEditingController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        UserBean userBean = userDAO.findUserById(id);
        request.setAttribute("accountBean", userBean);
        request.getRequestDispatcher("/editing-account.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        // Sử dụng vòng lặp để set lỗi để trống theo index,
        // tuy nhiên cần phải giữ đúng thứ tự của input theo form và theo database (Vì sử dụng vòng lặp theo i để set lỗi)
        String idStr = req.getParameter("id");
        // Lấy id kiểu int ra để lưu vào database
        int id = Integer.parseInt(idStr);

        String roleId = req.getParameter("roleId");
        String status = req.getParameter("status");

        // Biến thông báo thành công
        String success = "success";
        // Đổi String về số
        int roleIdInt = NumberValidateUtil.toInt(roleId);
        int statusInt = NumberValidateUtil.toInt(status);

        // Set thuộc tính vào bean
        UserBean userBean = new UserBean();
        userBean.setId(id);
        userBean.setStatus(statusInt);
        userBean.setRoleId(roleIdInt);
        userDAO.updateAccountForAdmin(userBean);
        resp.sendRedirect(req.getContextPath() + "/admin/account-management/editing?id=" + userBean.getId() + "&success=" + success);
    }
}