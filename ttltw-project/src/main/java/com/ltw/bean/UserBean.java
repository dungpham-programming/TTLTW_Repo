package com.ltw.bean;

import com.ltw.dao.impl.LogDAO;
import com.ltw.dto.LogAddressDTO;

import java.sql.Timestamp;
import java.util.ResourceBundle;

public class UserBean {
    private int id;
    private String email;
    private String password;
    private String firstName;
    private String lastName;
    private int roleId;
    private int status;
    private String verifiedCode;
    private String key;
    private String addressLine;
    private String addressWard;
    private String addressDistrict;
    private String addressProvince;
    private Timestamp createdDate;
    private String createdBy;
    private Timestamp modifiedDate;
    private String modifiedBy;
    private LogDAO logDAO = new LogDAO();
    ResourceBundle logLevelBundle = ResourceBundle.getBundle("log-level");
    ResourceBundle requestMethodBundle = ResourceBundle.getBundle("request-method");
    ResourceBundle logContentBundle = ResourceBundle.getBundle("log-content");

    public UserBean() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getVerifiedCode() {
        return verifiedCode;
    }

    public void setVerifiedCode(String verifiedCode) {
        this.verifiedCode = verifiedCode;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getAddressLine() {
        return addressLine;
    }

    public void setAddressLine(String addressLine) {
        this.addressLine = addressLine;
    }

    public String getAddressWard() {
        return addressWard;
    }

    public void setAddressWard(String addressWard) {
        this.addressWard = addressWard;
    }

    public String getAddressDistrict() {
        return addressDistrict;
    }

    public void setAddressDistrict(String addressDistrict) {
        this.addressDistrict = addressDistrict;
    }

    public String getAddressProvince() {
        return addressProvince;
    }

    public void setAddressProvince(String addressProvince) {
        this.addressProvince = addressProvince;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Timestamp getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Timestamp modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public String getModifiedBy() {
        return modifiedBy;
    }

    public void setModifiedBy(String modifiedBy) {
        this.modifiedBy = modifiedBy;
    }

    // Ghi log thông qua model
    public void loginLog(String ip, String national, String level, String requestMethod, String status, String previous, String current) {
        // Ghi log
        LogBean log = new LogBean();
        log.setIp(ip);
        log.setNational(national);
        log.setLevel(Integer.parseInt(logLevelBundle.getString(level)));
        log.setRequestMethod(Integer.parseInt(requestMethodBundle.getString(requestMethod)));
        log.setAddress(new LogAddressDTO("login", email, logContentBundle.getString(status)));
        log.setPreviousValue(previous);
        log.setCurrentValue(current);
        log.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        logDAO.create(log);
    }
}