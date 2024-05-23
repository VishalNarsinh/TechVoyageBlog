package com.techvoyageblog.entities;

import java.sql.Timestamp;

public class Post {
    private int pId;
    private String pTitle;
    private String pContent;
    private String pCode;
    private String pImage;
    private Timestamp pDate;
    private Timestamp pLastEdited;
    private String pExternalLink;
    private int catId;
    private int userId;
    private String status;

    public Post() {
    }

    public Post(int pId, String pTitle, String pContent, String pCode, String pImage, Timestamp pDate, Timestamp pLastEdited, String pExternalLink, int catId, int userId,String status) {
        this.pId = pId;
        this.pTitle = pTitle;
        this.pContent = pContent;
        this.pCode = pCode;
        this.pImage = pImage;
        this.pDate = pDate;
        this.pLastEdited = pLastEdited;
        this.pExternalLink = pExternalLink;
        this.catId = catId;
        this.userId = userId;
        this.status = status;
    }

    public Post(String pTitle, String pContent, String pCode, String pImage, String pExternalLink, int catId, int userId) {
        this.pTitle = pTitle;
        this.pContent = pContent;
        this.pCode = pCode;
        this.pImage = pImage;
        this.pExternalLink = pExternalLink;
        this.catId = catId;
        this.userId = userId;
    }

    public Post(String pTitle, String pContent, String pCode, String pImage, int catId, int userId) {
        this.pTitle = pTitle;
        this.pContent = pContent;
        this.pCode = pCode;
        this.pImage = pImage;
        this.catId = catId;
        this.userId = userId;
    }


    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getpTitle() {
        return pTitle;
    }

    public void setpTitle(String pTitle) {
        this.pTitle = pTitle;
    }

    public String getpContent() {
        return pContent;
    }

    public void setpContent(String pContent) {
        this.pContent = pContent;
    }

    public String getpCode() {
        return pCode;
    }

    public void setpCode(String pCode) {
        this.pCode = pCode;
    }

    public String getpImage() {
        return pImage;
    }

    public void setpImage(String pImage) {
        this.pImage = pImage;
    }

    public Timestamp getpDate() {
        return pDate;
    }

    public void setpDate(Timestamp pDate) {
        this.pDate = pDate;
    }

    public String getpExternalLink() {
        return pExternalLink;
    }

    public void setpExternalLink(String pExternalLink) {
        this.pExternalLink = pExternalLink;
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }
    
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Timestamp getpLastEdited() {
        return pLastEdited;
    }

    public void setpLastEdited(Timestamp pLastEdited) {
        this.pLastEdited = pLastEdited;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
