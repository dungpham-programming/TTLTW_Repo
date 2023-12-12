package com.ltw.service;

import com.ltw.bean.UserBean;
import com.ltw.dao.UserDAO;

import java.util.List;
import java.util.Random;

public class SigninService {
    private final UserDAO userDAO = new UserDAO();

    // Service lấy lên id từ email
    public int findIdByEmail(String email) {
        return userDAO.findIdByEmail(email).get(0);
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
        return !userByEmail.isEmpty();      // Size != 0 => True, Size = 0 => False
    }

    // Service kiểm tra xem email và password có hợp lệ không
    public boolean isValidLogin(String email, String password) {
        return userDAO.isValidCredentials(email, password);
    }

    // Service kiểm tra xem tài khoản đã active chưa
    public boolean isActive(String email) {
       return userDAO.findActiveAccountByEmail(email) != -1;
    }

    // Service lấy lên thông tin user dựa vào email để đưa vào Session
    public UserBean findUserByEmail(String email) {
        return userDAO.findUserByEmail(email);
    }

    // Service tạo verify code có độ dài là 8 ký tự
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
