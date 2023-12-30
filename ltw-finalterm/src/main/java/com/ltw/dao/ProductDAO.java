package com.ltw.dao;

import com.ltw.bean.CategoryBean;
import com.ltw.bean.ImageBean;
import com.ltw.bean.ProductBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    public List<ProductBean> findAllProducts() {
        String sql = "SELECT id, name, description, categoryTypeId, originalPrice, discountPrice, " +
                "discountPercent, quantity, size, otherSpec, keyword, status, " +
                "createdDate, createdBy, modifiedDate, modifiedBy " +
                "FROM products";

        List<ProductBean> productList = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ProductBean productBean = new ProductBean();
                productBean.setId(resultSet.getInt("id"));
                productBean.setName(resultSet.getString("name"));
                productBean.setDescription(resultSet.getString("description"));
                productBean.setCategoryTypeId(resultSet.getInt("categoryTypeId"));
                productBean.setOriginalPrice(resultSet.getDouble("originalPrice"));
                productBean.setDiscountPrice(resultSet.getDouble("discountPrice"));
                productBean.setDiscountPercent(resultSet.getDouble("discountPercent"));
                productBean.setQuantity(resultSet.getInt("quantity"));
                productBean.setSize(resultSet.getString("size"));
                productBean.setOtherSpec(resultSet.getString("otherSpec"));
                productBean.setKeyword(resultSet.getString("keyword"));
                productBean.setStatus(resultSet.getInt("status"));
                productBean.setCreatedDate(resultSet.getTimestamp("createdDate"));
                productBean.setCreatedBy(resultSet.getString("createdBy"));
                productBean.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
                productBean.setModifiedBy(resultSet.getString("modifiedBy"));

                productList.add(productBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return productList;
    }
}
