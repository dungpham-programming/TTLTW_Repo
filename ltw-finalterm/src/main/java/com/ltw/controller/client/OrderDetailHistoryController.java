package com.ltw.controller.client;

import com.ltw.bean.CustomizeBean;
import com.ltw.bean.OrderDetailBean;
import com.ltw.dao.CustomizeDAO;
import com.ltw.dao.OrderDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = {"/order-detail-history"})

public class OrderDetailHistoryController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();
        request.setAttribute("customizeInfo", customizeInfo);
        // Lấy orderId từ URL
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        // Gọi DAO để lấy chi tiết đơn hàng dựa trên orderId
        List<OrderDetailBean> orderDetails = orderDAO.findOrderDetailByOrderId(orderId);

        // Đặt attribute để chuyển dữ liệu sang JSP
        request.setAttribute("orderDetails", orderDetails);

        // Chuyển hướng đến trang JSP hiển thị chi tiết đơn hàng
        RequestDispatcher dispatcher = request.getRequestDispatcher("/order-detail-history.jsp");
        dispatcher.forward(request, response);
    }
}
