package com.ltw.dao;

import com.ltw.bean.WarehouseDetailBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;



public class WarehouseDetailDAO {

    public List<WarehouseDetailBean> findWarehouseDetailByWarehouseId(int warehouseId) {
        String sql = "SELECT id, warehouseId, productId, quantity FROM warehouse_details WHERE warehouseId = ?";
        List<WarehouseDetailBean> warehouseDetailList = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, warehouseId);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                WarehouseDetailBean warehouseDetailBean = new WarehouseDetailBean();
                warehouseDetailBean.setId(resultSet.getInt("id"));
                warehouseDetailBean.setWarehouseId(resultSet.getInt("warehouseId"));
                warehouseDetailBean.setProductId(resultSet.getInt("productId"));
                warehouseDetailBean.setQuantity(resultSet.getInt("quantity"));

                warehouseDetailList.add(warehouseDetailBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return warehouseDetailList;
    }
}