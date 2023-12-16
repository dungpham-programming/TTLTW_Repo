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

    // Service tạo ra một verifiedCode mới
    public void setNewVerifiedCode(int id, String verifiedCode) {
        userDAO.setNewVerifiedCode(id, verifiedCode);
    }

    // Service set code rỗng sau khi đã verify và active tài khoản
    public void setEmptyCodeAndActive(int id) {
        userDAO.setEmptyCodeAndActive(id);
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
        // cùng với đó là active tài khoản
        if (id == idQuery) {
            setEmptyCodeAndActive(id);
            check = true;
        }
        else {
            check = false;
        }
        return check;
    }
}
