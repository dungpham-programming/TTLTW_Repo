package com.ltw.controller;

import com.ltw.service.ForgetService;
import com.ltw.util.SendEmailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// TODO: Có thể không cần lấy id từ param mà khi lưu code vào bằng email đã mặc định trả về id
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
                resp.sendRedirect(req.getContextPath() + "/checkingforget.jsp" + "&email=" + email + "&confirm=" + confirm);
            }
        }
    }
}
