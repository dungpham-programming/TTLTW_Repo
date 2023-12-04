package com.ltw.service;

import com.ltw.dao.UserDAO;

import java.util.List;

public class RegisterService {
    private final UserDAO userDAO = new UserDAO();

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


}
