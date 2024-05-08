package com.ltw.service;

import com.ltw.bean.LogBean;
import com.ltw.dao.impl.LogDAO;
import com.ltw.dto.LogAddressDTO;
import com.ltw.util.TransferDataUtil;

import java.sql.Timestamp;
import java.util.ResourceBundle;

public class LogService {
    private LogDAO logDAO = new LogDAO();
    ResourceBundle logLevelBundle = ResourceBundle.getBundle("log-level");
    ResourceBundle requestMethodBundle = ResourceBundle.getBundle("request-method");
    ResourceBundle logContentBundle = ResourceBundle.getBundle("log-content");

    // Ghi log thông qua model
    public void createLog(String ip, String national, String level, int userId, String status, String previous, String current) {
        LogAddressDTO logObj = new LogAddressDTO("login", userId, logContentBundle.getString(status));
        // Ghi log
        LogBean log = new LogBean();
        log.setIp(ip);
        log.setNational(national);
        log.setLevel(Integer.parseInt(logLevelBundle.getString(level)));
        log.setAddress(new TransferDataUtil<LogAddressDTO>().toJson(logObj));
        log.setPreviousValue(previous);
        log.setCurrentValue(current);
        log.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        logDAO.create(log);
    }
}
