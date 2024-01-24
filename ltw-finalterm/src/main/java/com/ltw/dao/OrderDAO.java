package com.ltw.dao;

import com.ltw.bean.OrderBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    public static List<OrderBean> findOrderByUserId(int userId){
    List<OrderBean> orderList = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, createdDate, shipToDate, total, status ")
                .append("FROM orders ")
                .append("WHERE userId = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                OrderBean order = new OrderBean();
                order.setId(resultSet.getInt("id"));
                order.setCreatedDate(resultSet.getTimestamp("createdDate"));
                order.setShipToDate(resultSet.getTimestamp("shipToDate"));
                order.setTotal(resultSet.getDouble("total"));
                order.setStatus(resultSet.getInt("status"));

                orderList.add(order);
            }
            return orderList;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;

        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
    }
}
