package com.ltw.controller.admin.account;

import com.ltw.bean.UserBean;
import com.ltw.dao.UserDAO;
import com.ltw.dto.LogAddressDTO;
import com.ltw.service.LogService;
import com.ltw.util.EncryptPasswordUtil;
import com.ltw.util.NumberValidateUtil;
import com.ltw.util.SessionUtil;
import com.ltw.util.ValidateParamUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.ResourceBundle;

@WebServlet("/admin/account-management/adding")
public class AccountAddingController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();
    private LogService<UserBean> logService = new LogService<>();
    private ResourceBundle logBundle = ResourceBundle.getBundle("log-content");

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/adding-account.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String password = req.getParameter("password");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String roleId = req.getParameter("roleId");
        String email = req.getParameter("email");
        String addressLine = req.getParameter("addressLine");
        String addressWard = req.getParameter("addressWard");
        String addressDistrict = req.getParameter("addressDistrict");
        String addressProvince = req.getParameter("addressProvince");
        String status = req.getParameter("status");

        String success = "success";
        String[] inputsForm = {email, password, firstName, lastName, roleId, status, addressLine, addressWard, addressDistrict, addressProvince};
        // Biến bắt lỗi
        boolean isValid = true;

        // Kiểm tra input rỗng/null trong hàm checkEmptyParam
        List<String> errors = ValidateParamUtil.checkEmptyParam(inputsForm);

        // Nếu có lỗi (khác null) trả về isValid = false
        for (String error : errors) {
            if (error != null) {
                isValid = false;
                break;
            }
        }

        // Nếu không lỗi thì lưu vào database
        if (isValid) {
            // Đổi String về số
            int roleIdInt = NumberValidateUtil.toInt(roleId);
            int statusInt = NumberValidateUtil.toInt(status);

            // Set thuộc tính vào bean
            UserBean userBean = new UserBean();
            userBean.setEmail(email);
            userBean.setPassword(EncryptPasswordUtil.encryptPassword(password));
            userBean.setFirstName(firstName);
            userBean.setLastName(lastName);
            userBean.setRoleId(roleIdInt);
            userBean.setStatus(statusInt);
            userBean.setAddressLine(addressLine);
            userBean.setAddressWard(addressWard);
            userBean.setAddressDistrict(addressDistrict);
            userBean.setAddressProvince(addressProvince);

            userDAO.createAccount(userBean);

            // Ghi log khi thành công
            // Lấy ra người thực hiện thay đổi từ Session
            UserBean modifyUser = (UserBean) SessionUtil.getInstance().getValue(req, "user");
            LogAddressDTO addressObj = new LogAddressDTO("admin-create-account", modifyUser.getId(), logBundle.getString("admin-create-account-success"));
            UserBean currentObj = userDAO.findUserByEmail(email);
            logService.createLog(req.getRemoteAddr(), "", "ALERT", addressObj, null, currentObj);

            resp.sendRedirect(req.getContextPath() + "/admin/account-management/adding?success=" + success);
        } else {
            req.setAttribute("errors", errors);
            // Ghi log khi thất bại
            UserBean modifyUser = (UserBean) SessionUtil.getInstance().getValue(req, "user");
            LogAddressDTO addressObj = new LogAddressDTO("admin-create-account", modifyUser.getId(), logBundle.getString("admin-create-account-fail"));
            logService.createLog(req.getRemoteAddr(), "", "ALERT", addressObj, null, null);

            req.getRequestDispatcher("/adding-account.jsp").forward(req, resp);
        }
    }
}
