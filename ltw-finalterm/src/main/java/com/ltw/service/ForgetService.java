package com.ltw.service;

import com.ltw.dao.UserDAO;

import java.util.List;
import java.util.Random;

public class ForgetService {
    private final UserDAO userDAO = new UserDAO();

    // Service lưu verifiedCode xuống database
    public void saveCodeByEmail(String email, String verifiedCode) {
        userDAO.saveCodeByEmail(email, verifiedCode);
    }

    // Service tìm id theo email
    public int findIdByEmail(String email) {
        return userDAO.findIdByEmail(email);
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
}
