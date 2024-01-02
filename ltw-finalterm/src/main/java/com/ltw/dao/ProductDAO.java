package com.ltw.dao;

import com.ltw.bean.ImageBean;
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

public class ProductDAO {
    public ProductBean findProductById(int id) {

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, name, description, originalPrice, discountPrice, size, quantity, status")
                .append("FROM products")
                .append("WHERE id = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        ProductBean productDetailBean = null;
        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());
            SetParameterUtil.setParameter(preparedStatement, id);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                productDetailBean = new ProductBean();
                productDetailBean.setId(resultSet.getInt("id"));
                productDetailBean.setName(resultSet.getString("name"));
                productDetailBean.setDescription(resultSet.getString("description"));
                productDetailBean.setOriginalPrice(resultSet.getDouble("originalPrice"));
                productDetailBean.setDiscountPrice(resultSet.getDouble("discountPrice"));
                productDetailBean.setSize(resultSet.getString("size"));
                productDetailBean.setQuantity(resultSet.getInt("quantity"));
                productDetailBean.setStatus(resultSet.getInt("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return productDetailBean;

    }

    public List<ImageBean> findImagesByProductId(int productId) {
        List<ImageBean> imageBeans = new ArrayList<>();
        String query = "SELECT id, link FROM images WHERE productId = ?";

        Connection connection = null;
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, productId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ImageBean imageBean = new ImageBean();
                imageBean.setId(resultSet.getInt("id"));
                imageBean.setLink(resultSet.getString("link"));
                imageBeans.add(imageBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return imageBeans;
    }
}
