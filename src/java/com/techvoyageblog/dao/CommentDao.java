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
import com.techvoyageblog.entities.Comment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class CommentDao {
    private Connection con;

    public CommentDao(Connection con) {
        this.con = con;
    }
    
    public int countCommentOnPost(int pid){
        int count = 0;
        try {
            String query = "select count(*) from comments where pid=?";
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
    
    public boolean doComment(int pid,int uid,String content){
        boolean flag = false;
        try {
            String query = "insert into comments (content,pid,uid) values(?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, content);
            pstmt.setInt(2, pid);
            pstmt.setInt(3, uid);
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    
    public boolean deleteComment(int com_id){
        boolean flag = false;
        try {
            String query = "delete from comments where com_id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, com_id);
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    
    public List<Comment> getAllCommentsBypid(int pid){
        List<Comment> list = new ArrayList<>();
        try {
            String query = "select * from comments where pid = ? order by com_id desc";
            PreparedStatement pstmt = con.prepareCall(query);
            pstmt.setInt(1, pid);
            ResultSet result = pstmt.executeQuery();
            while(result.next()){
                int com_id = result.getInt("com_id");
                String content = result.getString("content");
                int uid = result.getInt("uid");
                Comment c = new Comment(com_id, content, pid, uid);
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
