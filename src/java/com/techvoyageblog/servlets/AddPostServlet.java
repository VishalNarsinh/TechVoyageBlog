package com.techvoyageblog.servlets;

import com.techvoyageblog.dao.PostDao;
import com.techvoyageblog.entities.Post;
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
@MultipartConfig
public class AddPostServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            int cid = Integer.parseInt(request.getParameter("cid"));
            String pTitle = request.getParameter("pTitle");
            String pContent = request.getParameter("pContent");
            pContent = pContent.replaceAll("\n", "<br>");
            String pCode = request.getParameter("pCode");
            Part part = request.getPart("pImage");
            String pImage = part.getSubmittedFileName();
            
            String pExternalLink = request.getParameter("pExternalLink");

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");
            int userId = user.getId();
            
            Post post = new Post(pTitle,pContent,pCode,pImage,pExternalLink,cid,userId);
            PostDao dao = new PostDao(ConnectionProvider.getConnection());
            if(dao.savePost(post)){
                if(part.getContentType().startsWith("image/")){
                    String path = request.getRealPath("/") + "blog_imgs" + File.separator + pImage;
                    if(Helper.saveFile(part.getInputStream(), path))
                        out.print("done");
                }
                else{
                    out.print("done");
                }
                
            }
            else{
                out.print("error");
            }
            
            
        }catch(Exception e){
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
