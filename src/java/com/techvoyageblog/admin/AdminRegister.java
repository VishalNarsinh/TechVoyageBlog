/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techvoyageblog.admin;

import com.techvoyageblog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author vishal
 */
@MultipartConfig
public class AdminRegister extends HttpServlet {

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
            String check = request.getParameter("check");
            if (check == null) {
                out.println("You have to agree to our Terms & Conditions in order to Register");
            } 
            else {
                if(request.getParameter("otp")==null || request.getParameter("otp").isEmpty()){
                    out.println("Please enter OTP");
                    return;
                }
                int otp = Integer.parseInt(request.getParameter("otp"));
                HttpSession session = request.getSession();
                int sessionOTP = (int) session.getAttribute("OTPForAdminEmailVerification");
                if (otp != sessionOTP) {
                    out.println("Invalid OTP. Please double-check the OTP you entered. If you continue to face issues, please request a new OTP.");
                } 
                else {
                    session.removeAttribute("OTPForAdminEmailVerification");
                    String name = request.getParameter("user_name");
                    String email = request.getParameter("user_email");
                    String password = request.getParameter("user_password");
                    Admin admin = new Admin(name, email, password);
                    AdminDao dao = new AdminDao(ConnectionProvider.getConnection());
                    if (dao.saveAdmin(admin)) {
                        out.print("done");
                    } else {
                        System.out.println("Can't create Account");
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
