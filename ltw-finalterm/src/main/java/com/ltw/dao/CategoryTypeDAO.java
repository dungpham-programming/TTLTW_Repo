package com.ltw.dao;

import com.ltw.bean.CategoryBean;
import com.ltw.bean.CategoryTypeBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryTypeDAO {
    public List<CategoryTypeBean> findCategoryTypeByCategoryId(int categoryId) {
        List<CategoryTypeBean> categoryTypes = new ArrayList<>();
        String sql = "SELECT id, name, categoryId, idOnBrowser FROM category_types WHERE categoryId = ? AND status = 1";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, categoryId);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                CategoryTypeBean categoryType = new CategoryTypeBean();
                categoryType.setId(resultSet.getInt("id"));
                categoryType.setName((resultSet.getString("name")));
                categoryType.setCategoryId(resultSet.getInt("categoryId"));
                categoryType.setIdOnBrowser(resultSet.getString("idOnBrowser"));

                categoryTypes.add(categoryType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return categoryTypes;
    }
}
