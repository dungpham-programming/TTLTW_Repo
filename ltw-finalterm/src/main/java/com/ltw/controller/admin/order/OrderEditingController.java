package com.ltw.controller.admin.order;

import com.ltw.bean.OrderBean;
import com.ltw.dao.OrderDAO;
import com.ltw.util.BlankInputUtil;
import com.ltw.util.NumberValidateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
@WebServlet(value = {"/admin/order-management/editing"})
public class OrderEditingController extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        OrderBean orderBean = orderDAO.findOrderById(id);
        req.setAttribute("orderBean", orderBean);
        req.getRequestDispatcher("/editing-order.jsp").forward(req, resp);
    }

    // TODO: Sửa lại code
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        // Sử dụng vòng lặp để set lỗi để trống theo index,
        // tuy nhiên cần phải giữ đúng thứ tự của input theo form và theo database (Vì sử dụng vòng lặp theo i để set lỗi)
        String idStr = req.getParameter("id");
        // Lấy id kiểu int ra để lưu vào database
        int id = Integer.parseInt(idStr);
        String userID = req.getParameter("userId");
        String total = req.getParameter("total");
        String status = req.getParameter("status");
        String shipToDate = req.getParameter("shipToDate");
        String createdDate = req.getParameter("createdDate");
        String createdBy = req.getParameter("createdBy");
        String modifiedDate = req.getParameter("modifiedDate");
        String modifiedBy = req.getParameter("modifiedBy");
        String profilePic = req.getParameter("profilePic");

        // Biến thông báo thành công
        String success = "success";

        // Đặt các thuộc tính đúng thứ tự
        String[] inputsForm = new String[]{ userID, shipToDate, total, status, profilePic, createdDate, createdBy, modifiedDate, modifiedBy};
        // Mảng lưu trữ lỗi
        ArrayList<String> errors = new ArrayList<>();

        // Biến bắt lỗi
        boolean isValid = true;

        for (String string : inputsForm) {
            if (BlankInputUtil.isBlank(string)) {
                errors.add("e");
                if (isValid) {
                    isValid = false;
                }
            } else {
                errors.add(null);
            }
        }
        req.setAttribute("errors", errors);



        // Nếu không lỗi thì lưu vào database
        if (isValid) {
            // Đổi String về số
            int userIDInt = NumberValidateUtil.toInt(userID);
            int statusInt = NumberValidateUtil.toInt(status);


            // Set thuộc tính vào bean
            OrderBean orderBean = new OrderBean();
            orderBean.setId(id);
            orderBean.setUserId(userIDInt);
            orderBean.setStatus(statusInt);

            orderDAO.updateOrder(orderBean);
            resp.sendRedirect(req.getContextPath() + "/admin/order-management/editing?id=" + orderBean.getId() + "&success=" + success);
        } else {
            OrderBean orderBean = orderDAO.findOrderById(id);
            req.setAttribute("orderBean", orderBean);
            req.getRequestDispatcher("/editing-order.jsp").forward(req, resp);
        }
    }
}
