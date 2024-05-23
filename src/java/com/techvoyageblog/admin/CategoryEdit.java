/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techvoyageblog.admin;

import com.techvoyageblog.dao.CategoryDao;
import com.techvoyageblog.entities.Category;
import com.techvoyageblog.entities.Message;
import com.techvoyageblog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author vishal
 */
public class CategoryEdit extends HttpServlet {

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
            CategoryDao dao = new CategoryDao(ConnectionProvider.getConnection());
            HttpSession session = request.getSession();
            String operation = request.getParameter("operation");
            if (operation!=null && operation.equals("delete")) {
                int cid = Integer.parseInt(request.getParameter("cId"));
                if (dao.deleteCategoryBycid(cid)) {
                    Message msg = new Message("Category Deleted", "success", "alert-success");
                    session.setAttribute("msgAdminSide", msg);
                } else {
                    Message msg = new Message("Category Deleted", "success", "alert-danger");
                    session.setAttribute("msgAdminSide", msg);
                }
                response.sendRedirect("admin/show_categories.jsp");
                return;
            }
            int cid = Integer.parseInt(request.getParameter("cid"));
            String newName = request.getParameter("name");
            String newDescription = request.getParameter("description");
            Category category = new Category(cid, newName, newDescription);
            if (newName.isEmpty()) {
                Message msg = new Message("Name can't be empty", "success", "alert-danger");
                session.setAttribute("msgAdminSide", msg);
            } else {
                if (dao.updateCategory(category)) {
                    Message msg = new Message("Category updated", "success", "alert-success");
                    session.setAttribute("msgAdminSide", msg);
                } else {
                    Message msg = new Message("Can't update Category", "success", "alert-danger");
                    session.setAttribute("msgAdminSide", msg);
                }
            }

            response.sendRedirect("admin/show_categories.jsp");
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
