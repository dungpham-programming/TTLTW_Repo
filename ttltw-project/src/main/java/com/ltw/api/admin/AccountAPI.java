package com.ltw.api.admin;

import com.ltw.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = {"/api/admin/delete-user"})
public class AccountAPI extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String status;
        String notify;

        int affectedRow = userDAO.deleteAccount(id);

        if (affectedRow < 1) {
            status = "error";
            notify = "Có lỗi khi xóa log!";
        } else {
            status = "success";
            notify = "Xóa log thành công!";
        }

        String jsonData = "{\"status\": \"" + status + "\", \"notify\": \"" + notify + "\"}";

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonData);
    }
}
