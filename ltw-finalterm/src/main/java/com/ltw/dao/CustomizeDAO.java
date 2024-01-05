package com.ltw.dao;

import com.ltw.bean.CustomizeBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class CustomizeDAO {
    public CustomizeBean getCustomizeInfo() {
        CustomizeBean customizeBean = null;
        return customizeBean;
    }

    public int updateCustomize(CustomizeBean customizeBean) {
        int afffectRows = -1;
        String sql = "UPDATE customize_pages SET welcomeTitle = ?, welcomeDes = ?, " +
                            "productTitle = ?, productDes = ?, " +
                            "prTitle1 = ?, prContent1 = ?, prDes1 = ?, prIcon1 = ?, prLink1 = ?, " +
                            "prTitle2 = ?, prContent2 = ?, prDes2 = ?, prLink2 = ?, " +
                            "background = ?, footerLeft = ?, footerMiddle = ?, facebookLink = ?, " +
                            "twitterLink = ?, instagramLink = ?, linkedinLink = ? " +
                      "WHERE id = 1";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            SetParameterUtil.setParameter(preparedStatement, customizeBean.getWelcomeTitle(), customizeBean.getWelcomeDes(),
                                            customizeBean.getProductTitle(), customizeBean.getProductDes(),
                    customizeBean.getPrTitle1(), customizeBean.getPrContent1(), customizeBean.getPrDes1(), customizeBean.getPrIcon1(), customizeBean.getPrLink1(),
                    customizeBean.getPrTitle2(), customizeBean.getPrContent2(), customizeBean.getPrDes2(), customizeBean.getPrLink2(),
                    customizeBean.getBackground(), customizeBean.getFooterLeft(), customizeBean.getFooterMiddle(), customizeBean.getFacebookLink(),
                    customizeBean.getTwitterLink(), customizeBean.getInstagramLink(), customizeBean.getLinkedinLink());

            afffectRows = preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
                return -1;
            } catch (SQLException ex) {
                e.printStackTrace();
                return -1;
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
        return afffectRows;
    }

    public int createCustomize(CustomizeBean customizeBean) {
        int afffectRows = -1;
        String sql = "INSERT INTO customize_pages (welcomeTitle, welcomeDes, productTitle, productDes, " +
                "prTitle1, prContent1, prDes1, prIcon1, prLink1, prTitle2, prContent2, prDes2, prLink2, " +
                "background, footerLeft, footerMiddle, facebookLink, twitterLink, instagramLink, linkedinLink) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";


        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            SetParameterUtil.setParameter(preparedStatement, customizeBean.getWelcomeTitle(), customizeBean.getWelcomeDes(),
                    customizeBean.getProductTitle(), customizeBean.getProductDes(),
                    customizeBean.getPrTitle1(), customizeBean.getPrContent1(), customizeBean.getPrDes1(), customizeBean.getPrIcon1(), customizeBean.getPrLink1(),
                    customizeBean.getPrTitle2(), customizeBean.getPrContent2(), customizeBean.getPrDes2(), customizeBean.getPrLink2(),
                    customizeBean.getBackground(), customizeBean.getFooterLeft(), customizeBean.getFooterMiddle(), customizeBean.getFacebookLink(),
                    customizeBean.getTwitterLink(), customizeBean.getInstagramLink(), customizeBean.getLinkedinLink());

            afffectRows = preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
                return -1;
            } catch (SQLException ex) {
                e.printStackTrace();
                return -1;
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
        return afffectRows;
    }
}
