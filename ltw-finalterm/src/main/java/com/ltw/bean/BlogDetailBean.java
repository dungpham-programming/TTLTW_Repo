package com.ltw.bean;
import java.sql.Blob;
import java.sql.Timestamp;

public class BlogDetailBean {
    private int id;
    private String title;
    private Blob profilePic;
    private String content;
    private int categoryId;
    private Timestamp createdDate;

    public BlogDetailBean() {
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
    public Blob getProfilePic() {
        return profilePic;
    }
    public void setProfilePic(Blob profilePic) {
        this.profilePic = profilePic;
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
    public Timestamp getCreatedDate() {
        return createdDate;
    }
    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }
    }
