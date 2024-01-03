package com.ltw.controller.upload;

import com.ltw.bean.ProductImageBean;
import com.ltw.service.UploadService;
import com.ltw.util.CloudStorageUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@WebServlet(value = {"/upload"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 100
)
public class UploadController extends HttpServlet {
    private final UploadService uploadService = new UploadService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }


    // TODO: Test doPost() ở mức độ cơ bản, chưa upload multifile
    // TODO: Nếu không là ảnh thì forward để gửi về /upload-image
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Integer> ids = new ArrayList<>();
        Collection<Part> parts = req.getParts();
        // Chạy vòng lặp để upload multipart
        // Trong CloudStorageUtil đã kiểm tra xem đâu là ảnh và đâu là các file loại khác
        for (Part part : parts) {
            try {
                String fileName = part.getSubmittedFileName();
                // Kiểm tra xem đây có là ảnh hay là các loại file còn lại
                InputStream fileContent = part.getInputStream();
                String link = CloudStorageUtil.uploadtoCloudStorage(fileName, fileContent);
                ProductImageBean image = new ProductImageBean();
                image.setName(fileName);
                image.setLink(link);
                int id = uploadService.insertProductImage(image);
                ids.add(id);
            } catch (GeneralSecurityException e) {
                throw new RuntimeException(e);
            }
        }
        ProductImageBean productImageBean = uploadService.findImageById(ids.get(0));
        req.setAttribute("imageBean", productImageBean);
        req.getRequestDispatcher("image.jsp").forward(req, resp);
    }
}
