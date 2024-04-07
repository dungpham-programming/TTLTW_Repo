package com.ltw.bean;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ltw.dto.LogAddressDTO;

import java.sql.Timestamp;

public class LogBean {
    private int id;
    private String ip;
    private String national;
    private int level;
    private String address;
    private int requestMethod;
    private String previousValue;
    private String currentValue;
    private Timestamp createdDate;

    public LogBean() {

    }

    public LogBean(String ip, String national, int level, String address, int requestMethod, String previousValue, String currentValue) {
        this.ip = ip;
        this.national = national;
        this.level = level;
        this.address = address;
        this.requestMethod = requestMethod;
        this.previousValue = previousValue;
        this.currentValue = currentValue;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getNational() {
        return national;
    }

    public void setNational(String national) {
        this.national = national;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(LogAddressDTO address) {
        // Chuyển đổi từ Object sang JSON
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            this.address = objectMapper.writeValueAsString(address);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    public int getRequestMethod() {
        return requestMethod;
    }

    public void setRequestMethod(int requestMethod) {
        this.requestMethod = requestMethod;
    }

    public String getPreviousValue() {
        return previousValue;
    }

    public void setPreviousValue(String previousValue) {
        this.previousValue = previousValue;
    }

    public String getCurrentValue() {
        return currentValue;
    }

    public void setCurrentValue(String currentValue) {
        this.currentValue = currentValue;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }
}
