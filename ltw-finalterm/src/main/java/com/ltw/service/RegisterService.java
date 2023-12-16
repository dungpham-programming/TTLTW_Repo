package com.ltw.service;

import com.ltw.bean.UserBean;
import com.ltw.dao.UserDAO;

import java.util.List;
import java.util.Random;

public class RegisterService {
    private final UserDAO userDAO = new UserDAO();

    // Service thêm một user vào trong database
    public int register(UserBean user) {
        return userDAO.createInRegister(user);
    }

    public void setNewVerifiedCode(int id, String verifiedCode) {
        userDAO.setNewVerifiedCode(id, verifiedCode);
    }

    // Service kiểm tra xem Email có để trống không
    public boolean isBlankEmail(String email) {
        return email == null || email.isEmpty();
    }

    // Service Kiểm tra tính hợp lệ của email
    public boolean isValidEmail(String email) {
        return true;
    }

    // Service kiểm tra xem trong database đã tồn tại email được truyền vào hay chưa
    public boolean isExistEmail(String email) {
        // Nếu để trống thì trả luôn về false
        if (isBlankEmail(email)) {
            return false;
        }
        List<Integer> userByEmail = userDAO.findIdByEmail(email);
        return !userByEmail.isEmpty();
    }

    // Service kiểm tra xem Mật khẩu và Nhập lại mật khẩu có bị trống không
    public boolean isBlankPassword(String password, String retypePassword) {
        return (password == null || password.isEmpty()) || (retypePassword == null || retypePassword.isEmpty());
    }
    public boolean isSamePassword(String password, String retypePassword) {
        if (isBlankPassword(password, retypePassword)) {
            return false;
        }
        return password.equals(retypePassword);
    }

    public String generateVerifiedCode() {
        int codeLength = 8;
        String characters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        Random random = new Random();
        StringBuilder verifiedCode = new StringBuilder();

        for (int i = 0; i < codeLength; i++) {
            // Lấy ngẫu nhiên 1 ký tự trong dãy characters
            char randomCharacter = characters.charAt(random.nextInt(characters.length()));
            verifiedCode.append(randomCharacter);
        }
        return verifiedCode.toString();
    }

    // Service kiểm tra xem verify input có để trống không
    public boolean isBlankVerification(String verifyInput) {
        return (verifyInput == null || verifyInput.isEmpty());
    }

    // Service kiểm tra xem verify input có đủ 8 ký tự không
    public boolean isCorrectLength(String verifyInput) {
        if (verifyInput == null || verifyInput.isEmpty()) {
            return false;
        }
        return verifyInput.length() == 8;
    }

    // Service kiểm tra verifiedCode
    public boolean isCorrectVerifiedCode(int id, String verifiedCode) {
        boolean check = false;
        int idQuery = userDAO.checkVerifiedCode(verifiedCode);
        // Nếu tìm thấy verifiedCode và id query được trùng với id được gửi từ Servlet về
        // => Trả vè true và set verifiedCode = "" (Không sợ người dùng gửi "" về vì đã validate).
        if (id == idQuery) {
            userDAO.setEmptyCodeAndActive(id);
            check = true;
        }
        else {
            check = false;
        }
        return check;
    }
}
