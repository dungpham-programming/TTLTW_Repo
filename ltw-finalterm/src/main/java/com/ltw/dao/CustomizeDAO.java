package com.ltw.dao;

import com.ltw.bean.CategoryBean;
import com.ltw.bean.CustomizeBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomizeDAO {
    public CustomizeBean getCustomizeInfo() {
        CustomizeBean customizeBean = null;
        String sql = "SELECT id, welcomeTitle, welcomeDes, productTitle, productDes, " +
                        "prTitle1, prDes1, prContent1, prIcon1, prLink1, " +
                        "prTitle2, prDes2, prContent2, prIcon2, prLink2, " +
                        "background, footerLeft, footerMiddle, facebookLink, " +
                        "twitterLink, instagramLink, linkedinLink " +
                     "FROM customize_pages";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                customizeBean.setId(resultSet.getInt("id"));
                customizeBean.setWelcomeTitle(resultSet.getString("title"));
                customizeBean.setWelcomeDes(resultSet.getString("welcomeDes"));
                customizeBean.setProductTitle(resultSet.getString("productTitle"));
                customizeBean.setProductDes(resultSet.getString("productDes"));
                customizeBean.setPrTitle1(resultSet.getString("prTitle1"));
                customizeBean.setPrDes1(resultSet.getString("prDes1"));
                customizeBean.setPrContent1(resultSet.getString("prContent1"));
                customizeBean.setPrIcon1(resultSet.getString("prIcon1"));
                customizeBean.setPrLink1(resultSet.getString("prLink1"));
                customizeBean.setPrTitle2(resultSet.getString("prTitle2"));
                customizeBean.setPrDes2(resultSet.getString("prDes2"));
                customizeBean.setPrContent2(resultSet.getString("prContent2"));
                customizeBean.setPrIcon2(resultSet.getString("prIcon2"));
                customizeBean.setPrLink2(resultSet.getString("prLink2"));
                customizeBean.setBackground(resultSet.getString("background"));
                customizeBean.setFooterLeft(resultSet.getString("footerLeft"));
                customizeBean.setFooterMiddle(resultSet.getString("footerMiddle"));
                customizeBean.setFacebookLink(resultSet.getString("facebookLink"));
                customizeBean.setTwitterLink(resultSet.getString("twitterLink"));
                customizeBean.setInstagramLink(resultSet.getString("instagramLink"));
                customizeBean.setLinkedinLink(resultSet.getString("linkedinLink"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return customizeBean;
    }
}
