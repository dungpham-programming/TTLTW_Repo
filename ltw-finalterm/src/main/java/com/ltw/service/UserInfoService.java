package com.ltw.service;

import com.ltw.bean.UserBean;
import com.ltw.dao.UserDAO;

import java.util.List;

public class UserInfoService {
    private final UserDAO userDAO = new UserDAO();

    // Service cập nhật tài khoản
    public void updateAccount(UserBean user) {
        userDAO.updateAccount(user);
    }

    // Service lấy ra thông tin tài khoản
    public UserBean infoAccount(int id) {
        return userDAO.findUserByid(id);
    }

    // Service kiểm tra xem email có trùng với email cũ không
    public boolean isSameWithOriginal(String originalEmail, String updateEmail) {
        return originalEmail.equals(updateEmail);
    }

    public boolean isExistEmail(String updateEmail) {
        List<Integer> list = userDAO.findIdByEmail(updateEmail);
        return !list.isEmpty();
    }
}
