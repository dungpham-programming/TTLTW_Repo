package com.ltw.controller.client;

import com.ltw.bean.BlogBean;
import com.ltw.bean.CategoryBean;
import com.ltw.bean.CustomizeBean;
import com.ltw.dao.BlogDAO;
import com.ltw.dao.CategoryDAO;
import com.ltw.dao.CustomizeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(value = {"/home"})
public class HomeController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final BlogDAO blogDAO = new BlogDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();
        String prContent1 = customizeInfo.getPrContent1();
        String prContent2 = customizeInfo.getPrContent2();
        String prIcon1 = customizeInfo.getPrIcon1();

        // Xử lý các thành phần phân tách bằng dấu ("~" hoặc ",") để lấy ra mảng content
        // Đã xử lý trước khi lưu vào database, nhưng vẫn nên xử lý lại
        String[] prContent1List = splitByTilde(prContent1);
        String[] prContent2List = splitByTilde(prContent2);
        String[] prIcon1List = splitByComma(prIcon1);

        List<CategoryBean> listCategories = categoryDAO.findAllCategories();
        List<BlogBean> listThreeBlogs = blogDAO.findThreeBlogs();

        req.setAttribute("customizeInfo", customizeInfo);
        req.setAttribute("listCategories", listCategories);
        req.setAttribute("listBlogs", listThreeBlogs);
        req.setAttribute("prContent1List", prContent1List);
        req.setAttribute("prContent2List", prContent2List);
        req.setAttribute("prIcon1List", prIcon1List);

        req.getRequestDispatcher("client-home.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    // Hàm lấy ra danh sách văn bản phân cách bằng dấu "~" (Content)
    private String[] splitByTilde(String input) {
        // Trước tiên cần loại bỏ khoảng trắng ở đầu và cuối chuỗi
        String inputClearSpace = clearSpaceHeaderAndFooter(input);
        return inputClearSpace.split("~\\s*");
    }

    // Hàm lấy ra danh sách văn bản phân cách bằng dấu "," (Icon)
    private String[] splitByComma(String input) {
        // Trước tiên cần loại bỏ khoảng trắng ở đầu và cuối chuỗi
        String inputClearSpace = clearSpaceHeaderAndFooter(input);
        return inputClearSpace.split(",\\s*");
    }

    private String clearSpaceHeaderAndFooter(String input) {
        return input.replace("^\\s+|\\s+$", "");
    }
}
