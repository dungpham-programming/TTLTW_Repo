package com.ltw.service;

import com.ltw.bean.LogBean;
import com.ltw.dao.impl.LogDAO;
import com.ltw.dto.LogAddressDTO;
import com.ltw.util.TransferDataUtil;

import java.sql.Timestamp;
import java.util.ResourceBundle;

public class LogService<T> {
    private LogDAO logDAO = new LogDAO();
    ResourceBundle logLevelBundle = ResourceBundle.getBundle("log-level");

    // Ghi log thông qua model
    // previous và current có thể truyền một model hoặc List của model đó, việc ghi vào JSON đã xử lý riêng trong TransferDataUtil
    public void createLog(String ip, String national, String level, LogAddressDTO logObj, Object previousObj, Object currentObj) {
        // Validate các Object được truyền vào
        String address = (logObj == null ? null : new TransferDataUtil<LogAddressDTO>().toJson(logObj));
        String previousValue = (previousObj == null ? null : new TransferDataUtil<T>().toJson(previousObj));
        String currentValue = (currentObj == null ? null : new TransferDataUtil<T>().toJson(currentObj));

        // Ghi log
        LogBean log = new LogBean();
        log.setIp(ip);
        log.setNational(national);
        log.setLevel(Integer.parseInt(logLevelBundle.getString(level)));
        // Chuyển đổi các Object sang JSON
        log.setAddress(address);
        log.setPreviousValue(previousValue);
        log.setCurrentValue(currentValue);
        log.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        logDAO.create(log);
    }
}
