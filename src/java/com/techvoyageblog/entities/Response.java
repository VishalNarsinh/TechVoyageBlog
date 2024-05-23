/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techvoyageblog.entities;

import java.sql.Timestamp;

public class Response {

    private int id;
    private String email;
    private String subject;
    private String content;
    private Timestamp time;

    public Response() {
    }

    public Response(int id, String email, String subject, String content, Timestamp time) {
        this.id = id;
        this.email = email;
        this.subject = subject;
        this.content = content;
        this.time = time;
    }

    public Response(String email, String subject, String content) {
        this.email = email;
        this.subject = subject;
        this.content = content;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }
    
    
}
