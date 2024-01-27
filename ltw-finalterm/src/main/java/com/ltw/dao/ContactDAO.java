package com.ltw.dao;

import com.ltw.bean.ContactBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ContactDAO {
    public void createContact(ContactBean contactBean) {
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO users ")
                .append("(email, firstName, lastName, message, status)")
                .append(" VALUES ")
                .append("(?, ?, ?, ?, 1)");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            // Do đây là non-query (Non-query là INSERT, UPDATE, DELETE trong SQL) nên cần setAutoCommit(false)...
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, contactBean.getEmail(), contactBean.getFirstName(),
                    contactBean.getLastName(), contactBean.getMessage());

            preparedStatement.executeUpdate();
            // ... và commit ở đây...
            connection.commit();
        } catch (SQLException e) {
            try {
                // ... cũng như rollback khi bị lỗi SQL ở đây.
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
    }
}
