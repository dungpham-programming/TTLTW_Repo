package com.ltw.controller.admin.client_view;

import com.ltw.bean.CustomizeBean;
import com.ltw.dao.CustomizeDAO;
import com.ltw.util.BlankInputUtil;
import com.ltw.util.CloudStorageUtil;
import com.ltw.util.DetectTypeFileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
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
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 100
)

// TODO: Thay đổi cách phân tách các nội dung (Dùng dấu \ chẳng hạn)
public class ClientHomeManagementController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        CustomizeBean customizeBean = customizeDAO.getCustomizeInfo();
        req.getRequestDispatcher("/client-home-management.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String welcomeTitle = req.getParameter("welcomeTitle");
        String welcomeDes = req.getParameter("welcomeDes");
        String productTitle = req.getParameter("productTitle");
        String productDes = req.getParameter("productDes");
        String prTitle1 = req.getParameter("prTitle1");
        String prContent1 = req.getParameter("prContent1");
        String prDes1 = req.getParameter("prDes1");
        String prIcon1 = req.getParameter("prIcon1");
        Part prLink1 = req.getPart("prLink1");
        String prTitle2 = req.getParameter("prTitle2");
        String prContent2 = req.getParameter("prContent2");
        String prDes2 = req.getParameter("prDes2");
        Part prLink2 = req.getPart("prLink2");
        Part background = req.getPart("background");
        String footerLeft = req.getParameter("footerLeft");
        String footerMiddle = req.getParameter("footerMiddle");
        String facebookLink = req.getParameter("facebookLink");
        String twitterLink = req.getParameter("twitterLink");
        String instagramLink = req.getParameter("instagramLink");
        String linkedinLink = req.getParameter("linkedinLink");

        // Mảng kiểm tra lỗi input
        String[] inputCheck = {welcomeTitle, welcomeDes, productTitle, productDes,
                prTitle1, prContent1, prDes1, prIcon1,
                prTitle2, prContent2, prDes2,
                footerLeft, footerMiddle};

        // Mảng kiểm tra lỗi image
        Part[] partCheck = {prLink1, prLink2, background};

        // Mảng giữ lỗi
        List<String> blankErrors = new ArrayList<>();
        List<String> imageErrors = new ArrayList<>();

        // Biến bắt lỗi
        boolean isValid = true;

        // Kiểm tra lỗi để trống cho input
        for (String input : inputCheck) {
            if (BlankInputUtil.isBlank(input)) {
                if (isValid) {
                    isValid = false;
                }
                blankErrors.add("e");
            } else {
                blankErrors.add(null);
            }
        }

        // Kiểm tra lỗi không phải file ảnh
        for (Part part : partCheck) {
            // Không là ảnh thì thêm lỗi
            if (!DetectTypeFileUtil.isImage(part)) {
                if (isValid) {
                    isValid = false;
                }
                imageErrors.add("e");
            } else {
                imageErrors.add(null);
            }
        }

        // Nếu không có lỗi thì lưu vào database
        if (isValid) {
            String linkImage1;
            String linkImage2;
            String backgroundImage;
            try {
                linkImage1 = CloudStorageUtil.uploadtoCloudStorage(prLink1.getSubmittedFileName(), prLink1.getInputStream());
                linkImage2 = CloudStorageUtil.uploadtoCloudStorage(prLink2.getSubmittedFileName(), prLink2.getInputStream());
                backgroundImage = CloudStorageUtil.uploadtoCloudStorage(background.getSubmittedFileName(), background.getInputStream());
            } catch (GeneralSecurityException e) {
                throw new RuntimeException(e);
            }

            CustomizeBean customizeBean = new CustomizeBean();
            customizeBean.setWelcomeTitle(welcomeTitle);
            customizeBean.setWelcomeDes(welcomeDes);
            customizeBean.setProductTitle(productTitle);
            customizeBean.setProductDes(productDes);
            customizeBean.setPrTitle1(prTitle1);
            customizeBean.setPrContent1(prContent1);
            customizeBean.setPrDes1(prDes1);
            customizeBean.setPrIcon1(prIcon1);
            customizeBean.setPrLink1(linkImage1);
            customizeBean.setPrTitle2(prTitle2);
            customizeBean.setPrContent2(prContent2);
            customizeBean.setPrDes2(prDes2);
            customizeBean.setPrLink2(linkImage2);
            customizeBean.setBackground(backgroundImage);
            customizeBean.setFooterLeft(footerLeft);
            customizeBean.setFooterMiddle(footerMiddle);
            customizeBean.setFacebookLink(facebookLink);
            customizeBean.setTwitterLink(twitterLink);
            customizeBean.setInstagramLink(instagramLink);
            customizeBean.setLinkedinLink(linkedinLink);

//            int affectRows = customizeDAO.createCustomize(customizeBean);
//            if (affectRows == -1) {
//                String serverError = "e";
//                req.setAttribute("customizeBean", customizeBean);
//                req.setAttribute("serverError", serverError);
//                req.getRequestDispatcher("/client-home-management.jsp").forward(req, resp);
//            } else if (affectRows >= 0) {
                String update = "success";
                resp.sendRedirect(req.getContextPath() + "/admin/client-home-management?id=1&update=" + update);
            }
//        } else {
//            // Có lỗi thì gửi danh sách các ô bị lỗi lên
//            req.setAttribute("blankErrors", blankErrors);
//            req.setAttribute("imageErrors", imageErrors);
//            req.getRequestDispatcher("/client-home-management.jsp").forward(req, resp);
//        }
    }
}
