package com.ltw.controller;

import com.ltw.bean.UserBean;
import com.ltw.dao.UserDAO;
import com.ltw.service.SigninService;
import com.ltw.util.SendEmailUtil;
import com.ltw.util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = {"/signin"})
public class SigninController extends HttpServlet {
    private final SigninService signinService = new SigninService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    // TODO: Hashing password + Hiển thị lỗi lên JSP
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String emailError = null;
        String password = req.getParameter("password");

        // Kiểm tra các trường hợp email
        // Nếu email không để trống thì tiếp tục
        if (!signinService.isBlankEmail(email)) {
            // Nếu email không sai cú pháp thì tiếp tục
            if (signinService.isValidEmail(email)) {
                // Nếu email đã tồn tại trong database thì tiếp tục
                if (signinService.isExistEmail(email)) {
                    // Nếu email và password không trùng khớp với database, trả về lỗi
                    if (!signinService.isValidLogin(email, password)) {
                        emailError = "Email hoặc mật khẩu không đúng!";
                        req.setAttribute("emailError", emailError);
                    }
                } else {
                    // Nếu email chưa tồn tại, thông báo email không tồn tại
                    emailError = "Email không tồn tại!";
                    req.setAttribute("emailError", emailError);
                }
            } else {
                // Nếu email sai cú pháp, trả về lỗi cú pháp
                emailError = "Email không hợp lệ!";
                req.setAttribute("emailError", emailError);
            }
        } else {
            // Nếu email để trống, trả về lỗi để trống
            emailError = "Email không được để trống!";
            req.setAttribute("emailError", emailError);
        }

        // Nếu có lỗi (emailError != null) thì forward lại trang signin.jsp và thông báo lỗi
        if (emailError != null) {
            req.getRequestDispatcher("signin.jsp").forward(req, resp);
        } else {
            // Nếu không có lỗi gì, kiểm tra xem tài khoản đã active chưa
            // Nếu đã active thì tạo ra một Session và redirect người dùng về trang home
            if (signinService.isActive(email)) {
                UserBean user = signinService.findUserByEmail(email);
                if (user != null) {
                    SessionUtil.getInstance().putValue(req, "user", user);
                    resp.sendRedirect(req.getContextPath() + "/home");
                }
            } else {
                // Nếu chưa active thì tạo ra verifiedCode mới, gửi về email người dùng và redirect sang trang verified
                int id = signinService.findIdByEmail(email);
                String verifiedCode = signinService.generateVerifiedCode();
                SendEmailUtil.sendVerificationCode(email, verifiedCode);
                resp.sendRedirect(req.getContextPath() + "/verified.jsp?id=" + id + "&email=" + email);
            }
        }
    }
}

