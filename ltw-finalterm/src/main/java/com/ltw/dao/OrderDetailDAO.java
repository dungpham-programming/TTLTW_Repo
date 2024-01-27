package com.ltw.dao;

import com.ltw.bean.OrderDetailBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAO {

    public List<OrderDetailBean> findDetailByOrderId(String orderId) {
        String sql = "SELECT order_details.orderId, order_details.productId, products.name, products.originalPrice, " +
                "products.discountPrice, products.discountPercent, order_details.quantity " +
                "FROM order_details INNER JOIN products " +
                "ON order_details.productId = products.id " +
                "WHERE order_details.orderId = ?";
        List<OrderDetailBean> orderDetailList = new ArrayList<>();
        int orderIdConvert = Integer.parseInt(orderId);

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, orderIdConvert);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                OrderDetailBean orderDetailBean = new OrderDetailBean();
                orderDetailBean.setOrderId(resultSet.getInt("orderId"));
                orderDetailBean.setProductId(resultSet.getInt("productId"));
                orderDetailBean.setProductName(resultSet.getString("name"));
                orderDetailBean.setOriginalPrice(resultSet.getDouble("originalPrice"));
                orderDetailBean.setDiscountPrice(resultSet.getDouble("discountPrice"));
                orderDetailBean.setDiscountPercent(resultSet.getDouble("discountPercent"));
                orderDetailBean.setQuantity(resultSet.getInt("quantity"));

                orderDetailList.add(orderDetailBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return orderDetailList;
    }

    public int createOrderDetail(OrderDetailBean orderDetailBean) {
        int affected = -1;
        String sql = "INSERT INTO order_details (orderId, productId, quantity) " +
                "VALUES (?, ?, ?)";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, orderDetailBean.getOrderId(), orderDetailBean.getProductId(), orderDetailBean.getQuantity());
            affected = preparedStatement.executeUpdate();
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
        return affected;
    }
}