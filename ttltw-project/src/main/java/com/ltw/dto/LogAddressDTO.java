package com.ltw.dto;

public class LogAddressDTO {
    private String function;
    private String email;
    private String content;

    public LogAddressDTO(String function, String email, String content) {
        this.function = function;
        this.email = email;
        this.content = content;
    }

    public String getFunction() {
        return function;
    }

    public void setFunction(String function) {
        this.function = function;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
