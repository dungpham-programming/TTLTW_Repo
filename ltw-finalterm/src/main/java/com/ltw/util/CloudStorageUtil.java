package com.ltw.util;

import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.InputStreamContent;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.model.File;
import com.google.api.services.drive.model.Permission;

import java.io.IOException;
import java.io.InputStream;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.ResourceBundle;

public class CloudStorageUtil {
    private static final ResourceBundle infoAPI = ResourceBundle.getBundle("api-credential");
    private static final GoogleCredential CREDENTIAL;

    static {
        try {
            CREDENTIAL = googleCredential();
        } catch (GeneralSecurityException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static Drive getDriveService() throws IOException, GeneralSecurityException {
        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        return new Drive.Builder(HTTP_TRANSPORT,
                JacksonFactory.getDefaultInstance(), CREDENTIAL)
                .setApplicationName("DDD. Handicraft")
                .build();
    }

    // Phương thức lấy thông tin xác thực (Crediential)
    public static GoogleCredential googleCredential() throws GeneralSecurityException, IOException {
        Collection<String> elenco = new ArrayList<String>();
        elenco.add("https://www.googleapis.com/auth/drive");
        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        JacksonFactory jsonFactory = new JacksonFactory();
        return new GoogleCredential.Builder()
                .setTransport(HTTP_TRANSPORT)
                .setJsonFactory(jsonFactory)
                .setServiceAccountId(infoAPI.getString("id"))
                .setServiceAccountScopes(elenco)
                .setServiceAccountPrivateKeyFromP12File(new java.io.File(infoAPI.getString("keyPath")))
                .build();
    }


    public static String uploadtoCloudStorage(String fileName, InputStream fileContent) throws IOException, GeneralSecurityException {
        // Id của folder lưu trữ file trong Google Drive
        String repositoryId = "1ROwMxl4WqUykrbw0VV4J_Y3EnD3-4Qlu";
        String imagesId = "1m-sHrNTTTkGmA25hORfUrbpoPNQ6o54R";
        String fileId = "1A19mDNhH9Tj0jvX8gcauaRbQNItjSV3N";
        Drive driveService = getDriveService();

        // Tạo một đối tượng File để upload
        File fileMetadata = getFileMetadata(fileName, imagesId, fileId);

        // Thực hiện upload file lên Google Drive và lấy ra instance File của Drive
        File uploadedFile = driveService.files().create(fileMetadata, new InputStreamContent(null, fileContent))
                .setFields("id, name, webContentLink") // Chỉ lấy các trường cần thiết
                .execute();

        // Set quyền xem cho tất cả mọi người
        addPublicViewerPermission(uploadedFile.getId());
        String link = modifyLink(uploadedFile.getWebContentLink());
        return link;
    }

    // Phương thức lấy ra file metadata để upload
    private static File getFileMetadata(String fileName, String imagesId, String fileId) {
        File fileMetadata = new File();
        fileMetadata.setName(fileName);

        // Kiểm tra xem file trên có là ảnh không
        List<String> parentFolders = new ArrayList<>();
        if (fileName.endsWith(".jpg") || fileName.endsWith(".png")) {
            // Chỉ định danh sách thư mục cha (thư mục muốn đặt file vào)
            // Ở đây ta đăt vào thư mục lưu trữ file ảnh trong Google Drive
            parentFolders.add(imagesId);
        } else {
            // Nếu không thì cho vào file
            parentFolders.add(fileId);
        }
        fileMetadata.setParents(parentFolders);
        return fileMetadata;
    }

    // Phương thức set quyền xem cho tất cả mọi người
    private static void addPublicViewerPermission(String fileId) throws IOException, GeneralSecurityException {
        // Tạo một đối tượng Permission với quyền xem (viewer) và không yêu cầu đăng nhập (anyone).
        Permission permission = new Permission()
                .setType("anyone")
                .setRole("reader");

        // Thêm permission cho file
        getDriveService().permissions().create(fileId, permission).execute();
    }

    // Phương thức tạo link có thể mở trong tab mới
    private static String modifyLink(String url) {
        // Tìm vị trí của "&export=download" trong URL
        int exportParamIndex = url.indexOf("&export=download");

        // Kiểm tra nếu "&export=download" tồn tại trong URL
        if (exportParamIndex != -1) {
            // Xóa "&export=download" từ URL
            return url.substring(0, exportParamIndex);
        } else {
            // Nếu "&export=download" không tồn tại, trả về URL không thay đổi
            return url;
        }
    }
}
