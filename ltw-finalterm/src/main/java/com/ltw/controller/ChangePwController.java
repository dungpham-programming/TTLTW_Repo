package com.ltw.controller;

import com.ltw.service.ForgetService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// TODO: Mã hóa mật khẩu
@WebServlet(value = {"/change-password"})
public class ChangePwController extends HttpServlet {
    private final ForgetService forgetService = new ForgetService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        String newPassword = req.getParameter("newPassword");
        String retypePassword = req.getParameter("retypePassword");

        String newPasswordInputErr = null;
        String retypePasswordInputErr = null;
        String newPasswordSpaceErr = null;
        String retypePasswordSpaceErr = null;

        boolean isValid = true;

        if (!forgetService.isBlankInput(newPassword) || !forgetService.isBlankInput(retypePassword)) {
            if (!forgetService.containsSpace(newPassword) || !forgetService.containsSpace(retypePassword)) {
                if (forgetService.isLengthEnough(newPassword)) {
                    if (newPassword.equals(retypePassword)) {
                        forgetService.saveRenewPasswordByEmail(email, newPassword);
                        resp.sendRedirect(req.getContextPath() + "/change-success.jsp");
                    } else {
                        newPasswordInputErr = "Mật khẩu và Nhập lại mật khẩu không đúng!";
                        retypePasswordInputErr = "Mật khẩu và Nhập lại mật khẩu không đúng!";
                        req.setAttribute("newPasswordInputErr", newPasswordInputErr);
                        req.setAttribute("retypePasswordInputErr", retypePasswordInputErr);
                        isValid = false;
                    }
                } else {
                    newPasswordInputErr = "Mật khẩu chứa ít nhất 6 ký tự!";
                    req.setAttribute("newPasswordInputErr", newPasswordInputErr);
                }
            } else {
                if (forgetService.containsSpace(newPassword)) {
                    newPasswordSpaceErr = "Mật khẩu không được chứa ô trống!";
                    req.setAttribute("newPasswordSpaceErr", newPasswordSpaceErr);
                }
                if (forgetService.containsSpace(retypePassword)) {
                    retypePasswordSpaceErr = "Mật khẩu không được chứa ô trống!";
                    req.setAttribute("retypePasswordSpaceErr", retypePasswordSpaceErr);
                }
                isValid = false;
            }
        } else {
            if (forgetService.isBlankInput(newPassword)) {
                newPasswordInputErr = "Mật khẩu không được để trống!";
                req.setAttribute("newPasswordInputErr", newPasswordInputErr);
            }
            if (forgetService.isBlankInput(retypePassword)) {
                retypePasswordInputErr = "Mật khẩu không được để trống!";
                req.setAttribute("retypePasswordInputErr", retypePasswordInputErr);
            }
            isValid = false;
        }

        if (!isValid) {
            req.getRequestDispatcher("change-password.jsp").forward(req, resp);
        }
    }
}
