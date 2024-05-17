package com.ltw.dao.impl;

import com.ltw.bean.LogBean;
import com.ltw.dao.intf.IDaoNonUpdate;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class LogDAO implements IDaoNonUpdate<LogBean> {
    @Override
    public List<LogBean> getAll() {
        return null;
    }

    @Override
    public int create(LogBean logBean) {
        int record = -1;
        String sql = "INSERT INTO logs (ip, national, level, address, " +
                "previousValue, currentValue, createdDate) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, logBean.getIp(), logBean.getNational(), logBean.getLevel(),
                    logBean.getAddress(), logBean.getPreviousValue(), logBean.getCurrentValue(), logBean.getCreatedDate());
            record = preparedStatement.executeUpdate();
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
        return record;
    }

    @Override
    public int delete(int[] ids) {
        return 0;
    }
}
