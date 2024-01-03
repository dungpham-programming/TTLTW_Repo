package com.ltw.bean;
import com.mysql.cj.jdbc.Blob;

import java.sql.Timestamp;

public class BlogBean {
    private int id;
    private String title;
    private String author;
    private String description;
    private String content;
    private int categoryId;
    private int status;
    private Timestamp createdDate;
    private String cratedBy;
    private Timestamp modifiedDate;
    private String modifiedBy;
    private Blob profilePic;

    public BlogBean() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public String getCratedBy() {
        return cratedBy;
    }

    public void setCratedBy(String cratedBy) {
        this.cratedBy = cratedBy;
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
    public Blob getProfilePic(java.sql.Blob profilePic) {
        return this.profilePic;
    }
    public void setProfilePic(Blob profilePic) {
        this.profilePic = profilePic;
    }

}
