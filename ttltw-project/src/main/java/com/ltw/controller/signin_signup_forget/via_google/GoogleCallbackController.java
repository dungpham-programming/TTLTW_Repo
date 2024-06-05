package com.ltw.controller.signin_signup_forget.via_google;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.ltw.bean.UserBean;
import com.ltw.dao.UserDAO;
import com.ltw.util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.ResourceBundle;

@WebServlet(value = {"/google-callback"})
public class GoogleCallbackController extends HttpServlet {
    private final ResourceBundle bundle = ResourceBundle.getBundle("oauth2dot0");
    private UserDAO userDAO = new UserDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        if (code != null) {
            try {
                HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
                JsonFactory jsonFactory = JacksonFactory.getDefaultInstance();

                GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(jsonFactory,
                        new InputStreamReader(GoogleCallbackController.class.getResourceAsStream(bundle.getString("google-client-secret-file"))));

                GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(httpTransport, jsonFactory,
                        clientSecrets, Collections.singleton("email"))
                        .build();

                GoogleTokenResponse tokenResponse = flow.newTokenRequest(code)
                        .setRedirectUri(bundle.getString("google-redirect-uri")).execute();

                String accessToken = tokenResponse.getAccessToken();

                GoogleIdToken idToken = tokenResponse.parseIdToken();
                GoogleIdToken.Payload payload = idToken.getPayload();
                String userId = payload.getSubject();  // Lấy ID của người dùng
                String email = payload.getEmail();    // Lấy email của người dùng
                String displayName = (String) payload.get("name"); // Lấy tên hiển thị của người dùng

                UserBean user = new UserBean();
                user.setEmail(email);
                user.setLastName(displayName);

                // Nếu email chưa xuất hiện trong database thì thêm thông tin vào database
                if (userDAO.findUserByEmail(email) == null) {
                    userDAO.createAccount(user);
                    // Set user vào Session
                    SessionUtil.getInstance().putValue(req, "user", userDAO.findUserByEmail(email));
                    resp.sendRedirect(req.getContextPath() + "/home");
                } else {
                    switch (userDAO.checkOAuthAccount(email)) {
                        case "oAuth":
                            // Set user vào Session
                            SessionUtil.getInstance().putValue(req, "user", userDAO.findUserByEmail(email));
                            resp.sendRedirect(req.getContextPath() + "/home");
                            break;

                        case "notOAuth":
                            resp.sendRedirect(req.getContextPath() + "/signin?notify=registed-by-page");
                            break;

                        case "error":
                            resp.sendRedirect(req.getContextPath() + "/signin?notify=error-oauth");
                            break;

                        default:
                            resp.sendRedirect(req.getContextPath() + "/signin");
                            break;
                    }
                }
            } catch (GeneralSecurityException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
