package com.ltw.controller.admin.client_view;

import com.ltw.bean.CustomizeBean;
import com.ltw.dao.CustomizeDAO;
import com.ltw.util.BlankInputUtil;
import com.ltw.util.CloudStorageUtil;
import com.ltw.util.DetectTypeFileUtil;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

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

// TODO: Code JavaScript đếm số ký tự nhập vào ô (Nếu có thời gian)
public class ClientHomeManagementController extends HttpServlet {
    private final CustomizeDAO customizeDAO = new CustomizeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CustomizeBean customizeBean = customizeDAO.getCustomizeInfo();
        req.setAttribute("customizeBean", customizeBean);
        req.getRequestDispatcher("/client-home-management.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String welcomeTitle = req.getParameter("welcomeTitle");
        String welcomeDes = req.getParameter("welcomeDes");
        String productTitle = req.getParameter("productTitle");
        String productDes = req.getParameter("productDes");
        String prTitle1 = req.getParameter("prTitle1");
        String prDes1 = req.getParameter("prDes1");
        String prIcon1 = req.getParameter("prIcon1");
        String prContentTitle1 = req.getParameter("prContentTitle1");
        String prContentDes1 = req.getParameter("prContentDes1");
        Part prLink1 = req.getPart("prLink1");
        String prTitle2 = req.getParameter("prTitle2");
        String prDes2 = req.getParameter("prDes2");
        String prContent2 = req.getParameter("prContent2");
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
                prTitle1, prDes1, prIcon1, prContentTitle1, prContentDes1,
                prTitle2, prDes2, prContent2,
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
            // Nếu không tải lên file (part.getSize <= 0) thì không lỗi (có thể sửa ảnh hoặc là không)
            if (part.getSize() <= 0) {
                imageErrors.add(null);
            }
            // Nếu có Part, và Part Không là ảnh thì thêm lỗi
            else if (!DetectTypeFileUtil.isImage(part)) {
                if (isValid) {
                    isValid = false;
                }
                imageErrors.add("e");
            } else {
                imageErrors.add(null);
            }
        }

        CustomizeBean customizeBean = new CustomizeBean();
        // Nếu không có lỗi thì lưu vào database
        if (isValid) {
            String linkImage1 = null;
            String linkImage2 = null;
            String backgroundImage = null;
            try {
                if (prLink1.getSize() > 0) {
                    linkImage1 = CloudStorageUtil.uploadtoCloudStorage(prLink1.getSubmittedFileName(), prLink1.getInputStream());
                }
                if (prLink2.getSize() > 0) {
                    linkImage2 = CloudStorageUtil.uploadtoCloudStorage(prLink2.getSubmittedFileName(), prLink2.getInputStream());
                }
                if (background.getSize() > 0) {
                    backgroundImage = CloudStorageUtil.uploadtoCloudStorage(background.getSubmittedFileName(), background.getInputStream());
                }
            } catch (GeneralSecurityException e) {
                throw new RuntimeException(e);
            }

            // Thực hiện xóa các khoảng trắng ở đầu và cuối chuỗi cho content và icon
            String clearSpaceIcon1 = clearSpaceHeaderAndFooter(prIcon1);
            String clearSpaceContentTitle1 = clearSpaceHeaderAndFooter(prContentTitle1);
            String clearSpaceContentDes1 = clearSpaceHeaderAndFooter(prContentDes1);
            String clearSpaceContent2 = clearSpaceHeaderAndFooter(prContent2);

            // Thêm màu chủ đạo của icon
            String colorIconList = colorIconList(clearSpaceIcon1);

            customizeBean.setWelcomeTitle(welcomeTitle.trim());
            customizeBean.setWelcomeDes(welcomeDes);
            customizeBean.setProductTitle(productTitle.trim());
            customizeBean.setProductDes(productDes.trim());
            customizeBean.setPrTitle1(prTitle1.trim());
            customizeBean.setPrDes1(prDes1.trim());
            customizeBean.setPrIcon1(colorIconList);
            customizeBean.setPrContentTitle1(clearSpaceContentTitle1);
            customizeBean.setPrContentDes1(clearSpaceContentDes1);
            if (linkImage1 != null) {
                customizeBean.setPrLink1(linkImage1);
            } else {
                customizeBean.setPrLink1(findOldImage1Link());
            }
            customizeBean.setPrTitle2(prTitle2.trim());
            customizeBean.setPrDes2(prDes2);
            customizeBean.setPrContent2(clearSpaceContent2);
            if (linkImage2 != null) {
                customizeBean.setPrLink2(linkImage2);
            } else {
                customizeBean.setPrLink2(findOldImage2Link());
            }
            if (backgroundImage != null) {
                customizeBean.setBackground(backgroundImage);
            } else {
                customizeBean.setBackground(findOldBackgroundLink());
            }
            customizeBean.setFooterLeft(footerLeft);
            customizeBean.setFooterMiddle(footerMiddle);

            // Link thì nên bỏ khoảng trống ở đầu và cuối
            customizeBean.setFacebookLink(facebookLink.trim());
            customizeBean.setTwitterLink(twitterLink.trim());
            customizeBean.setInstagramLink(instagramLink.trim());
            customizeBean.setLinkedinLink(linkedinLink.trim());

            int affectRows = customizeDAO.updateCustomize(customizeBean);
            if (affectRows == -1) {
                String serverError = "e";
                req.setAttribute("customizeBean", customizeBean);
                req.setAttribute("serverError", serverError);
                req.getRequestDispatcher("/client-home-management.jsp").forward(req, resp);
            } else if (affectRows >= 0) {
                String update = "success";
                resp.sendRedirect(req.getContextPath() + "/admin/client-home-management?update=" + update);
            }
        } else {
            // Có lỗi thì gửi danh sách các ô bị lỗi lên
            req.setAttribute("blankErrors", blankErrors);
            req.setAttribute("imageErrors", imageErrors);
            req.setAttribute("customizeBean", customizeBean);
            req.getRequestDispatcher("/client-home-management.jsp").forward(req, resp);
        }
    }

    private String clearSpaceHeaderAndFooter(String input) {
        return input.trim();
    }

    private String findOldImage1Link() {
        return customizeDAO.findOldImage1Link();
    }

    private String findOldImage2Link() {
        return customizeDAO.findOldImage2Link();
    }

    private String findOldBackgroundLink() {
        return customizeDAO.findOldBackgroundLink();
    }

    private String colorIconList(String iconListInput) {
        StringBuilder sb = new StringBuilder();
        String[] listIcon = iconListInput.split(",\\s+");
        for (int i = 0; i < listIcon.length; i++) {
            sb.append(addWebColorForIcon(listIcon[i]));
            if (i != listIcon.length - 1) {
                sb.append(",");
            }
        }
        return sb.toString();
    }

    private String addWebColorForIcon(String icon) {
        String result;
        // Sử dụng thư viện Jsoup
        // Chuyển đổi chuỗi HTML thành một đối tượng Document của Jsoup
        Document doc = Jsoup.parse(icon);

        // Lấy phần tử <i> từ Document
        Element iconElement = doc.select("i").first();

        // Thêm thuộc tính style vào phần tử <i>
        iconElement.attr("style", "color: #e3bd74;");

        // In ra chuỗi HTML đã được sửa đổi
        result = iconElement.outerHtml();
        return result;
    }
}
