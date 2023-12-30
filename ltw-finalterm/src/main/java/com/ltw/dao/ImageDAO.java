package com.ltw.dao;

import com.ltw.bean.ImageBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.*;

public class ImageDAO {
    // TODO: Cần thêm status cho ảnh (Sẽ làm sau)
    public ImageBean findImageById(int id) {
        ImageBean imageBean = null;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, name, link, productId ")
                .append("FROM images ");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                imageBean = new ImageBean();
                imageBean.setName(resultSet.getString("name"));
                imageBean.setLink(resultSet.getString("link"));
                imageBean.setProductId(resultSet.getInt("productId"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return imageBean;
    }
    // TODO: Ở đây ta lấy ví dụ productId = 1, sau này khi chạy thật sẽ thay thế
    public int insertProductImage(ImageBean image) {
        int id = -1;
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO images ")
                .append("(name, link, productId)")
                .append(" VALUES ")
                .append("(?, ?, 1)");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            // Do đây là non-query (Non-query là INSERT, UPDATE, DELETE trong SQL) nên cần setAutoCommit(false)...
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);

            SetParameterUtil.setParameter(preparedStatement, image.getName(), image.getLink());
            id = preparedStatement.executeUpdate();

            // ... và commit ở đây...
            connection.commit();
        } catch (SQLException e) {
            try {
                // ... cũng như rollback khi bị lỗi SQL ở đây.
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
        return id;
    }
}
