package com.ltw.api.admin;

import com.ltw.bean.WarehouseBean;
import com.ltw.constant.LogLevel;
import com.ltw.constant.LogState;
import com.ltw.dao.WarehouseDAO;
import com.ltw.dto.DatatableDTO;
import com.ltw.service.LogService;
import com.ltw.util.TransferDataUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = {"/api/admin/warehouse"})
public class WarehouseAPI extends HttpServlet {
    private final WarehouseDAO warehouseDAO = new WarehouseDAO();
    private WarehouseBean prevWarehouse;
    private final LogService<WarehouseBean> logService = new LogService<>();

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

        List<WarehouseBean> warehouses = warehouseDAO.getWarehousesDatatable(start, length, columnOrder, orderDir, searchValue);
        int recordsTotal = warehouseDAO.getRecordsTotal();
        // Tổng số record khi filter search
        int recordsFiltered = warehouseDAO.getRecordsFiltered(searchValue);
        draw++;

        DatatableDTO<WarehouseBean> warehouseDatatableDTO = new DatatableDTO<>(warehouses, recordsTotal, recordsFiltered, draw);
        String jsonData = new TransferDataUtil<DatatableDTO<WarehouseBean>>().toJson(warehouseDatatableDTO);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonData);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String status;
        String notify;

        prevWarehouse = warehouseDAO.findWarehouseById(id);
        int affectedRow = warehouseDAO.deleteWarehouse(id);

        if (affectedRow < 1) {
            WarehouseBean currentWarehouse = warehouseDAO.findWarehouseById(id);
            logService.log(req, "admin-delete-warehouse", LogState.FAIL, LogLevel.ALERT, prevWarehouse, currentWarehouse);
            status = "error";
            notify = "Có lỗi khi xóa kho!";
        } else {
            logService.log(req, "admin-delete-warehouse", LogState.SUCCESS, LogLevel.WARNING, prevWarehouse, null);
            status = "success";
            notify = "Xóa kho thành công!";
        }

        String jsonData = "{\"status\": \"" + status + "\", \"notify\": \"" + notify + "\"}";

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonData);
    }
}
