package com.ltw.controller;

import com.ltw.service.ForgetService;
import com.ltw.util.SendEmailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = {"/forget-verify"})
public class ForgetVerifyController extends HttpServlet {
    private final ForgetService forgetService = new ForgetService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");
        String email = req.getParameter("email");
        if (type != null) {
            if (type.equals("resendCode")) {
                // Tạo verifiedCode mới
                String verifiedCode = forgetService.generateVerifiedCode();
                // Lưu email vào database và gửi về email cho người dùng
                forgetService.saveNewCodeByEmail(email, verifiedCode);
                SendEmailUtil.sendVerificationCode(email, verifiedCode);
                // Chuyển hướng và báo cho người dùng rằng code đã được gửi
                String confirm = "confirm";
                resp.sendRedirect(req.getContextPath() + "/checking-forget.jsp?email=" + email + "&confirm=" + confirm);
            }
        }
    }

    // TODO: Sau khi merge nhánh, sendRedirect về trang
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String code = req.getParameter("code");
        String codeError = null;

        if (!forgetService.isBlankInput(code)) {
            if (forgetService.isCorrectLength(code)) {
                if (forgetService.isCorrectVerifiedCode(email, code)) {
                    forgetService.setEmptyCode(email);
                    resp.sendRedirect(req.getContextPath() + "/home");
                } else {
                    codeError = "Verify code không hợp lệ!";
                    req.setAttribute("codeError", codeError);
                }
            } else {
                codeError = "Verify code phải có đúng 8 ký tự!";
                req.setAttribute("codeError", codeError);
            }
        } else {
            codeError = "Verify code không được để trống!";
            req.setAttribute("codeError", codeError);
        }

        if (codeError != null) {
            req.getRequestDispatcher("/checking-forget.jsp").forward(req, resp);
        }
    }
}
