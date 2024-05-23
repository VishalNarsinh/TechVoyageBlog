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
import com.techvoyageblog.entities.Response;
import java.sql.*;
public class ResponseDao {
    private Connection con;

    public ResponseDao(Connection con) {
        this.con = con;
    }
     public boolean saveResponse(Response message){
        boolean flag=false;
        try {
            String query = "insert into responses (email,subject,content) values (?,?,?)";
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
}
