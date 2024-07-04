package com.ltw.api.admin;

import com.ltw.bean.UserBean;
import com.ltw.dao.UserDAO;
import com.ltw.dto.DatatableDTO;
import com.ltw.util.TransferDataUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = {"/api/admin/account"})
public class AccountAPI extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

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

        List<UserBean> users = userDAO.getUsersDatatable(start, length, columnOrder, orderDir, searchValue);
        int recordsTotal = userDAO.getRecordsTotal();
        // Tổng số record khi filter search
        int recordsFiltered = userDAO.getRecordsFiltered(searchValue);
        draw++;

        DatatableDTO<UserBean> userDatatableDTO = new DatatableDTO<>(users, recordsTotal, recordsFiltered, draw);
        String jsonData = new TransferDataUtil<DatatableDTO<UserBean>>().toJson(userDatatableDTO);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonData);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String status;
        String notify;

        int affectedRow = userDAO.deleteAccount(id);

        if (affectedRow < 1) {
            status = "error";
            notify = "Có lỗi khi xóa log!";
        } else {
            status = "success";
            notify = "Xóa log thành công!";
        }

        String jsonData = "{\"status\": \"" + status + "\", \"notify\": \"" + notify + "\"}";

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonData);
    }
}
