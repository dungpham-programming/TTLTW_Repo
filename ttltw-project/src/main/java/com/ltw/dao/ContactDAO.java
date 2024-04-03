package com.ltw.dao;

import com.ltw.bean.ContactBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ContactDAO {
    public void createContact(ContactBean contactBean) {
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO contacts ")
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
    public List<ContactBean> findAllContacts() {
        List<ContactBean> contacts = new ArrayList<>();
        String sql = "SELECT id, email, firstName, lastName, message, " +
                "status, createdDate, createdBy, modifiedDate, modifiedBy " +
                "FROM contact";

        try (Connection connection = OpenConnectionUtil.openConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                ContactBean contact = new ContactBean();
                contact.setId(resultSet.getInt("id"));
                contact.setEmail(resultSet.getString("email"));
                contact.setFirstName(resultSet.getString("firstName"));
                contact.setLastName(resultSet.getString("lastName"));
                contact.setMessage(resultSet.getString("message"));
                contact.setStatus(resultSet.getInt("status"));
                contact.setCreatedDate(resultSet.getTimestamp("createdDate"));
                contact.setCreatedBy(resultSet.getString("createdBy"));
                contact.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
                contact.setModifiedBy(resultSet.getString("modifiedBy"));

                contacts.add(contact);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return contacts;
    }
}
