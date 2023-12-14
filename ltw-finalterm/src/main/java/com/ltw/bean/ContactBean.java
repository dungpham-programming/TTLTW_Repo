package com.ltw.bean;

import java.sql.Timestamp;

public class ContactBean {
    private int id;
    private String email;
    private String title;
    private String message;
    private int status;
    private Timestamp createdDate;
    private String cratedBy;
    private Timestamp modifiedDate;
    private String modifiedBy;

    public ContactBean() {
    }

    public int getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getTitle() {
        return title;
    }

    public String getMessage() {
        return message;
    }

    public int getStatus() {
        return status;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public String getCratedBy() {
        return cratedBy;
    }

    public Timestamp getModifiedDate() {
        return modifiedDate;
    }

    public String getModifiedBy() {
        return modifiedBy;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public void setCratedBy(String cratedBy) {
        this.cratedBy = cratedBy;
    }

    public void setModifiedDate(Timestamp modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public void setModifiedBy(String modifiedBy) {
        this.modifiedBy = modifiedBy;
    }
}
