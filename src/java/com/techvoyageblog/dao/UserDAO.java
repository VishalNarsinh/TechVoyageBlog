package com.techvoyageblog.dao;
import com.techvoyageblog.entities.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.DispatcherType;
public class UserDAO {
    private Connection con;

    public UserDAO(Connection con) {
        this.con = con;
    }
   
//    to store data in database
    public boolean saveUser(User user){
        boolean flag = false;
        try {
//            user->database
            String query = "insert into user (name,email,password,gender,about) values (?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());
            pstmt.executeUpdate();
            flag = true;
             
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
   
//    get user by useremail and password
    public User getUserByEmailAndPassword(String email,String password){
        User  user = null;
        try {
            String query = "select * from user where email=? and binary password=?";
            // binary keyword in sql query is used of case sensitive comparison
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            ResultSet result =  pstmt.executeQuery();
            if(result.next()){
                user  = new User();
                user.setId(result.getInt("id"));
                user.setName(result.getString("name"));
                user.setEmail(result.getString("email"));
                user.setPassword(result.getString("password"));
                user.setGender(result.getString("gender"));
                user.setAbout(result.getString("about"));
                user.setDateTime(result.getTimestamp("registration_date"));
                user.setProfile(result.getString("profile"));
                user.setStatus(result.getString("status"));
                user.setCountBlog(countNoOfBlogByid(user.getId()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
        return user;
    }
    
//    Update edited data in userbase
    public boolean updateUser(User user){
        boolean flag = false;
        try {
            String query = "update user set name=? , password=? , about=? , profile=? where id=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1,user.getName());
            pstmt.setString(2,user.getPassword());
            pstmt.setString(3,user.getAbout());
            pstmt.setString(4,user.getProfile());
            pstmt.setInt(5,user.getId());
            pstmt.execute();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    
    public boolean updatePasswordByEmail(String email, String password){
        boolean flag = false;
        try {
            String query = "update user set password=? where email=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, password);
            pstmt.setString(2, email);
            pstmt.execute();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    public User getUserByUserId(int id){
        User user = null;
        try {
            String query = "select * from user where id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, id);
            ResultSet result = pstmt.executeQuery();
            if(result.next()){
                user  = new User();
                user.setId(result.getInt("id"));
                user.setName(result.getString("name"));
                user.setEmail(result.getString("email"));
                user.setPassword(result.getString("password"));
                user.setGender(result.getString("gender"));
                user.setAbout(result.getString("about"));
                user.setDateTime(result.getTimestamp("registration_date"));
                user.setProfile(result.getString("profile"));
                user.setStatus(result.getString("status"));
                user.setCountBlog(countNoOfBlogByid(user.getId()));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public String getUserNameByid(int id){
        String userName = "";
        try {
            String query = "select * from user where id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, id);
            ResultSet result = pstmt.executeQuery();
            if(result.next()){
                userName = result.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userName;
    }
    public int countNoOfBlogByid(int id){
        int count = 0;
        try {
            PreparedStatement pstmt = con.prepareStatement("select count(userId) from posts where userId=?");
            pstmt.setInt(1, id);
            ResultSet result = pstmt.executeQuery();
            if(result.next()){
                count = result.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    public List<User> getAllUser(){
        List<User> list = new ArrayList<>();
        try {
            PreparedStatement pstmt = con.prepareStatement("select * from user");
            ResultSet result =  pstmt.executeQuery();
            while(result.next()){
                User user  = new User();
                user.setId(result.getInt("id"));
                user.setName(result.getString("name"));
                user.setEmail(result.getString("email"));
                user.setPassword(result.getString("password"));
                user.setGender(result.getString("gender"));
                user.setAbout(result.getString("about"));
                user.setDateTime(result.getTimestamp("registration_date"));
                user.setProfile(result.getString("profile"));
                user.setStatus(result.getString("status"));
                user.setCountBlog(countNoOfBlogByid(user.getId()));
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public boolean updateStatus(int id,String status){
        boolean flag = false;
        try {
            PreparedStatement pstmt = con.prepareStatement("update user set status = ? where id = ?");
            pstmt.setString(1, status);
            pstmt.setInt(2, id);
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    
    public boolean deleteUserByid(int id){
     boolean flag = false;
        try {
            PreparedStatement pstmt = con.prepareStatement("delete from user where id = ?");
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;   
    }
    
    public boolean doesEmailExists(String email){
        boolean flag = false;
        try {
            PreparedStatement pstmt = con.prepareStatement("select * from user where email=?");
            pstmt.setString(1, email);
            ResultSet result = pstmt.executeQuery();
            if(result.next()){
                System.out.println("Exists");
                flag = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
}
