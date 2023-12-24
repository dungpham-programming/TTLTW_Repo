package com.ltw.controller.signin_signup_forget;

import com.ltw.service.ForgetService;
import com.ltw.util.SendEmailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// TODO: Làm thêm phần hết hạn cho verify code
@WebServlet(value = {"/forget-verify"})
public class ForgetVerifyController extends HttpServlet {
    private final ForgetService forgetService = new ForgetService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if (action != null) {
            if (action.equals("verify")) {
                String email = req.getParameter("email");
                String verifyCode = req.getParameter("verifyCode");
                if (forgetService.isCorrectVerifiedCode(email, verifyCode)) {
                    forgetService.setEmptyCode(email);
                    resp.sendRedirect("change-password.jsp?email=" + email);
                }
                else {
                    resp.sendRedirect("error-verify.jsp");
                }
            }
        }
    }
}
