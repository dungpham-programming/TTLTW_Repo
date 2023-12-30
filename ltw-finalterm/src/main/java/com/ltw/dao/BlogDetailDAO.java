package com.ltw.dao;
import com.ltw.bean.BlogDetailBean;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BlogDetailDAO {
        public BlogDetailBean findBlogById(int id) {
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT title, profilePic, content, categoryId, createdDate")
                    .append("FROM blogs")
                    .append("WHERE id = ?");

            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;

            BlogDetailBean blogDetailBean = null;

            try {
                connection = OpenConnectionUtil.openConnection();
                preparedStatement = connection.prepareStatement(sql.toString());
                SetParameterUtil.setParameter(preparedStatement, id);
                resultSet = preparedStatement.executeQuery();



                if (resultSet.next()) {
                    blogDetailBean = new BlogDetailBean();
                    blogDetailBean.setId(id);
                    blogDetailBean.setTitle(resultSet.getString("title"));
                    blogDetailBean.setProfilePic(resultSet.getBlob("profilePic"));
                    blogDetailBean.setContent(resultSet.getString("content"));
                    blogDetailBean.setCategoryId(resultSet.getInt("categoryId"));
                    blogDetailBean.setCreatedDate(resultSet.getTimestamp("createdDate"));
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            return blogDetailBean;
        }
    }


