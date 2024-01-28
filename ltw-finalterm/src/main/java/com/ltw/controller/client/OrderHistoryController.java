package com.ltw.controller.client;

import com.ltw.bean.CustomizeBean;
import com.ltw.bean.OrderBean;
import com.ltw.bean.UserBean;
import com.ltw.dao.CustomizeDAO;
import com.ltw.dao.OrderDAO;
import com.ltw.util.SendEmailUtil;

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
    private final CustomizeDAO customizeDAO = new CustomizeDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();
        UserBean user = (UserBean) request.getSession().getAttribute("user");
        int userId = user.getId();
        List<OrderBean> orderList = OrderDAO.findOrderByUserId(userId);

        if (action != null) {
            if (action.equals("cancel")) {
                String orderId = request.getParameter("orderId");
                int affected = orderDAO.cancelOrder(orderId);
                if (affected == -1 || affected == 0) {
                    request.setAttribute("error", "e");
                } else {
                    SendEmailUtil.sendOrderNotify(user.getEmail(), Integer.parseInt(orderId), "wait");
                }
            }
        }

        request.setAttribute("customizeInfo", customizeInfo);
        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("/order-history.jsp").forward(request, response);
    }
}
