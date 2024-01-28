package com.ltw.dao;

import com.ltw.bean.OrderDetailBean;
import com.ltw.bean.ProductBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
}
