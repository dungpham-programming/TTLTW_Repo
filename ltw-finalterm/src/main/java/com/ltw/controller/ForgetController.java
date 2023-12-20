package com.ltw.controller;

import com.ltw.service.ForgetService;
import com.ltw.util.SendEmailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// TODO: Làm nốt vệc validate email, xác thực quên mật khẩu và xác thực tài khoản
@WebServlet(value = {"/forget"})
public class ForgetController extends HttpServlet {
    private final ForgetService forgetService = new ForgetService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String emailError = null;

        // Validate các trường hợp nhập email
        // Nếu email không bị bỏ trống thì tiếp tục
        if (!forgetService.isBlankEmail(email)) {
            // Nếu email đúng cú pháp thì tiếp tục
            if (forgetService.isValidEmail(email)) {
                // Nếu email có tồn tại trong database thì tiếp tục
                if (forgetService.isExistEmail(email)) {
                    // Nếu tài khoản của email đã được active (status = 1) thì gửi verify code
                    // và sendRedirect sang trang checkingforget.jsp cùng với tham số id và email trên URL
                    if (forgetService.isActiveAccount(email)) {
                        String verifiedCode = forgetService.generateVerifiedCode();
                        forgetService.saveNewCodeByEmail(email, verifiedCode);
                        SendEmailUtil.sendVerificationCode(email, verifiedCode);
                        resp.sendRedirect(req.getContextPath() + "/checkingforget.jsp?email=" + email);
                        // return; sau khi sendRedirect (sendRedirect là đã gửi đi một request mới)
                        return;
                    } else {
                        // Nếu tài khoản chưa active thì lấy id và email truyền vào URL rồi sendRedirect
                        // sang trang verified.jsp
                        int id = forgetService.findIdByEmail(email);
                        resp.sendRedirect(req.getContextPath() + "verified.jsp?email=" + email);
                        return;
                    }
                } else {
                    // Nếu email không tồn tại, trả về lỗi
                    emailError = "Email không tồn tại!";
                    req.setAttribute("emailError", emailError);
                }
            } else {
                // Nếu email không hợp lệ, trả về lỗi
                emailError = "Email không hợp lệ!";
                req.setAttribute("emailError", emailError);
            }
        } else {
            // Nếu email để trống, trả về lỗi
            emailError = "Email không được để trống";
            req.setAttribute("emailError", emailError);
        }

        // Sau khi đã thêm lỗi vào request, forward lại về trang forget.jsp
        req.getRequestDispatcher("forget.jsp").forward(req, resp);
    }
}
