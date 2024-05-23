/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techvoyageblog.admin;

/**
 *
 * @author vishal
 */
import java.sql.*;
public class AdminDao {
    private Connection con;

    public AdminDao(Connection con) {
        this.con = con;
    }
    
    public boolean saveAdmin(Admin admin){
        boolean flag = false;
        try {
            String query = "insert into admin (username,email,password) values (?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, admin.getUsername());
            pstmt.setString(2, admin.getEmail());
            pstmt.setString(3, admin.getPassword());
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    
    public Admin getAdminByEmailAndPassword(String email, String password){
        Admin admin = null;
        try {
        String sql = "select * from admin where email=? and binary password=?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setString(2, password);
        ResultSet result = pstmt.executeQuery();
        if(result.next()){
            admin = new Admin();
            admin.setId(result.getInt("id"));
            admin.setUsername(result.getString("username"));
            admin.setEmail(result.getString("email"));
            admin.setPassword(result.getString("password"));
            admin.setProfile(result.getString("profile"));
        }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return admin;
    }
    
    public boolean updateAdmin(Admin admin){
        boolean flag = false;
        try {
            String query = "update admin set username=? , password=? , profile=? where id=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, admin.getUsername());
            pstmt.setString(2, admin.getPassword());
            pstmt.setString(3, admin.getProfile());
            pstmt.setInt(4, admin.getId());
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;    
    }
    
    public boolean doesEmailExist(String email){
        boolean flag = false;
        try {
            PreparedStatement pstmt = con.prepareStatement("select * from admin where email=?");
            pstmt.setString(1, email);
            ResultSet result = pstmt.executeQuery();
            if(result.next()){
                flag = true;
            }
        } catch (Exception e) {
        }
        return flag;
    }
    public boolean deleteAdminByid(int id){
     boolean flag = false;
        try {
            PreparedStatement pstmt = con.prepareStatement("delete from admin where id = ?");
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;   
    }
}
