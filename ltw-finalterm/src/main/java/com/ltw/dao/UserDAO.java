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
    public List<Integer> findIdByEmail(String email) {
        List<Integer> result = new ArrayList<>();
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
                result.add(resultSet.getInt(1));
            }
            return result;
        } catch (SQLException e) {
            return null;
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
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
            return id;
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
            return result;
        } catch (SQLException e) {
            return 0;
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
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
}