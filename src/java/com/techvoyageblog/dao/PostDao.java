package com.techvoyageblog.dao;

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

    public boolean savePost(Post post) {
//        saving post to db
        boolean flag = false;
        try {
            String query = "insert into posts (pTitle,pContent,pCode,pImage,pExternalLink,catId,userId) values (?,?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, post.getpTitle());
            pstmt.setString(2, post.getpContent());
            pstmt.setString(3, post.getpCode());
            pstmt.setString(4, post.getpImage());
            pstmt.setString(5, post.getpExternalLink());
            pstmt.setInt(6, post.getCatId());
            pstmt.setInt(7, post.getUserId());
            pstmt.executeUpdate();
            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    public List<Post> getAllPosts() {
//        fetching all the posts
        List<Post> list = new ArrayList<>();
        try {
            PreparedStatement pstmt = con.prepareStatement("select * from posts where status='active' order by pDate desc");
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
            PreparedStatement pstmt = con.prepareStatement("select * from posts where catID=? and status='active' order by pDate desc");
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

    public List<Post> getAllPostsByUId(int userId) {
        List<Post> list = new ArrayList<>();
        try {
            String query = "select * from posts where userId=? order by pDate desc";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, userId);
            ResultSet result = pstmt.executeQuery();
            while (result.next()) {
                int pId = result.getInt("pId");
                String pTitle = result.getString("pTitle");
                String pContent = result.getString("pContent");
                String pCode = result.getString("pCode");
                String pImage = result.getString("pImage");
                Timestamp pDate = result.getTimestamp("pDate");
                Timestamp lastEdited = result.getTimestamp("pLastEdited");
                String pExternalLink = result.getString("pExternalLink");
                int catId = result.getInt("catId");
                String status = result.getString("status");
                Post post = new Post(pId, pTitle, pContent, pCode, pImage, pDate, lastEdited, pExternalLink, catId, userId,status);
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    public boolean updatePostTitle(int pId, String pTitle) {
        boolean flag = false;
        try {
            Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            String query = "update posts set pTitle = ? , pLastEdited=? where pId=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, pTitle);
            pstmt.setTimestamp(2, currentTimestamp);
            pstmt.setInt(3, pId);
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    public boolean updatePostContent(int pId, String pContent) {
        boolean flag = false;
        try {
            Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            String query = "update posts set pContent = ? , pLastEdited=? where pId=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, pContent);
            pstmt.setTimestamp(2, currentTimestamp);
            pstmt.setInt(3, pId);
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    public boolean updatePostCode(int pId, String pCode) {
        boolean flag = false;
        try {
            Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            String query = "update posts set pCode = ? , pLastEdited=? where pId=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, pCode);
            pstmt.setTimestamp(2, currentTimestamp);
            pstmt.setInt(3, pId);
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    public boolean updatePostLink(int pId, String pExternalLink) {
        boolean flag = false;
        try {
            Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            String query = "update posts set pExternalLink = ? , pLastEdited=? where pId=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, pExternalLink);
            pstmt.setTimestamp(2, currentTimestamp);
            pstmt.setInt(3, pId);
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    public boolean deletePost(int pId) {
        boolean flag = false;
        try {
            PreparedStatement pstmt = con.prepareStatement("delete from posts where pId=?");
            pstmt.setInt(1, pId);
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    public String getImageNameBypId(int pId) {
        String imageName = "";
        try {
            String query = "select pImage from posts where pId = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, pId);
            ResultSet result = pstmt.executeQuery();
            if (result.next()) {
                imageName = result.getString("pImage");
                return imageName;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return imageName;
    }

    public boolean updatePostImage(int pId, String pImage) {
        boolean flag = false;
        try {
            Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            String query = "update posts set pImage = ? , pLastEdited=? where pId=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, pImage);
            pstmt.setTimestamp(2, currentTimestamp);
            pstmt.setInt(3, pId);
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    public List<Post> findBypTitleContaining(String input) {
        List<Post> list = new ArrayList<>();
        try {
            String query = "select * from posts where pTitle like ? and status='active'";
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
    
}
