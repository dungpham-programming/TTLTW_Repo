package com.ltw.controller;

import com.ltw.service.RegisterService;
import com.ltw.util.SendEmailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = {"/verification"})
public class VerifiedController extends HttpServlet {
    private final RegisterService registerService = new RegisterService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");
        String email = req.getParameter("email");
        int id = Integer.parseInt(req.getParameter("id"));
        if (type != null) {
            if (type.equals("resendCode")) {
                // Tạo verifiedCode mới
                String verifiedCode = registerService.generateVerifiedCode();
                // Gửi vào email cho người dùng
                SendEmailUtil.sendVerificationCode(email, verifiedCode);
                // Set vào database
                registerService.setNewVerifiedCode(id, verifiedCode);
                // Chuyển hướng người dùng
                resp.sendRedirect(req.getContextPath() + "/verified.jsp?id=" + id +"&email=" + email);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");
        int id = Integer.parseInt(req.getParameter("id"));
        String codeError = "";

        if (type != null) {
            if (type.equals("verified")) {
                String verifyInput = req.getParameter("verifyInput");

                // Kiểm tra các trường hợp nhập VerifieCode
                // Kiểm tra xem verify input có bị để trống không
                if (!registerService.isBlankVerification(verifyInput)) {
                    // Nếu không trống, kiểm tra xem có đủ 8 ký tự hay không
                    if (registerService.isCorrectLength(verifyInput)) {
                        // Nếu đủ, kiểm tra xem có khớp verify code không
                        if (registerService.isCorrectVerifiedCode(id, verifyInput)) {
                            // Nếu khớp, chuyển hướng về trang home và không thực hiện các bước phía dưới nữa (return;)
                            resp.sendRedirect(req.getContextPath() + "/home");
                            return;
                        }
                        // Nếu không khớp verified code, trả về lỗi
                        else {
                            codeError = "VerifiedCode không tồn tại";
                            req.setAttribute("codeError", codeError);
                        }
                    }
                    // Nếu khác số lượng ký tự, trả vè lỗi
                    else {
                        codeError = "VerifiedCode không hợp lệ, phải có 8 ký tự";
                        req.setAttribute("codeError", codeError);
                    }
                }
                // Nếu để trống, trả về lỗi
                else {
                    codeError = "VerifiedCode không được để trống";
                    req.setAttribute("codeError", codeError);
                }
                req.getRequestDispatcher("/verified.jsp?id=" + id).forward(req, resp);
            }
        }
    }
}
