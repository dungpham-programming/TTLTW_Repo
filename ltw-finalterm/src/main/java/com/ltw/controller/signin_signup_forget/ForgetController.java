package com.ltw.controller.signin_signup_forget;

import com.ltw.service.ForgetService;
import com.ltw.util.SendEmailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

// TODO: Thực hiện kiểm tra xem liệu tài khoản đó đã được active hay chưa
@WebServlet(value = {"/forget"})
public class ForgetController extends HttpServlet {
    private final ForgetService forgetService = new ForgetService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action != null) {
            if (action.equals("resend")) {
                String email = req.getParameter("email");
                UUID uuid = UUID.randomUUID();
                String verifiedCode = uuid.toString();
                forgetService.saveNewCodeByEmail(email, verifiedCode);
                String verifiedLink = "http://" + req.getServerName() + ":" + req.getLocalPort() + req.getContextPath() + "/forget-verify?email=" + email + "&verifyCode=" + verifiedCode + "&action=verify";
                SendEmailUtil.sendVerificationLink(email, verifiedLink);
                resp.sendRedirect(req.getContextPath() + "/checking-forget.jsp?email=" + email);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        String emailError = null;

        // Validate các trường hợp nhập email
        // Nếu email không bị bỏ trống thì tiếp tục
        if (!forgetService.isBlankInput(email)) {
            // Nếu email đúng cú pháp thì tiếp tục
            if (forgetService.isValidEmail(email)) {
                // Nếu email có tồn tại trong database thì tiếp tục
                if (forgetService.isExistEmail(email)) {
                    // Nếu tài khoản của email đã được active (status = 1) thì gửi verify code về database
                    // sau đó tạo 1 verify link và gửi về mail cho người dùng
                    if (forgetService.isActiveAccount(email)) {
                        UUID uuid = UUID.randomUUID();
                        String verifiedCode = uuid.toString();
                        forgetService.saveNewCodeByEmail(email, verifiedCode);
                        String verifiedLink = "http://" + req.getServerName() + ":" + req.getLocalPort() + req.getContextPath() + "/forget-verify?email=" + email + "&verifyCode=" + verifiedCode + "&action=verify";
                        SendEmailUtil.sendVerificationLink(email, verifiedLink);
                        resp.sendRedirect(req.getContextPath() + "/checking-forget.jsp?email=" + email);
                    } else {
                        // Nếu tài khoản chưa active thì lấy email truyền vào URL rồi sendRedirect
                        // sang trang verified.jsp
                        resp.sendRedirect(req.getContextPath() + "/verified.jsp?email=" + email);
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

        // Nếu có tồn tại lỗi, forward lại về trang và báo lỗi
        if (emailError != null) {
            req.getRequestDispatcher("forget.jsp").forward(req, resp);
        }
    }
}
