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
import java.sql.*;

public class LikeDao {

    private Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }

    public boolean doLike(int pid, int uid) {
        boolean flag = false;
        try {
            String query = "insert into likes (pid,uid) values(?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, pid);
            pstmt.setInt(2, uid);
            pstmt.executeUpdate();
            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    public int countLikeOnPost(int pid) {
        int count = 0;
        try {
            String query = "select count(*) from likes where pid=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, pid);
            ResultSet result = pstmt.executeQuery();
            if (result.next()) {
                count = result.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean isLikedByUser(int pid, int uid) {
        boolean flag = false;
        try {
            String query = "select * from likes where pid=? and uid=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, pid);
            pstmt.setInt(2, uid);
            ResultSet result = pstmt.executeQuery();
            if(result.next()){
                flag = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    
    public boolean deleteLike(int pid,int uid){
        boolean flag = false;
        try {
            String query = "delete from likes where pid=? and uid=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, pid);
            pstmt.setInt(2, uid);
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
}
