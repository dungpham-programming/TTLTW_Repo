package com.ltw.dao;

import com.ltw.bean.BlogBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class BlogDAO {
    public BlogBean findBlogById(int id) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, author, title, profilePic, content, categoryId, createdDate ")
                .append("FROM blogs ")
                .append("WHERE id = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        BlogBean blogBean = null;
        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());
            SetParameterUtil.setParameter(preparedStatement, id);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                blogBean = new BlogBean();
                blogBean.setId(resultSet.getInt("id"));
                blogBean.setAuthor(resultSet.getString("author"));
                blogBean.setTitle(resultSet.getString("title"));
                blogBean.setProfilePic(resultSet.getString("profilePic"));
                blogBean.setContent(resultSet.getString("content"));
                blogBean.setCategoryId(resultSet.getInt("categoryId"));
                blogBean.setCreatedDate(resultSet.getTimestamp("createdDate"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return blogBean;
    }
    
    // TODO: Thay đổi lại câu SQL khi thêm status trong bảng Category
    public List<BlogBean> findThreeBlogs() {
        List<BlogBean> result = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, title, author, categoryId, createdDate ")
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
                blogBean.setAuthor(resultSet.getString("author"));
                blogBean.setCategoryId(resultSet.getInt("categoryId"));
                blogBean.setCreatedDate(resultSet.getTimestamp("createdDate"));

                result.add(blogBean);
            }
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
    }

    public List<BlogBean> findAllBlogs() {
        List<BlogBean> result = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, title, author, categoryId, createdDate ")
                .append("FROM blogs ")
                .append("WHERE status = 1 ");

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
                blogBean.setAuthor(resultSet.getString("author"));
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