package com.ltw.controller;

import com.ltw.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = {"/signin"})
public class SigninController extends HttpServlet {
    private final UserDAO user = new UserDAO()
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String emailError = "";
        String password = req.getParameter("password");

        if (!email.isEmpty() || (email != null)) {
            if(isCorrectEmail(email)){
                if(isExistEmail(email))
            }else {
                emailError = "Email không tồn tại";
                req.setAttribute("emailError", emailError);
            }

        } else {
            emailError = "Email không được để trống";
            req.setAttribute("emailError", emailError);
        }
    }
    private boolean isCorrectEmail(String email){
        return true;
    }

    private boolean isExistEmail(String email){
        return true;
    }

}

