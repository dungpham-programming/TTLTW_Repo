package com.ltw.controller.signin_signup_forget;

import com.ltw.service.LinkVerifyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// TODO: Làm thêm phần hết hạn cho verify code
@WebServlet(value = {"/link-verification"})
public class LinkVerifyController extends HttpServlet {
    private final LinkVerifyService linkVerifyService = new LinkVerifyService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if (action != null) {
            if (action.equals("verify")) {
                String email = req.getParameter("email");
                String verifyCode = req.getParameter("verifyCode");
                if (linkVerifyService.isCorrectVerifiedCode(email, verifyCode)) {
                    linkVerifyService.setEmptyCode(email);
                    resp.sendRedirect("change-password.jsp?email=" + email);
                }
                else {
                    resp.sendRedirect("error-verify.jsp");
                }
            }
        }
    }
}
