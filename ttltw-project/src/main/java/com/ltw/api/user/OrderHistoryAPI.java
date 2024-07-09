package com.ltw.api.user;

import com.ltw.bean.OrderBean;
import com.ltw.bean.UserBean;
import com.ltw.dao.OrderDAO;
import com.ltw.dto.DatatableDTO;
import com.ltw.util.SendEmailUtil;
import com.ltw.util.TransferDataUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/client/order-history")
public class OrderHistoryAPI extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy ra các Property mà DataTable gửi về
        // Thông tin về phân trang
        int draw = Integer.parseInt(req.getParameter("draw"));      // Số thứ tự của request hiện tại
        int start = Integer.parseInt(req.getParameter("start"));    // Vị trí bắt đầu của dữ liệu
        int length = Integer.parseInt(req.getParameter("length"));  // Số phần tử trên một trang

        // Thông tin về tìm kiếm
        String searchValue = req.getParameter("search[value]");

        // Thông tin về sắp xếp
        String orderBy = req.getParameter("order[0][column]") == null ? "0" : req.getParameter("order[0][column]");
        String orderDir = req.getParameter("order[0][dir]") == null ? "asc" : req.getParameter("order[0][dir]");
        String columnOrder = req.getParameter("columns[" + orderBy + "][data]");      // Tên của cột muốn sắp xếp

        List<OrderBean> orders = orderDAO.getOrdersDatatable(start, length, columnOrder, orderDir, searchValue);
        int recordsTotal = orderDAO.getRecordsTotal();
        // Tổng số record khi filter search
        int recordsFiltered = orderDAO.getRecordsFiltered(searchValue);
        draw++;

        DatatableDTO<OrderBean> orderDatatableDTO = new DatatableDTO<>(orders, recordsTotal, recordsFiltered, draw);
        String jsonData = new TransferDataUtil<DatatableDTO<OrderBean>>().toJson(orderDatatableDTO);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonData);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        UserBean user = (UserBean) req.getSession().getAttribute("user");
        int userId = user.getId();
        List<OrderBean> orderList = orderDAO.findOrderByUserId(userId);

        if (action != null) {
            if (action.equals("cancel")) {
                String orderId = req.getParameter("orderId");
                int affected = orderDAO.cancelOrder(orderId);
                if (affected == -1 || affected == 0) {
                    req.setAttribute("error", "e");
                } else {
                    SendEmailUtil.sendOrderNotify(user.getEmail(), Integer.parseInt(orderId), "wait");
                }
            }
        }
        req.setAttribute("orderList", orderList);
    }
}
