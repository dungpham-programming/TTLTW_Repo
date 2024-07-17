package com.ltw.dao;

import com.ltw.bean.ReviewBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    public List<ReviewBean> findAllReviews() {
        String sql = "SELECT id, productId, userId, username, " +
                "content, rating, status " +
                "createdDate,createdBy, modifiedDate,modifiedBy " +
                "FROM reviews";

        List<ReviewBean> reviewList = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ReviewBean reviewBean = new ReviewBean();
                reviewBean.setId(resultSet.getInt("id"));
                reviewBean.setProductId(resultSet.getInt("productId"));
                reviewBean.setUserId(resultSet.getInt("userId"));
                reviewBean.setUsername(resultSet.getString("username"));
                reviewBean.setContent(resultSet.getString("content"));
                reviewBean.setRating(resultSet.getInt("rating"));
                reviewBean.setStatus(resultSet.getInt("status"));
                reviewBean.setCreatedDate(resultSet.getTimestamp("createdDate"));
                reviewBean.setCreatedBy(resultSet.getString("createdBy"));
                reviewBean.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
                reviewBean.setModifiedBy(resultSet.getString("modifiedBy"));

                reviewList.add(reviewBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return reviewList;
    }

    public int createReview(ReviewBean reviewBean) {
        int id = -1;
        String sql = "INSERT INTO reviews (productId, userId, username, " +
                "content, rating, status" +
                "createdDate,createdBy, modifiedDate,modifiedBy "  +
                "VALUES (?, ?, ?, ?, ?, 1, ?, ?, ?, ?, ?, ?)";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            SetParameterUtil.setParameter(preparedStatement, reviewBean.getProductId(), reviewBean.getUserId(),
                    reviewBean.getUsername(), reviewBean.getContent(), reviewBean.getRating(), reviewBean.getStatus(),
                    reviewBean.getCreatedDate(), reviewBean.getCreatedBy(),
                    reviewBean.getModifiedDate(),reviewBean.getModifiedBy());
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                resultSet = preparedStatement.getGeneratedKeys();
                if (resultSet.next()) {
                    reviewBean.setId(resultSet.getInt(1));
                }
            }
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return id;
    }

    public List<ReviewBean> findReviewPaginationByProductId(int productId, int offset) {
        String sql = "SELECT id, productId, userId, username, " +
                "content, rating, status, " +
                "createdDate, createdBy, modifiedDate, modifiedBy " +
                "FROM reviews " +
                "WHERE (productId = ? AND status = 1) " +
                "ORDER BY createdDate DESC " +
                "LIMIT 10 OFFSET ?";

        List<ReviewBean> reviews = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, productId, offset);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                ReviewBean reviewBean = new ReviewBean();
                reviewBean.setId(resultSet.getInt("id"));
                reviewBean.setProductId(resultSet.getInt("productId"));
                reviewBean.setUserId(resultSet.getInt("userId"));
                reviewBean.setUsername(resultSet.getString("username"));
                reviewBean.setContent(resultSet.getString("content"));
                reviewBean.setRating(resultSet.getInt("rating"));
                reviewBean.setStatus(resultSet.getInt("status"));
                reviewBean.setCreatedDate(resultSet.getTimestamp("createdDate"));
                reviewBean.setCreatedBy(resultSet.getString("createdBy"));
                reviewBean.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
                reviewBean.setModifiedBy(resultSet.getString("modifiedBy"));
                reviews.add(reviewBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return reviews;
    }

    public void disableReview(int id) {
        String sql = "UPDATE reviews " +
                "SET status = 0 " +
                "WHERE id = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, id);
            preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
    }
}
