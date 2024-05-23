/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techvoyageblog.dao;

/**
 *
 * @author vishal
 */
import com.techvoyageblog.entities.ContactMessage;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class MessageDao {
    private Connection con;

    public MessageDao(Connection con) {
        this.con = con;
    }
    public boolean saveMessage(ContactMessage message){
        boolean flag=false;
        try {
            String query = "insert into messages (email,subject,content) values (?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, message.getEmail());
            pstmt.setString(2, message.getSubject());
            pstmt.setString(3, message.getContent());
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    public List<ContactMessage> getMessagesByEmail(String email){
        List<ContactMessage> list = new ArrayList<>();
        try {
            String query = "select * from messages where email=? order by time desc";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, email);
            ResultSet result = pstmt.executeQuery();
            while(result.next()){
                int id =result.getInt("id");
                String subject = result.getString("subject");
                String content = result.getString("content");
                Timestamp time = result.getTimestamp("time");
                ContactMessage message = new ContactMessage(id, email, subject, content, time);
                list.add(message);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<ContactMessage> getAllMessages(){
        List<ContactMessage> list = new ArrayList<>();
        try {
            String query = "select * from messages order by time desc";
            PreparedStatement pstmt = con.prepareStatement(query);
            ResultSet result = pstmt.executeQuery();
            while(result.next()){
                int id =result.getInt("id");
                String subject = result.getString("subject");
                String email = result.getString("email");
                String content = result.getString("content");
                Timestamp time = result.getTimestamp("time");
                ContactMessage message = new ContactMessage(id, email, subject, content, time);
                list.add(message);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
