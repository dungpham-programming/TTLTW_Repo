package com.ltw.controller.admin.account;

import com.ltw.bean.UserBean;
import com.ltw.dao.UserDAO;
import com.ltw.dto.LogAddressDTO;
import com.ltw.service.LogService;
import com.ltw.util.NumberValidateUtil;
import com.ltw.util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ResourceBundle;

@WebServlet("/admin/account-management/editing")
public class AccountEditingController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();
    private LogService<UserBean> logService = new LogService<>();
    private ResourceBundle logBundle = ResourceBundle.getBundle("log-content");

    // Todo: Cần chỉnh sửa lại logic cho thêm người dùng
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

        // Trước khi thay đổi
        UserBean prevObj = userDAO.findUserById(id);

        // Set thuộc tính vào bean
        UserBean userBean = new UserBean();
        userBean.setId(id);
        userBean.setStatus(statusInt);
        userBean.setRoleId(roleIdInt);
        userDAO.updateAccountForAdmin(userBean);

        // Ghi log khi thành công
        // Lấy ra người thực hiện thay đổi từ Session
        UserBean modifyUser = (UserBean) SessionUtil.getInstance().getValue(req, "user");
        LogAddressDTO addressObj = new LogAddressDTO("admin-create-account", modifyUser.getId(), logBundle.getString("admin-update-account-success"));
        UserBean currentObj = userDAO.findUserById(id);
        logService.createLog(req.getRemoteAddr(), "", "ALERT", addressObj, prevObj, currentObj);
        resp.sendRedirect(req.getContextPath() + "/admin/account-management/editing?id=" + userBean.getId() + "&success=" + success);
    }
}