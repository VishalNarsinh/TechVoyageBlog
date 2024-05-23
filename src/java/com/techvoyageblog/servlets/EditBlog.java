/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techvoyageblog.servlets;

import com.techvoyageblog.dao.PostDao;
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
import javax.servlet.http.Part;

/**
 *
 * @author vishal
 */
@MultipartConfig
public class EditBlog extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            PostDao dao = new PostDao(ConnectionProvider.getConnection());
            String operation = request.getParameter("operation");
            int pId = Integer.parseInt(request.getParameter("pId"));
            if (operation.equals("editTitle")) {
                String pTitle = request.getParameter("pTitle");
                out.print(dao.updatePostTitle(pId, pTitle));
            }
            if (operation.equals("editContent")) {
                String pContent = request.getParameter("pContent");
                pContent = pContent.replaceAll("\n", "<br>");
                out.print(dao.updatePostContent(pId, pContent));
            }
            if (operation.equals("editCode")) {
                String pCode = request.getParameter("pCode");
                out.print(dao.updatePostCode(pId, pCode));
            }
            if (operation.equals("editLink")) {
                String pExternalLink = request.getParameter("pExternalLink");
                out.print(dao.updatePostLink(pId, pExternalLink));
            }
            if (operation.equals("editImage")) {
                Part part = request.getPart("pImage");
                String pImage = part.getSubmittedFileName();
                String oldImage = dao.getImageNameBypId(pId);
                
                if (dao.updatePostImage(pId, pImage)) { 
                    String oldPath =request.getRealPath("/") + "blog_imgs" + File.separator + oldImage;
                    Helper.deleteFile(oldPath);
                    String path = request.getRealPath("/") + "blog_imgs" + File.separator + pImage;
                    if (Helper.saveFile(part.getInputStream(), path)) {
                        out.print("true");
                    }
                }
            }

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
