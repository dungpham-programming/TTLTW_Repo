package com.ltw.dao;

import com.ltw.bean.UserBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    // Tìm danh sách người dùng theo email
    public int findIdByEmail(String email) {
        int id = -1;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id FROM users ")
                .append("WHERE email = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, email);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                id = resultSet.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return id;
    }

    // Kiểm tra xem tài khoản đã được active chưa
    public boolean isActiveAccount(String email) {
        int status = -1;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT status FROM users ")
                .append("WHERE email = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql.toString());

            // Set the email parameter
            SetParameterUtil.setParameter(preparedStatement, email);

            // Execute the query
            resultSet = preparedStatement.executeQuery();

            // Check if the result set has a row
            if (resultSet.next()) {
                status = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            // Handle the exception (log it or throw a custom exception)
            e.printStackTrace(); // Example, you should handle this appropriately in your application
        } finally {
            // Close resources in the finally block
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        // Check if the status indicates email verification (you can adjust this condition)
        return status == 1;
    }

    // Tạo tài khoản mới (Thông qua đăng ký của client)
    public int createInRegister(UserBean user) {
        int id = 0;
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO users ")
                .append("(email, password, roleId, status, verifiedCode)")
                .append(" VALUES ")
                .append("(?, ?, 2, 2, ?)");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);

            SetParameterUtil.setParameter(preparedStatement, user.getEmail(), user.getPassword(), user.getVerifiedCode());

            preparedStatement.executeUpdate();
            resultSet = preparedStatement.getGeneratedKeys();

            if (resultSet.next()) {
                id = resultSet.getInt(1);
            }
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            return 0;
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return id;
    }

    // Lấy lên id dựa vào verifiedCode (Để kiểm tra tính hợp lệ của code)
    public int checkVerifiedCode(String verifiedCode) {
        int result = 0;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id FROM users ")
                .append("WHERE verifiedCode = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, verifiedCode);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                result = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            return 0;
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return result;
    }

    // Set verifiedCode mới khi người dùng yêu cầu
    public void setNewVerifiedCode(int id, String verifiedCode) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE users ")
                .append("SET verifiedCode = ? ")
                .append("WHERE id = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, verifiedCode, id);
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

    // Set code bằng chuỗi rỗng (Sau khi đã xác thực thành công)
    public void setEmptyCode(int id) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE users ")
                .append("SET verifiedCode = '' ")
                .append("WHERE id = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, id);
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

    // Lưu verifiedCode vào tài khoản có email tương ứng
    public void saveNewCodeByEmail(String email, String verifiedCode) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE users ")
                .append("SET verifiedCode = ? ")
                .append("WHERE email = ?");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql.toString());

            SetParameterUtil.setParameter(preparedStatement, verifiedCode, email);
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
}