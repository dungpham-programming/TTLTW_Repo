package com.ltw.dao;

import com.ltw.bean.AccountBean;
import com.ltw.util.CloseResourceUtil;
import com.ltw.util.OpenConnectionUtil;
import com.ltw.util.SetParameterUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AccountDAO {
    public static List<AccountBean> findAllAccounts() {
        String sql = "SELECT userName, password, firstName, lastName, roleId, " +
                ", email, addressLine, addressWard, addressDistrict, verifiedCode, status, " +
                "createdDate, createdBy, modifiedDate, modifiedBy" +
                "FROM users";

        List<AccountBean> accountList = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                AccountBean accountBean = new AccountBean();
                accountBean.setUserName(resultSet.getString("userName"));
                accountBean.setPassword(resultSet.getString("password"));
                accountBean.setFirstName(resultSet.getString("firstName"));
                accountBean.setLastName(resultSet.getString("lastName"));
                accountBean.setRoleId(resultSet.getInt("roleId"));
                accountBean.setEmail(resultSet.getString("email"));
                accountBean.setAddressLine(resultSet.getString("addressLine"));
                accountBean.setAddressWard(resultSet.getString("addressWard"));
                accountBean.setAddressDistrict(resultSet.getString("addressDistrict"));
                accountBean.setVerifiedCode(resultSet.getString("verifiedCode"));
                accountBean.setStatus(resultSet.getInt("status"));
                accountBean.setCreatedDate(resultSet.getTimestamp("createdDate"));
                accountBean.setCreatedBy(resultSet.getString("createdBy"));
                accountBean.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
                accountBean.setModifiedBy(resultSet.getString("modifiedBy"));

                accountList.add(accountBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return accountList;
    }

    public static AccountBean findAccountById(int id) {
        AccountBean account = null;
        String sql =  "SELECT id, userName, password, firstName, lastName, roleId, " +
                ", email, addressLine, addressWard, addressDistrict, verifiedCode, status, " +
                "createdDate, createdBy, modifiedDate, modifiedBy " +
                "FROM users " +
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
                account = new AccountBean();
                account.setId(resultSet.getInt("id"));
                account.setUserName(resultSet.getString("userName"));
                account.setPassword(resultSet.getString("password"));
                account.setFirstName(resultSet.getString("firstName"));
                account.setLastName(resultSet.getString("lastName"));
                account.setRoleId(resultSet.getInt("roleId"));
                account.setEmail(resultSet.getString("email"));
                account.setAddressLine(resultSet.getString("addressLine"));
                account.setAddressWard(resultSet.getString("addressWard"));
                account.setAddressDistrict(resultSet.getString("addressDistrict"));
                account.setVerifiedCode(resultSet.getString("verifiedCode"));
                account.setStatus(resultSet.getInt("status"));
                account.setCreatedDate(resultSet.getTimestamp("createdDate"));
                account.setCreatedBy(resultSet.getString("createdBy"));
                account.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
                account.setModifiedBy(resultSet.getString("modifiedBy"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseResourceUtil.closeResource(resultSet, preparedStatement, connection);
        }
        return account;
    }

    public void updateAccount(AccountBean accountBean) {
        String sql = "UPDATE accounts " +
                "SET userName = ?, password = ?, firstName = ?, lastName = ?, roleId = ?, " +
                "email = ?, addressLine = ?, addressWard = ?, addressDistrict = ?, verifiedCode = ?, status = ? " +
                "WHERE id = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, accountBean.getUserName(), accountBean.getPassword(), accountBean.getFirstName(),
                    accountBean.getLastName(), accountBean.getRoleId(), accountBean.getEmail(), accountBean.getAddressLine(),
                    accountBean.getAddressWard(), accountBean.getAddressDistrict(), accountBean.getVerifiedCode(), accountBean.getStatus(), accountBean.getId());
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

    public void createAccount(AccountBean accountBean) {
        String sql = "INSERT INTO users (userName, password, firstName, lastName, roleId, " +
                "email, addressLine, addressWard, addressDistrict, verifiedCode, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = OpenConnectionUtil.openConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(sql);
            SetParameterUtil.setParameter(preparedStatement, accountBean.getUserName(), accountBean.getPassword(), accountBean.getFirstName(),
                    accountBean.getLastName(), accountBean.getRoleId(), accountBean.getEmail(), accountBean.getAddressLine(),
                    accountBean.getAddressWard(), accountBean.getAddressDistrict(), accountBean.getVerifiedCode(), accountBean.getStatus());
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

    public int deleteAccount(int id) {
        int affectRows;
        String sql = "DELETE FROM users WHERE id = ?";

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

