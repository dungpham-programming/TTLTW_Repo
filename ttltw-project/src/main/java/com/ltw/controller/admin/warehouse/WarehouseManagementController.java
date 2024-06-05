package com.ltw.controller.admin.warehouse;

import com.ltw.bean.UserBean;
import com.ltw.bean.WarehouseBean;
import com.ltw.dao.UserDAO;
import com.ltw.dao.WarehouseDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/warehouse-management")
public class WarehouseManagementController extends HttpServlet {
    private final WarehouseDAO warehouseDAO = new WarehouseDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<WarehouseBean> warehouses = WarehouseDAO.findAllWarehouses ();
        request.setAttribute("warehouses", warehouses);
        request.getRequestDispatcher("/warehouse-management.jsp").forward(request, response);
    }
}
