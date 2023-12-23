package com.ltw.controller;

import com.ltw.bean.UserBean;
import com.ltw.service.RegisterService;
import com.ltw.util.SendEmailUtil;

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
                boolean isValid = true;

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
                            isValid  = false;
                        }
                        // Không tồn tại lỗi gì thì xuống điều kiện khác
                    }
                    // Nếu không hợp lệ, trả về lỗi
                    else {
                        emailError = "Email không hợp lệ!";
                        req.setAttribute("emailError", emailError);
                        isValid  = false;
                    }
                }
                // Nếu bị bỏ trống, trả vè lỗi
                else {
                    emailError = "Email không được để trống!";
                    req.setAttribute("emailError", emailError);
                    isValid  = false;
                }

                // Kiểm tra xem trường Mật khẩu và Nhập lại mật khẩu có bị để trống
                if (!registerService.isBlankPassword(password, retypePassword)) {
                    // Nếu không bị bỏ trống, kiểm tra xem 2 trường này có trùng khớp hay không
                    // Nếu không trùng thì trả về lỗi
                    if (!registerService.containsSpace(password) || !registerService.containsSpace(retypePassword)) {
                        if (registerService.isLengthEnough(password)) {
                            if (!registerService.isSamePassword(password, retypePassword)) {
                                passwordError = "Mật khẩu và Nhập lại mật khẩu không khớp";
                                req.setAttribute("passwordError", passwordError);
                                isValid  = false;
                            }
                        }
                        else {
                            passwordError = "Mật khẩu phải có 6 ký tự trở lên";
                            req.setAttribute("passwordError", passwordError);
                            isValid  = false;
                        }
                    }
                    else {
                        passwordError = "Mật khẩu không được chứa khoảng trắng";
                        req.setAttribute("passwordError", passwordError);
                        isValid  = false;
                    }
                }
                // Nếu bị bỏ trống, trả về lỗi
                else {
                    passwordError = "Mật khẩu hoặc Nhập lại mật khẩu không được để trống";
                    req.setAttribute("passwordError", passwordError);
                    isValid  = false;
                }

                // Kiểm tra password và retypePassword trước khi binding xuống Bean
                // Nếu thành công thì binding dữ liệu vào Bean rồi gửi về Service, sau đó gọi phương thức tạo mã ngẫu nhiên và set vào verifiedCode
                if (isValid) {
                    UserBean user = new UserBean();
                    String verifiedCode = registerService.generateVerifiedCode();
                    user.setEmail(email);
                    user.setPassword(password);
                    user.setVerifiedCode(verifiedCode);

                    // Gửi verifiedCode về Email
                    SendEmailUtil.sendVerificationCode(email, verifiedCode);

                    // Gửi kèm id để có thể truyền param khi thực hiện lấy verifiedCode lên để so sánh
                    id = registerService.register(user);
                    resp.sendRedirect(req.getContextPath() + "/verified.jsp?id=" + id + "&email=" + email);
                } else {
                    // Nếu không thành công, link sẽ được redirect cùng với lỗi
                    req.getRequestDispatcher("signup.jsp").forward(req, resp);
                }
            }
        }
    }
}
