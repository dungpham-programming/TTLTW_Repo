package com.ltw.dao;

import com.ltw.bean.UserBean;
import com.ltw.bean.WarehouseBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;

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

}
