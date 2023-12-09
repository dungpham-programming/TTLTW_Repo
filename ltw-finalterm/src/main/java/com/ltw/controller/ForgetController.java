package com.ltw.controller;

import com.ltw.dao.UserDAO;
import com.ltw.util.SendEmailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Random;

@WebServlet (value = {"/Forget"})
public class ForgetController extends HttpServlet {
    private final UserDAO userDAO=new UserDAO();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("name");
        String emailError= "";
        if(!email.isEmpty() || email!=null){

            if (isEmail(email)){

                if(haveEmail(email)){
                    if(isVerifyEmail(email)){
                        SendEmailUtil.sendVerificationCode(email, generateVerifiedCode());
                        //
                    }
                }else {
                    emailError="Mail xác nhận! Kiểm tra lại email. ";
                    req.setAttribute("emailEr",emailError);
                }

            }else {
                emailError="Mail lỗi! Kiểm tra lại email. ";
                req.setAttribute("emailEr",emailError);
            }

        } else  {
            emailError="Mail rỗng! Nhập lại email . ";
            req.setAttribute("emailEr",emailError);
        }


    }
    private boolean isEmail(String email) {
        return true;
    }
    private boolean haveEmail(String email){
        List<Integer> userS= userDAO.findIdByEmail(email);
        if(userS.size()==0){
            return false;
        }else return true;
    }
    private boolean isVerifyEmail(String email){
        if(userDAO.isEmailVerified(email)){
            return true;
        }
        return false;
    }
    private String generateVerifiedCode() {
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
