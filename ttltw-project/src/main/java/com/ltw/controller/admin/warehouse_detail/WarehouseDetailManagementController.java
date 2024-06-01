package com.ltw.controller.admin.warehouse_detail;


import com.ltw.bean.WarehouseDetailBean;
import com.ltw.dao.WarehouseDetailDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = {"/admin/warehouse-detail-management"})
public class WarehouseDetailManagementController extends HttpServlet {
    private final WarehouseDetailDAO warehouseDetailDAO = new WarehouseDetailDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int warehouseId = Integer.parseInt(req.getParameter("warehouseId"));
        List<WarehouseDetailBean> warehouseDetailList = warehouseDetailDAO.findWarehouseDetailByWarehouseId(warehouseId);
        req.setAttribute("warehouseDetailList", warehouseDetailList);
        req.getRequestDispatcher("/warehouse-detail-management.jsp").forward(req, resp);
    }
}
