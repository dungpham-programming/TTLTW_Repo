package com.ltw.controller.admin.order;

import com.ltw.dao.ContactDAO;
import com.ltw.dao.OrderDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/order-management/delete")

public class OrderDeleteController  extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int affectedRows = orderDAO.deleteOrder(id);

        if (affectedRows > 0) {
            response.sendRedirect(request.getContextPath() + "/admin/order-management?success=true");
        } else {
            // Xử lý lỗi nếu cần
            response.sendRedirect(request.getContextPath() + "/admin/order-management?error=true");
        }
    }
}
