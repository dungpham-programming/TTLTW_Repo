package com.ltw.service;

import com.ltw.dao.UserDAO;

import java.util.List;
import java.util.Random;

public class ForgetService {
    private final UserDAO userDAO = new UserDAO();

    // Service lưu verifiedCode xuống database
    public void saveNewCodeByEmail(String email, String verifiedCode) {
        userDAO.saveNewCodeByEmail(email, verifiedCode);
    }

    // Service tìm id theo email
    public int findIdByEmail(String email) {
        return userDAO.findIdByEmail(email);
    }

    // Service kiểm tra xem Email có để trống không
    public boolean isBlankInput(String input) {
        return input == null || input.trim().isEmpty();
    }

    // Service Kiểm tra tính hợp lệ của email
    public boolean isValidEmail(String email) {
        return true;
    }

    // Service kiểm tra xem trong database đã tồn tại email được truyền vào hay chưa
    public boolean isExistEmail(String email) {
        // Nếu để trống thì trả luôn về false
        if (isBlankInput(email)) {
            return false;
        }
        int id = userDAO.findIdByEmail(email);
        return id != -1;
    }

    // Service kiểm tra xem tài khoản đã được active (status = 1) hay chưa
    public boolean isActiveAccount(String email) {
        return userDAO.isActiveAccount(email);
    }

    // Service tạo ra verifiedCode
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

    // Service kiểm tra xem verify input có đủ 8 ký tự không
    public boolean isCorrectLength(String verifyInput) {
        if (isBlankInput(verifyInput)) {
            return false;
        }
        return verifyInput.length() == 8;
    }

    // Service kiểm tra verifiedCode
    public boolean isCorrectVerifiedCode(String email, String verifiedCode) {
        String emailQuery = userDAO.checkVerifiedCode(verifiedCode);
        // Nếu tìm thấy verifiedCode và id query được trùng với id được gửi từ Servlet => Trả vè true
        return email.equals(emailQuery);
    }

    // Servlet thêm code rỗng vào verifiedCode
    public void setEmptyCode(String email) {
        userDAO.setEmptyCode(email);
    }
}
