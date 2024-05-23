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
import com.techvoyageblog.entities.Category;
import com.techvoyageblog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {

    private Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getAllCategories() {
//        to fetch blog categories
        ArrayList<Category> list = new ArrayList<>();
        try {
            String query = "select * from categories";
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet result = stmt.executeQuery();
            while (result.next()) {
                int cid = result.getInt("cid");
                String name = result.getString("name");
                String description = result.getString("description");
                Category c = new Category(cid, name, description);
                list.add(c);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    

    public List<Post> getAllPosts() {
//        fetching all the posts
        List<Post> list = new ArrayList<>();
        try {
            PreparedStatement pstmt = con.prepareStatement("select * from posts order by pDate desc");
            ResultSet result = pstmt.executeQuery();
            while (result.next()) {
                int pId = result.getInt("pId");
                String pTitle = result.getString("pTitle");
                String pContent = result.getString("pContent");
                String pCode = result.getString("pCode");
                String pImage = result.getString("pImage");
                Timestamp date = result.getTimestamp("pDate");
                Timestamp lastEdited = result.getTimestamp("pLastEdited");
                String pExternalLink = result.getString("pExternalLink");
                int catId = result.getInt("catId");
                int userId = result.getInt("userId");
                String status = result.getString("status");
                Post post = new Post(pId, pTitle, pContent, pCode, pImage, date, lastEdited, pExternalLink, catId, userId,status);
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Post> getPostByCatId(int catId) {
//        fetching posts for specific category using catId
        List<Post> list = new ArrayList<>();

        try {
            PreparedStatement pstmt = con.prepareStatement("select * from posts where catID=? order by pDate desc");
            pstmt.setInt(1, catId);
            ResultSet result = pstmt.executeQuery();
            while (result.next()) {
                int pId = result.getInt("pId");
                String pTitle = result.getString("pTitle");
                String pContent = result.getString("pContent");
                String pCode = result.getString("pCode");
                String pImage = result.getString("pImage");
                Timestamp date = result.getTimestamp("pDate");
                Timestamp lastEdited = result.getTimestamp("pLastEdited");
                String pExternalLink = result.getString("pExternalLink");
                int userId = result.getInt("userId");
                String status = result.getString("status");
                Post post = new Post(pId, pTitle, pContent, pCode, pImage, date, lastEdited, pExternalLink, catId, userId,status);
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Post getPostByPostId(int pId) {
        Post post = null;
        String query = "select * from posts where pId=?";
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, pId);
            ResultSet result = pstmt.executeQuery();
            if (result.next()) {
                String pTitle = result.getString("pTitle");
                String pContent = result.getString("pContent");
                String pCode = result.getString("pCode");
                String pImage = result.getString("pImage");
                Timestamp date = result.getTimestamp("pDate");
                Timestamp lastEdited = result.getTimestamp("pLastEdited");
                String pExternalLink = result.getString("pExternalLink");
                String status = result.getString("status");
                int catId = result.getInt("catId");
                int userId = result.getInt("userId");
                post = new Post(pId, pTitle, pContent, pCode, pImage, date, lastEdited, pExternalLink, catId, userId,status);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }

    

    public List<Post> getTopMostLikes(int limit) {
        List<Post> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM posts p WHERE (SELECT COUNT(lid)FROM likes l WHERE l.pid = p.pId) > 0 ORDER BY (SELECT COUNT(lid) FROM likes l WHERE l.pid = p.pId) DESC limit 0,?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, limit);
            ResultSet result = pstmt.executeQuery();
            while (result.next()) {
                int pId = result.getInt("pId");
                String pTitle = result.getString("pTitle");
                String pContent = result.getString("pContent");
                String pCode = result.getString("pCode");
                String pImage = result.getString("pImage");
                Timestamp pDate = result.getTimestamp("pDate");
                Timestamp pLastEdited = result.getTimestamp("pLastEdited");
                String pExtenalLink = result.getString("pExternalLink");
                int catId = result.getInt("catId");
                int userId = result.getInt("userId");
                String status = result.getString("status");
                Post p = new Post(pId, pTitle, pContent, pCode, pImage, pDate, pLastEdited, pExtenalLink, catId, userId,status);
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Post> findBypTitleContaining(String input) {
        List<Post> list = new ArrayList<>();
        try {
            String query = "select * from posts where pTitle like ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, "%" + input + "%");
            ResultSet result = pstmt.executeQuery();
            while (result.next()) {
                int pId = result.getInt("pId");
                String pContent = result.getString("pContent");
                String pTitle = result.getString("pTItle");
                String pCode = result.getString("pCode");
                String pImage = result.getString("pImage");
                Timestamp pDate = result.getTimestamp("pDate");
                Timestamp lastEdited = result.getTimestamp("pLastEdited");
                String pExternalLink = result.getString("pExternalLink");
                int catId = result.getInt("catId");
                int userId = result.getInt("userId");
                String status = result.getString("status");
                Post post = new Post(pId, pTitle, pContent, pCode, pImage, pDate, lastEdited, pExternalLink, catId, userId,status);
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public boolean updateStatus(int pId,String status){
        boolean flag = false;
        try {
            PreparedStatement pstmt = con.prepareStatement("update posts set status = ? where pId = ?");
            pstmt.setString(1, status);
            pstmt.setInt(2, pId);
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
}

