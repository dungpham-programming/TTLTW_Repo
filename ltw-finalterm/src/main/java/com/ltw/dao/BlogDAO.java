package com.ltw.dao;

import com.ltw.bean.BlogBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO {
    // TODO: Thay đổi lại câu SQL khi thêm status trong bảng Category
    public List<BlogBean> findThreeBlogs() {
        List<BlogBean> result = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, title, categoryId, createdDate ")
                .append("FROM blogs ")
                .append("WHERE status = 1 ")
                .append("LIMIT 3");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                BlogBean blogBean = new BlogBean();
                blogBean.setId(resultSet.getInt("id"));
                blogBean.setTitle(resultSet.getString("title"));
                blogBean.setCategoryId(resultSet.getInt("categoryId"));
                blogBean.setCreatedDate(resultSet.getTimestamp("createdDate"));

                result.add(blogBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return result;
    }
}
