/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techvoyageblog.dao;

import com.techvoyageblog.entities.Category;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author vishal
 */
public class CategoryDao {
    
    private Connection con;

    public CategoryDao(Connection con) {
        this.con = con;
    }
    
    public boolean saveCategory(Category category){
        boolean flag = false;
        try {
            String query = "insert into categories (name,description) values(?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, category.getName());
            pstmt.setString(2, category.getDescription());
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    
    public ArrayList<Category> getAllCategories(){
        ArrayList<Category> list = new ArrayList<>() ;
        try{
            String query = "select * from categories";
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet result = stmt.executeQuery();
            while(result.next()){
                int cid= result.getInt("cid");
                String name =  result.getString("name");
                String description =  result.getString("description");
                Category c = new Category(cid,name,description);
                list.add(c);
                
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    public String getCategoryNameBycid(int cid){
        String name = "";
        try {
            String query = "select name from categories where cid = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, cid);
            ResultSet result = pstmt.executeQuery();
            if(result.next()){
                name = result.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    } 
    public Category getCategoryBycid(int cid){
        Category category = null;
        try {
            String query = "select * from categories where cid = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, cid);
            ResultSet result = pstmt.executeQuery();
            if(result.next()){
                String name =  result.getString("name");
                String description =  result.getString("description");
                category = new Category(cid,name,description);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return category;
    }
    public boolean updateCategory(Category category){
        boolean flag = true;
        try {
            String query = "update categories set name=? , description=? where cid=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, category.getName());
            pstmt.setString(2, category.getDescription());
            pstmt.setInt(3, category.getCid());
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    public boolean deleteCategoryBycid(int cid){
        boolean flag = true;
        try {
            String query = "delete from categories where cid=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1,cid);
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
}
