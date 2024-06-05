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
    public int createContact(ContactBean contactBean) {
        int id = -1;
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO contacts ")
                .append("(email, firstName, lastName, message, status)")
                .append(" VALUES ")
                .append("(?, ?, ?, ?, 1)");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            // Do đây là non-query (Non-query là INSERT, UPDATE, DELETE trong SQL) nên cần setAutoCommit(false)...
            connection.setAutoCommit(false);
            // Lấy ra id để trả về
            preparedStatement = connection.prepareStatement(sql.toString(), PreparedStatement.RETURN_GENERATED_KEYS);

            SetParameterUtil.setParameter(preparedStatement, contactBean.getEmail(), contactBean.getFirstName(),
                    contactBean.getLastName(), contactBean.getMessage());

            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                // Retrieve the generated keys
                resultSet = preparedStatement.getGeneratedKeys();

                if (resultSet.next()) {
                    // Get the generated ID
                    id = resultSet.getInt(1);
                }
            }// ... và commit ở đây...
            connection.commit();
        } catch (SQLException e) {
            try {
                // ... cũng như rollback khi bị lỗi SQL ở đây.
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return id;
    }

    public ContactBean findContactById(int id) {
        ContactBean contact = null;
        String sql = "SELECT id, email, firstName, lastName, title, message, status, createdDate, createdBy, modifiedDate, modifiedBy " +
                "FROM contacts " +
                "WHERE id = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, id);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                contact = new ContactBean();
                contact.setId(resultSet.getInt("id"));
                contact.setEmail(resultSet.getString("email"));
                contact.setFirstName(resultSet.getString("firstName"));
                contact.setLastName(resultSet.getString("lastName"));
                contact.setTitle(resultSet.getString("title"));
                contact.setMessage(resultSet.getString("message"));
                contact.setStatus(resultSet.getInt("status"));
                contact.setCreatedDate(resultSet.getTimestamp("createdDate"));
                contact.setCreatedBy(resultSet.getString("createdBy"));
                contact.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
                contact.setModifiedBy(resultSet.getString("modifiedBy"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return contact;
    }

    public List<ContactBean> findAllContacts() {
        String sql = "SELECT id, email, firstName, lastName, message, " +
                "status, createdDate, createdBy, modifiedDate, modifiedBy " +
                "FROM contacts";

        List<ContactBean> contactList = new ArrayList<>();
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        Connection connection = null;
        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ContactBean contactBean = new ContactBean();
                contactBean.setId(resultSet.getInt("id"));
                contactBean.setEmail(resultSet.getString("email"));
                contactBean.setFirstName(resultSet.getString("firstName"));
                contactBean.setLastName(resultSet.getString("lastName"));
                contactBean.setMessage(resultSet.getString("message"));
                contactBean.setStatus(resultSet.getInt("status"));
                contactBean.setCreatedDate(resultSet.getTimestamp("createdDate"));
                contactBean.setCreatedBy(resultSet.getString("createdBy"));
                contactBean.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
                contactBean.setModifiedBy(resultSet.getString("modifiedBy"));

                ContactBean ContactBean;
                contactList.add(contactBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return contactList;
    }

    public void updateContact(ContactBean contact) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE contacts ")
                .append("SET firstName = ?, lastName = ?, message = ?, status = ?, modifiedDate = ?, modifiedBy = ? ")
                .append("WHERE id = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());
            SetParameterUtil.setParameter(preparedStatement, contact.getFirstName(), contact.getLastName(),
                    contact.getMessage(), contact.getStatus(), contact.getModifiedDate(),
                    contact.getModifiedBy(), contact.getId());
            preparedStatement.executeUpdate();
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
    }

    public int deleteContact(int id) {
        int affectRows;
        String sql = "DELETE FROM contacts WHERE id = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, id);
            affectRows = preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
                return -1;
            } catch (SQLException ex) {
                ex.printStackTrace();
                return -1;
            }
        } finally {
            CloseResourceUtil.closeNotUseRS(preparedStatement, connection);
        }
        return affectRows;
    }
}
