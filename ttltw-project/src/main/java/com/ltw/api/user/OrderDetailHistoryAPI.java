package com.ltw.api.user;

import com.ltw.bean.OrderDetailBean;
import com.ltw.dao.OrderDetailDAO;
import com.ltw.dto.DatatableDTO;
import com.ltw.util.TransferDataUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = {"/api/client/order-detail-history"})
public class OrderDetailHistoryAPI extends HttpServlet {
    private OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        int orderId = Integer.parseInt(req.getParameter("orderId"));

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

        List<OrderDetailBean> orderDetails = orderDetailDAO.getOrderDetailsDatatable(orderId, start, length, columnOrder, orderDir, searchValue);
        int recordsTotal = orderDetailDAO.getRecordsTotal();
        // Tổng số record khi filter search
        int recordsFiltered = orderDetailDAO.getRecordsFiltered(searchValue);
        draw++;

        DatatableDTO<OrderDetailBean> orderDetailDatatableDTO = new DatatableDTO<>(orderDetails, recordsTotal, recordsFiltered, draw);
        String jsonData = new TransferDataUtil<DatatableDTO<OrderDetailBean>>().toJson(orderDetailDatatableDTO);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonData);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
