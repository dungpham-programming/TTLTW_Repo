package com.ltw.dao;


import com.ltw.bean.OrderDetailBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public List<OrderDetailBean> findOrderDetailByOrderId(int orderId) {
        List<OrderDetailBean> result = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT order_details.productId, products.name, products.originalPrice, products.discountPrice, order_details.quantity ")
                .append("FROM order_details ")
                .append("INNER JOIN products ON order_details.productId = products.id ")
                .append("WHERE order_details.orderId = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());
            preparedStatement.setInt(1, orderId);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                OrderDetailBean orderDetail = new OrderDetailBean();
                orderDetail.setProductId(resultSet.getInt("productId"));
                orderDetail.setProductName(resultSet.getString("name"));
                orderDetail.setOriginalPrice(resultSet.getDouble("originalPrice"));
                orderDetail.setDiscountPrice(resultSet.getDouble("discountPrice"));
                orderDetail.setQuantity(resultSet.getInt("quantity"));

                result.add(orderDetail);
            }
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
    }
}
