package com.ltw.dao;

import com.ltw.bean.OrderBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    public List<OrderBean> findAllOrders() {
        String sql = "SELECT id, userId, total, status, shipToDate, createdDate, createdBy, modifiedDate, modifiedBy " +
                "FROM orders";


        List<OrderBean> orderList = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                OrderBean orderBean = new OrderBean();
                orderBean.setId(resultSet.getInt("id"));
                orderBean.setUserId(resultSet.getInt("userId"));
                orderBean.setTotal(resultSet.getDouble("total"));
                orderBean.setStatus(resultSet.getInt("status"));
                orderBean.setShipToDate(resultSet.getTimestamp("shipToDate"));
                orderBean.setCreatedDate(resultSet.getTimestamp("createdDate"));
                orderBean.setCreatedBy(resultSet.getString("createdBy"));
                orderBean.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
                orderBean.setModifiedBy(resultSet.getString("modifiedBy"));

                orderList.add(orderBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return orderList;
    }

    public OrderBean findOrderById(int id) {
        OrderBean order = null;
        String sql = "SELECT userId, total, status, shipToDate, createdDate, createdBy, modifiedDate, modifiedBy " +
                "FROM orders " +
                "WHERE id = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, id);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                order = new OrderBean();
                order.setId(resultSet.getInt("id"));
                order.setUserId(resultSet.getInt("userId"));
                order.setTotal(resultSet.getDouble("total"));
                order.setShipToDate(resultSet.getTimestamp("shipToDate"));
                order.setStatus(resultSet.getInt("status"));
                order.setCreatedDate(resultSet.getTimestamp("createdDate"));
                order.setCreatedBy(resultSet.getString("createdBy"));
                order.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
                order.setModifiedBy(resultSet.getString("modifiedBy"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return order;
    }

    public void updateOrder(OrderBean orderBean) {
        String sql = "UPDATE orders " +
                "SET status = ? " +
                "WHERE id = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, orderBean.getStatus(), orderBean.getId());
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
