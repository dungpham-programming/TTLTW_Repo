package com.ltw.controller.client;

import com.ltw.bean.CustomizeBean;
import com.ltw.bean.UserBean;
import com.ltw.dao.CustomizeDAO;
import com.ltw.dao.UserDAO;
import com.ltw.util.BlankInputUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = {"/user-info"})
public class UserInfoController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();
    private final UserDAO userDAO = new UserDAO();
    private int id;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CustomizeBean customizeInfo = customizeDAO.getCustomizeInfo();
        req.setAttribute("customizeInfo", customizeInfo);

        String action = req.getParameter("action");
        if (action != null) {
            if (action.equals("view")) {
                id = Integer.parseInt(req.getParameter("id"));
                UserBean userBean = userDAO.findUserById(id);
                req.setAttribute("userInfo", userBean);
                req.getRequestDispatcher("client-userinfo.jsp").forward(req, resp);
            }
        }
    }

    // TODO: Set lại id sau khi làm xong mục Đăng nhập.
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action != null) {
            if (action.equals("update")) {
                // Nhận vào các dữ liệu từ JSP
                String firstName = req.getParameter("firstName");
                String lastName = req.getParameter("lastName");
                String addressLine = req.getParameter("addressLine");
                String addressWard = req.getParameter("addressWard");
                String addressDistrict = req.getParameter("addressDistrict");
                String addressProvince = req.getParameter("addressProvince");

                // String thông báo lên JSP
                String notify;
                String error = "";
                String fnError = null;
                String lnError = null;
                String alError = null;
                String awError = null;
                String adError = null;
                String apError = null;
                String existEmail = null;

                // Tạo ra bean lưu trữ thông tin để đưa xuống DAO
                UserBean userBean = new UserBean();

                // Email gốc từ trong database gửi lên được JSP gửi về
                String originalEmail = req.getParameter("originalEmail");

                // Kiểm tra các trường hợp bỏ trống
                // TODO: Nếu không trống, kiểm tra các trường hợp có số
                if (BlankInputUtil.isBlank(firstName)) {
                    error = "error";
                    fnError = "e";
                    req.setAttribute("fnErr", fnError);
                }
                // TODO: Nếu không trống, kiểm tra các trường hợp có số
                if (BlankInputUtil.isBlank(lastName)) {
                    error = "error";
                    lnError = "e";
                    req.setAttribute("lnErr", lnError);
                }
                if (BlankInputUtil.isBlank(addressLine)) {
                    error = "error";
                    alError = "e";
                    req.setAttribute("alErr", alError);
                }
                if (BlankInputUtil.isBlank(addressWard)) {
                    error = "error";
                    awError = "e";
                    req.setAttribute("awErr", awError);
                }
                if (BlankInputUtil.isBlank(addressDistrict)) {
                    error = "error";
                    adError = "e";
                    req.setAttribute("adErr", adError);
                }
                if (BlankInputUtil.isBlank(addressProvince)) {
                    error = "error";
                    apError = "e";
                    req.setAttribute("apErr", apError);
                }

                // Nếu không lỗi thì set thành công và lưu vào database
                if (!error.equals("error")) {
                    // Set thuộc tính vào bean
                    userBean.setFirstName(firstName);
                    userBean.setLastName(lastName);
                    userBean.setAddressLine(addressLine);
                    userBean.setAddressWard(addressWard);
                    userBean.setAddressDistrict(addressDistrict);
                    userBean.setAddressProvince(addressProvince);
                    userBean.setId(id);

                    // Đưa bean xuống Database
                    userDAO.updateAccount(userBean);

                    // Thông báo thành công lên JSP và truyền thông tin mới update lên
                    notify = "success";
                    req.setAttribute("notify", notify);
                }

                // Cuối cùng lấy thông tin từ db để hiển thị cho người dùng
                userBean = userDAO.findUserById(id);
                req.setAttribute("userInfo", userBean);
                req.getRequestDispatcher("client-userinfo.jsp").forward(req, resp);
            }
        }
    }
}
