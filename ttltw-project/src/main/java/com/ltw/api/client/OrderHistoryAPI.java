package com.ltw.api.client;

import com.ltw.bean.OrderBean;
import com.ltw.bean.OrderDetailBean;
import com.ltw.bean.ProductBean;
import com.ltw.constant.LogLevel;
import com.ltw.constant.LogState;
import com.ltw.dao.OrderDAO;
import com.ltw.dao.OrderDetailDAO;
import com.ltw.dao.ProductDAO;
import com.ltw.dto.DatatableDTO;
import com.ltw.dto.FullOrderDTO;
import com.ltw.service.LogService;
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
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final LogService<FullOrderDTO> cancelLogService = new LogService<>();
    private final LogService<ProductBean> productLogService = new LogService<>();
    private FullOrderDTO prevFullOrderDTO;

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

        List<OrderBean> orders = orderDAO.getOrderDatatable(start, length, columnOrder, orderDir, searchValue);
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
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        String status = "";
        String notify = "";
        OrderBean prevOrder = orderDAO.findOrderById(orderId);
        List<OrderDetailBean> prevDetails = orderDetailDAO.findDetailByOrderId(String.valueOf(orderId));
        prevFullOrderDTO = new FullOrderDTO(prevOrder, prevDetails);

        boolean isValid = false;

        // Kiểm tra trạng thái đơn hàng trước khi hủy
        if (prevOrder.getStatus() < 0 || prevOrder.getStatus() > 4) {
            status = "invalid";
            notify = "Trạng thái không hợp lệ!";
        } else if (prevOrder.getStatus() == 0) {
            status = "cancelled";
            notify = "Đơn hàng đã được hủy trước đó!";
        } else if (prevOrder.getStatus() > 2) {
            status = "refused";
            notify = "Đơn hàng đã qua giai đoạn Đã xác nhận, không thể hủy!";
        } else {
            isValid = true;
        }

        if (isValid) {
            int affectedRow = orderDAO.cancelOrder(orderId);
            OrderBean nowOrder = orderDAO.findOrderById(orderId);
            List<OrderDetailBean> nowDetails = orderDetailDAO.findDetailByOrderId(String.valueOf(orderId));
            FullOrderDTO nowFullOrderDTO = new FullOrderDTO(nowOrder, nowDetails);
            if (affectedRow < 1) {
                status = "error";
                notify = "Có lỗi khi hủy đơn hàng!";
                cancelLogService.log(req, "user-cancel-order", LogState.FAIL, LogLevel.ALERT, prevFullOrderDTO, nowFullOrderDTO);
            } else {
                status = "success";
                notify = "Hủy đơn hàng thành công!";
                // Update lại số lượng hàng khi hủy
                for (OrderDetailBean detail : nowDetails) {
                    ProductBean prevProduct = productDAO.findProductById(detail.getProductId());
                    int newQuantity = prevProduct.getQuantity() + detail.getQuantity();
                    productDAO.updateQuantityProduct(detail.getProductId(), newQuantity);

                    ProductBean nowProduct = productDAO.findProductById(detail.getProductId());
                    productLogService.log(req, "user-cancel-plus-product", LogState.SUCCESS, LogLevel.ALERT, prevProduct, nowProduct);
//                    SendEmailUtil.sendEmailCancelProduct(prevProduct, nowProduct);
                }
                cancelLogService.log(req, "user-cancel-order", LogState.SUCCESS, LogLevel.ALERT, prevFullOrderDTO, nowFullOrderDTO);
            }
        }
        String jsonData = "{\"status\": \"" + status + "\", \"notify\": \"" + notify + "\"}";
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonData);
    }
}
