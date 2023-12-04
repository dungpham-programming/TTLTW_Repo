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
                boolean availableRegister = true;

                String email = req.getParameter("email");
                String password = req.getParameter("password");
                String retypePassword = req.getParameter("retypePassword");

                // Tạo biến boolean lấy kết quả kiểm tra email từ database (Mục đích để không gọi xuống database quá nhiều lần).
                boolean isExistEmail = registerService.isExistEmail(email);

                // Các trường hợp không thành công thì thông báo lỗi
                // Kiểm tra xem Email có bị bỏ trống hay không
                if (!registerService.isBlankEmail(email)) {
                    // Nếu không bị bỏ trống, kiểm tra xem email có hợp lệ không
                    if (registerService.isValidEmail(email)) {
                        // Nếu hợp lệ, kiểm tra xem email có tồn tại trong database không
                        if (isExistEmail) {
                            // Tồn tại thì trả về lỗi và set vào request
                            emailError = "Email này đã tồn tại!";
                            req.setAttribute("emailError", emailError);
                            availableRegister = false;
                        }
                        // Không tồn tại lỗi gì thì xuống điều kiện khác
                    }
                    // Nếu không hợp lệ, trả về lỗi
                    else {
                        emailError = "Email không hợp lệ!";
                        req.setAttribute("emailError", emailError);
                        availableRegister = false;
                    }
                }
                // Nếu bị bỏ trống, trả vè lỗi
                else {
                    emailError = "Email không được để trống!";
                    req.setAttribute("emailError", emailError);
                    availableRegister = false;
                }

                // Kiểm tra xem trường Mật khẩu và Nhập lại mật khẩu có bị để trống
                if (!registerService.isBlankPassword(password, retypePassword)) {
                    // Nếu không bị bỏ trống, kiểm tra xem 2 trường này có trùng khớp hay không
                    // Nếu không trùng thì trả về lỗi
                    if (!registerService.isSamePassword(password, retypePassword)) {
                        passwordError = "Mật khẩu và Nhập lại mật khẩu không khớp";
                        req.setAttribute("passwordError", passwordError);
                        availableRegister = false;
                    }
                }
                // Nếu bị bỏ trống, trả về lỗi
                else {
                    passwordError = "Mật khẩu hoặc Nhập lại mật khẩu không được để trống";
                    req.setAttribute("passwordError", passwordError);
                    availableRegister = false;
                }

                // Nếu lỗi mật khẩu hoặc tài khoản, forward lại signup.jsp và báo lỗi
                if (!availableRegister) {
                    req.getRequestDispatcher("/signup.jsp").forward(req, resp);
                }
                // Nếu không, chuyển hướng về trang chủ
                else {
                    resp.sendRedirect("client-home.jsp");
                }
            }
        }
    }
}
