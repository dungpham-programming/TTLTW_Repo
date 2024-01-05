package com.ltw.controller.admin.client_view;

import com.ltw.bean.CustomizeBean;
import com.ltw.dao.CustomizeDAO;
import com.ltw.util.BlankInputUtil;
import com.ltw.util.CloudStorageUtil;
import com.ltw.util.DetectTypeFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(value = {"/admin/client-home-management"})
public class ClientHomeManagementController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CustomizeBean customizeBean = customizeDAO.getCustomizeInfo();
        req.getRequestDispatcher("/client-home-management.jsp").forward(req, resp);
    }

    // TODO: Thêm JavaScript đếm số ký tự nhập vào
}
