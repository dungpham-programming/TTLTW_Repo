package com.ltw.dao;

import com.ltw.bean.UserBean;
import com.ltw.bean.WarehouseBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WarehouseDAO {
    public static List<WarehouseBean> findAllWarehouses() {
        String sql = "SELECT id, shippingFrom, shippingStart, shippingDone, " +
                "description, createdDate, createdBy"+
                "FROM warehouses";

        List<WarehouseBean> warehouseList = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                WarehouseBean warehouseBean = new WarehouseBean();
                warehouseBean.setId(resultSet.getInt("id"));
                warehouseBean.setShippingFrom(resultSet.getString("shippingFrom"));
                warehouseBean.setShippingStart(resultSet.getTimestamp("shippingStart"));
                warehouseBean.setShippingDone(resultSet.getTimestamp("shippingDone"));
                warehouseBean.setDescription(resultSet.getString("description"));
                warehouseBean.setCreatedDate(resultSet.getTimestamp("createdDate"));
                warehouseBean.setCreatedBy(resultSet.getString("createdBy"));

                warehouseList.add(warehouseBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return warehouseList;
    }

    public int createWarehouse(WarehouseBean warehouseBean) {
        int id = -1;
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO warehouses ")
                .append("(shippingFrom, shippingStart, shippingDone, description, createdDate, createdBy) ")
                .append("VALUES (?, ?, ?, ?, ?, ?)");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString(), PreparedStatement.RETURN_GENERATED_KEYS);

            SetParameterUtil.setParameter(preparedStatement, warehouseBean.getShippingFrom(), warehouseBean.getShippingStart(),
                    warehouseBean.getShippingDone(), warehouseBean.getDescription(), warehouseBean.getCreatedDate(),
                    warehouseBean.getCreatedBy());

            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                resultSet = preparedStatement.getGeneratedKeys();
                if (resultSet.next()) {
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
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return id;
    }

    public WarehouseBean findWarehouseById(int id) {
        WarehouseBean warehouse = null;
        String sql = "SELECT id, shippingFrom, shippingStart, shippingDone, description, createdDate, createdBy " +
                "FROM warehouses WHERE id = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, id);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                warehouse = new WarehouseBean();
                warehouse.setId(resultSet.getInt("id"));
                warehouse.setShippingFrom(resultSet.getString("shippingFrom"));
                warehouse.setShippingStart(resultSet.getTimestamp("shippingStart"));
                warehouse.setShippingDone(resultSet.getTimestamp("shippingDone"));
                warehouse.setDescription(resultSet.getString("description"));
                warehouse.setCreatedDate(resultSet.getTimestamp("createdDate"));
                warehouse.setCreatedBy(resultSet.getString("createdBy"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return warehouse;
    }

    public void updateWarehouse(WarehouseBean warehouse) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE warehouses SET shippingFrom = ?, shippingStart = ?, shippingDone = ?, description = ?, createdDate = ?, createdBy = ? WHERE id = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());
            SetParameterUtil.setParameter(preparedStatement, warehouse.getShippingFrom(), warehouse.getShippingStart(),
                    warehouse.getShippingDone(), warehouse.getDescription(), warehouse.getCreatedDate(),
                    warehouse.getCreatedBy(), warehouse.getId());
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

    public int deleteWarehouse(int id) {
        int affectRows;
        String sql = "DELETE FROM warehouses WHERE id = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, id);
            affectRows = preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
                return -1;
            } catch (SQLException ex) {
                ex.printStackTrace();
                return -1;
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
        return affectRows;
    }
}
