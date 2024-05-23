/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techvoyageblog.servlets;

import com.techvoyageblog.dao.UserDAO;
import com.techvoyageblog.entities.Message;
import com.techvoyageblog.entities.User;
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
public class EditServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {

//          fetching new data
            String newUserName = request.getParameter("user_name");
            String newUserPassword = request.getParameter("user_password");
            String newAbout = request.getParameter("user_about");

//          file type input
            Part part = request.getPart("user_photo");
//          Once you have the Part object, you can access information about the uploaded file,
//          such as its input stream, size, content type, and headers.
            String imageName = part.getSubmittedFileName();

//          Get user data from session
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");
            if (user == null) {
                Message msg = new Message("You need to Login first", "error", "alert-danger");
                session.setAttribute("msgUserSide", msg);
                response.sendRedirect("login_page.jsp");
                return;
            }
//          Update data in user which is stored in session
            user.setName(newUserName);
            user.setPassword(newUserPassword);
            user.setAbout(newAbout);
            String oldPhoto = user.getProfile();
//            if (imageName.contains(".jpg") || imageName.contains(".jpeg") || imageName.contains(".png")) {
//                user.setProfile(imageName);
//            }
            if (part.getContentType().startsWith("image/")) {
                user.setProfile(imageName);
            }
//          update database
            UserDAO dao = new UserDAO(ConnectionProvider.getConnection());
            Message msg = null;
            if (dao.updateUser(user)) {
                if (imageName != null && !imageName.isEmpty()) {
                    if (part.getContentType().startsWith("image/")) {
//                        it is image
                        String path = request.getRealPath("/") + "img" + File.separator + user.getProfile();
                        String oldPath = request.getRealPath("/") + "img" + File.separator + oldPhoto;

                        if (!oldPhoto.equals("default.png")) {
                            Helper.deleteFile(oldPath);
                        }

                        if (Helper.saveFile(part.getInputStream(), path)) {
                            msg = new Message("Profile updated", "success", "alert-success");

                        } else {
                            msg = new Message("Can't update profile", "error", "alert-danger");

                        }
                    } else {
                        // It is not an image file
                        msg = new Message("Can't update profile photo. Please select an image.", "error", "alert-danger");

                    }
                } else {
                    // No changes were made to the image
                    msg = new Message("Profile updated", "success", "alert-success");

                }

            } else {
                msg = new Message("Can't update profile info.", "error", "alert-danger");
            }
            session.setAttribute("msg", msg);
            String referer = request.getHeader("referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect("profile.jsp");
            }
            out.println("</body>");
            out.println("</html>");
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
