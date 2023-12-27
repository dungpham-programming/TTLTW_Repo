package com.ltw.dao;

import com.ltw.bean.ProductDetailBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductDetailDAO {
    public ProductDetailBean findProductById(int id) {

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, name, description, originalPrice, discountPrice, size, quantity, status")
                .append("FROM products")
                .append("WHERE id = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());
            SetParameterUtil.setParameter(preparedStatement, id);
            resultSet = preparedStatement.executeQuery();

            ProductDetailBean productDetailBean= new ProductDetailBean();
            productDetailBean.setId(resultSet.getInt("id"));
            productDetailBean.setProductName(resultSet.getString("name"));
            productDetailBean.setDescription(resultSet.getString("description"));
            productDetailBean.setOriginalPrice(resultSet.getDouble("originalPrice"));
            productDetailBean.setDiscountPrice(resultSet.getDouble("discountPrice"));
            productDetailBean.setSize(resultSet.getString("size"));
            productDetailBean.setQuatity(resultSet.getInt("quantity"));
            productDetailBean.setStatus(resultSet.getInt("status"));

            return productDetailBean;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
    }


}
