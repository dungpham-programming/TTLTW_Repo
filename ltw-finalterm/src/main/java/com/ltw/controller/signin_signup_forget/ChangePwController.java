package com.ltw.controller.signin_signup_forget;

import com.ltw.service.LinkVerifyService;
import com.ltw.util.EncryptPasswordUtil;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// TODO: Mã hóa mật khẩu
@WebServlet(value = {"/change-password"})
public class ChangePwController extends HttpServlet {
    private final LinkVerifyService linkVerifyService = new LinkVerifyService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        String key = req.getParameter("key");
        String newPassword = req.getParameter("newPassword");
        String retypePassword = req.getParameter("retypePassword");

        String newPasswordInputErr = null;
        String retypePasswordInputErr = null;
        String newPasswordSpaceErr = null;
        String retypePasswordSpaceErr = null;
        String linkError = null;

        boolean isValid = true;

        if (!linkVerifyService.isBlankInput(newPassword) || !linkVerifyService.isBlankInput(retypePassword)) {
            if (!linkVerifyService.containsSpace(newPassword) || !linkVerifyService.containsSpace(retypePassword)) {
                if (linkVerifyService.isLengthEnough(newPassword)) {
                    if (!newPassword.equals(retypePassword)) {
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
                if (linkVerifyService.containsSpace(newPassword)) {
                    newPasswordSpaceErr = "Mật khẩu không được chứa ô trống!";
                    req.setAttribute("newPasswordSpaceErr", newPasswordSpaceErr);
                }
                if (linkVerifyService.containsSpace(retypePassword)) {
                    retypePasswordSpaceErr = "Mật khẩu không được chứa ô trống!";
                    req.setAttribute("retypePasswordSpaceErr", retypePasswordSpaceErr);
                }
                isValid = false;
            }
        } else {
            if (linkVerifyService.isBlankInput(newPassword)) {
                newPasswordInputErr = "Mật khẩu không được để trống!";
                req.setAttribute("newPasswordInputErr", newPasswordInputErr);
            }
            if (linkVerifyService.isBlankInput(retypePassword)) {
                retypePasswordInputErr = "Mật khẩu không được để trống!";
                req.setAttribute("retypePasswordInputErr", retypePasswordInputErr);
            }
            isValid = false;
        }

        if (!isValid) {
            req.getRequestDispatcher("change-password.jsp").forward(req, resp);
        } else {
            // TODO: Xử lý link error
            // Kiểm tra xem key có khớp không, nếu key null, rỗng hoặc không khớp thì báo lỗi link
            if (key == null || key.isEmpty() || !linkVerifyService.isCorrectKey(email, key)) {
                linkError = "e";
                req.setAttribute("linkError", linkError);
                req.getRequestDispatcher("change-password.jsp").forward(req, resp);
            } else {
                // Xử lý hashing password trong Service
                linkVerifyService.saveRenewPasswordByEmail(email, newPassword);
                linkVerifyService.setEmptyKey(email);
                resp.sendRedirect(req.getContextPath() + "/change-success.jsp");
            }
        }
    }
}
