package com.ltw.api.admin;

import com.ltw.bean.BlogBean;
import com.ltw.bean.UserBean;
import com.ltw.constant.LogLevel;
import com.ltw.constant.LogState;
import com.ltw.dao.BlogDAO;
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

@WebServlet(value = { "/api/adimn/blog"})
public class BlogAPI extends HttpServlet {
    private final BlogDAO blogDAO = new BlogDAO();
    private BlogBean prevBlog;
    private LogService<BlogBean> logService = new LogService<>();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
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

        List<BlogBean> blogs = blogDAO.getBlogsDatatable(start, length, columnOrder, orderDir, searchValue);
        int recordsTotal = blogDAO.getRecordsTotal();
        // Tổng số record khi filter search
        int recordsFiltered = blogDAO.getRecordsFiltered(searchValue);
        draw++;

        DatatableDTO<BlogBean> blogDatatableDTO = new DatatableDTO<>(blogs, recordsTotal, recordsFiltered, draw);
        String jsonData = new TransferDataUtil<DatatableDTO<BlogBean>>().toJson(blogDatatableDTO);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonData);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String status;
        String notify;

        prevBlog = blogDAO.findBlogById(id);
        int affectedRow = blogDAO.deleteBlog(id);

        if (affectedRow < 1) {
            BlogBean currentBlog = blogDAO.findBlogById(id);
            logService.log(req, "admin-delete-blog", LogState.FAIL, LogLevel.ALERT, prevBlog, currentBlog);
            status = "error";
            notify = "Có lỗi khi xóa log!";
        } else {
            logService.log(req, "admin-delete-blog", LogState.SUCCESS, LogLevel.WARNING, prevBlog, null);
            status = "success";
            notify = "Xóa log thành công!";
        }

        String jsonData = "{\"status\": \"" + status + "\", \"notify\": \"" + notify + "\"}";

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonData);
    }
}
