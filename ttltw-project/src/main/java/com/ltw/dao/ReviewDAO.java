package com.ltw.dao;

import com.ltw.bean.ReviewBean;
import com.ltw.bean.UserBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    public List<ReviewBean> findAllReviews() {
        String sql = "SELECT id, productId, userId, username, " +
                "content, rating, helpfulCount, reportCount, " +
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
                reviewBean.setHelpfulCount(resultSet.getInt("helpfulCount"));
                reviewBean.setReportCount(resultSet.getInt("reportCount"));
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

    public void createReview(ReviewBean reviewBean) {
        String sql = "INSERT INTO reviews (productId, userId, username, " +
                "content, rating, helpfulCount, reportCount, " +
                "createdDate,createdBy, modifiedDate,modifiedBy "  +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, reviewBean.getProductId(), reviewBean.getUserId(),
                    reviewBean.getUsername(), reviewBean.getContent(), reviewBean.getRating(), reviewBean.getHelpfulCount(),
                    reviewBean.getReportCount(), reviewBean.getCreatedDate(), reviewBean.getCreatedBy(),
                    reviewBean.getModifiedDate(),reviewBean.getModifiedBy());
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
