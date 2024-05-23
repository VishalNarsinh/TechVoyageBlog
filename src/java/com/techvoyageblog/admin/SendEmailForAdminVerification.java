/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techvoyageblog.admin;

import com.techvoyageblog.helper.EmailSender;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author vishal
 */
public class SendEmailForAdminVerification extends HttpServlet {

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
            String userName = request.getParameter("userName");
            String to = request.getParameter("email");
            String from = "techvoyageblog@gmail.com";
            String subject = "Email Verification";
            Random random = new Random();
            int otp = random.nextInt(9000)+1000;
            HttpSession session = request.getSession();
            session.setAttribute("OTPForAdminEmailVerification", otp);
            String text = "";
            if (userName == null || userName.isEmpty()) {
                text = "Hello,\n\nThank you for joining TechVoyageBlog as an Admin! We're excited to have you as a member of our administrative team. Your Email Verification OTP is : " + otp + ". Please use this OTP to complete the registration process and get started with our platform.\n\nIf you have any questions or need assistance, feel free to contact our support team.\n\nWelcome aboard!\n\nBest regards,\nThe TechVoyageBlog Team";
            } else {
                text = "Hello " + userName + ",\n\nThank you for joining TechVoyageBlog as an Admin! We're excited to have you as a member of our administrative team. Your Email Verification OTP is : " + otp + ". Please use this OTP to complete the registration process and get started with our platform.\n\nIf you have any questions or need assistance, feel free to contact our support team.\n\nWelcome aboard!\n\nBest regards,\nThe TechVoyageBlog Team";
            }
            EmailSender mail = new EmailSender();
            out.print(mail.sendEmail(to, from, subject, text));
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
