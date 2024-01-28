package com.ltw.controller.admin.account;

import com.ltw.bean.AccountBean;
import com.ltw.bean.ProductBean;
import com.ltw.dao.AccountDAO;
import com.ltw.util.BlankInputUtil;
import com.ltw.util.NumberValidateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/admin/account-management/adding")

public class AccountAddingController {
    private final AccountDAO accountDAO = new AccountDAO();
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/admin/add-account.jsp").forward(req, resp);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String userName = req.getParameter("userName");
        String password = req.getParameter("password");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String roleId = req.getParameter("roleId");
        String email = req.getParameter("email");
        String addressLine = req.getParameter("addressLine");
        String addressWard = req.getParameter("addressWard");
        String addressDistrict = req.getParameter("addressDistrict");
        String verifiedCode = req.getParameter("verifiedCode");
        String status = req.getParameter("status");

        String success = "success";
        String[] inputsForm = new String[]{userName, password, firstName, lastName, roleId, email, addressLine, addressWard, addressDistrict, verifiedCode, status};
        ArrayList<String> errors = new ArrayList<>();
        // Biến bắt lỗi
        boolean isValid = true;

        for (String string : inputsForm) {
            if (BlankInputUtil.isBlank(string)) {
                errors.add("e");
                if (isValid) {
                    isValid = false;
                }
            } else {
                errors.add(null);
            }
        }
        req.setAttribute("errors", errors);

        // Nếu không lỗi thì lưu vào database
        if (isValid) {
            // Đổi String về số
            int roleIdInt = NumberValidateUtil.toInt(roleId);
            int statusInt = NumberValidateUtil.toInt(status);

            // Set thuộc tính vào bean
            AccountBean accountBean = new AccountBean();
            accountBean.setUserName(userName);
            accountBean.setPassword(password);
            accountBean.setFirstName(firstName);
            accountBean.setLastName(lastName);
            accountBean.setRoleId(roleIdInt);
            accountBean.setEmail(email);
            accountBean.setAddressLine(addressLine);
            accountBean.setAddressWard(addressWard);
            accountBean.setAddressDistrict(addressDistrict);
            accountBean.setVerifiedCode(verifiedCode);
            accountBean.setStatus(statusInt);

            accountDAO.createAccount(accountBean);
            resp.sendRedirect(req.getContextPath() + "/admin/account-management/adding?success=" + success);
        } else {
            req.getRequestDispatcher("/adding-account.jsp").forward(req, resp);
        }
    }
}
