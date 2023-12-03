package com.ltw.controller.client;

import com.ltw.service.RegisterService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = {"/register"})
public class RegisterController extends HttpServlet {
    private final RegisterService registerService = new RegisterService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("signup.jsp").forward(req, resp);
    }

    @Override

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String type = req.getParameter("type");
        int id = 0;

        // Nếu có parameter đăng ký tài khoản được gửi về
        if (type != null) {
            if (type.equals("sendRegister")) {
                String emailError = "";
                String passwordError = "";

                String email = req.getParameter("email");
                String password = req.getParameter("password");
                String retypePassword = req.getParameter("retypePassword");

                // Tạo biến boolean lấy kết quả kiểm tra email từ database (Mục đích để không gọi xuống database quá nhiều lần).
                boolean isExistEmail = registerService.isExistEmail(email);
            }
        }
    }
}
