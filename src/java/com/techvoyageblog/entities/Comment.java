/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techvoyageblog.entities;

/**
 *
 * @author vishal
 */

public class Comment {
    private int com_id;
    private String content;
    private int pid;
    private int uid;

    public Comment() {
    }

    public Comment(int com_id, String content, int pid, int uid) {
        this.com_id = com_id;
        this.content = content;
        this.pid = pid;
        this.uid = uid;
    }

    public Comment(String content, int pid, int uid) {
        this.content = content;
        this.pid = pid;
        this.uid = uid;
    }

    public int getCom_id() {
        return com_id;
    }

    public void setCom_id(int com_id) {
        this.com_id = com_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }
    
}
