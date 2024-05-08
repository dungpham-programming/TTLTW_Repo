package com.ltw.bean;

import java.sql.Timestamp;

public class LogBean {
    private int id;
    private String ip;
    private String national;
    private int level;
    private String address;
    private String previousValue;
    private String currentValue;
    private Timestamp createdDate;

    public LogBean() {

    }

    public LogBean(String ip, String national, int level, String address, String previousValue, String currentValue) {
        this.ip = ip;
        this.national = national;
        this.level = level;
        this.address = address;
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

    public void setAddress() {
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

    public void setAddress(String address) {
        this.address = address;
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
