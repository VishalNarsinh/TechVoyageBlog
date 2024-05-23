/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techvoyageblog.admin;

import com.techvoyageblog.entities.Message;
import com.techvoyageblog.helper.ConnectionProvider;
import com.techvoyageblog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author vishal
 */
@MultipartConfig
public class AdminEdit extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String newUserName = request.getParameter("user_name");
            String newUserPassword = request.getParameter("user_password");
            
            Part part = request.getPart("user_photo");
            String imageName = part.getSubmittedFileName();
            
            HttpSession session = request.getSession();
            Admin admin = (Admin) session.getAttribute("admin");
            
            admin.setUsername(newUserName);
            admin.setPassword(newUserPassword);
             
            String oldPhoto = admin.getProfile();
            if (part.getContentType().startsWith("image/")) {
                admin.setProfile(imageName);
            }
            AdminDao dao = new AdminDao(ConnectionProvider.getConnection());
            if(dao.updateAdmin(admin)){
                if (imageName != null && !imageName.isEmpty()) {
                    if (part.getContentType().startsWith("image/")) {
//                        it is image
                        String path = request.getRealPath("/") + "admin/img" + File.separator + admin.getProfile();
                        String oldPath = request.getRealPath("/") + "admin/img" + File.separator + oldPhoto;

                        if (!oldPhoto.equals("default.png")) {
                            Helper.deleteFile(oldPath);
                        }

                        if (Helper.saveFile(part.getInputStream(), path)) {
                            Message msg = new Message("Profile updated", "success", "alert-success");
                            session.setAttribute("msgAdminSide", msg);
                        } else {
                            Message msg = new Message("Can't update profile", "error", "alert-danger");
                            session.setAttribute("msgAdminSide", msg);
                        }
                    } else {
                        // It is not an image file
                        Message msg = new Message("Can't update profile photo. Please select an image.", "error", "alert-danger");
                        session.setAttribute("msgAdminSide", msg);
                    }
                } else {
                    // No changes were made to the image
                    Message msg = new Message("Profile updated", "success", "alert-success");
                    session.setAttribute("msgAdminSide", msg);
                }
                String referer = request.getHeader("referer");
                if(referer!=null && !referer.isEmpty()){
                    response.sendRedirect(referer);
                }
                else{
                    response.sendRedirect("admin/dashboard.jsp");
                }
            } else {
                out.println("notupdated");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
