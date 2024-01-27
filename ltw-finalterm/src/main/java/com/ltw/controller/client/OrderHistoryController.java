package com.ltw.controller.client;

import com.ltw.bean.OrderBean;
import com.ltw.bean.UserBean;
import com.ltw.dao.OrderDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/order-history")
public class OrderHistoryController extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserBean user = (UserBean) request.getSession().getAttribute("user");
        int userId = user.getId();
        List<OrderBean> orderList = OrderDAO.findOrderByUserId(userId);
        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("/order-history.jsp").forward(request, response);

    }
}
