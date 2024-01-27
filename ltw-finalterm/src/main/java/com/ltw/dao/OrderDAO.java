package com.ltw.dao;

import com.ltw.bean.OrderBean;
import com.ltw.bean.OrderDetailBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.*;

import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public List<OrderDetailBean> findOrderDetailByOrderId(int orderId) {
        List<OrderDetailBean> result = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT order_details.orderId, order_details.productId, products.name, products.originalPrice, products.discountPrice, order_details.quantity ")
                .append("FROM order_details ")
                .append("INNER JOIN products ON order_details.productId = products.id ")
                .append("WHERE order_details.orderId = ?");
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());
            SetParameterUtil.setParameter(preparedStatement, orderId);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                OrderDetailBean orderDetail = new OrderDetailBean();
                orderDetail.setOrderId(resultSet.getInt("orderId"));
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
            SetParameterUtil.setParameter(preparedStatement, userId);
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
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
      return orderList;
    }
          
    public List<OrderBean> findAllOrders() {
        String sql = "SELECT id, userId, total, paymentMethod, status, shipToDate, createdDate, createdBy, modifiedDate, modifiedBy " +
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
                orderBean.setPaymentMethod(resultSet.getString("paymentMethod"));
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
        String sql = "SELECT userId, total, paymentMethod, status, shipToDate, createdDate, createdBy, modifiedDate, modifiedBy " +
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
                order.setPaymentMethod(resultSet.getString("paymentMethod"));
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

    public int createOrder(OrderBean orderBean) {
        int id = -1;
        String sql = "INSERT INTO orders (userId, createdDate, shipToDate, " +
                "total, paymentMethod, status, createdBy, modifiedDate, modifiedBy) " +
                "VALUES (?, ?, ?, ?, ?, 1, ?, ?, ?)";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            SetParameterUtil.setParameter(preparedStatement, orderBean.getUserId(), orderBean.getCreatedDate(), orderBean.getShipToDate(),
                                                            orderBean.getTotal(), orderBean.getPaymentMethod(), orderBean.getCreatedBy(),
                                                            orderBean.getModifiedDate(), orderBean.getModifiedBy());
            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) {
                // Retrieve the generated keys
                resultSet = preparedStatement.getGeneratedKeys();

                if (resultSet.next()) {
                    // Get the generated ID
                    id = resultSet.getInt(1);
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
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
        return id;
    }

    public int cancelOrder(String orderId) {
        int affected = -1;
        String sql = "UPDATE orders " +
                "SET status = 0 " +
                "WHERE id = ? AND status NOT IN (0, 3, 4)";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, orderId);
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