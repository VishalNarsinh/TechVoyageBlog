/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techvoyageblog.filters;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author vishal
 */
public class DirectAccessControl implements Filter {

   

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        String url = req.getServletPath();

        boolean isAjax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));
        if (isAjax) {
            chain.doFilter(request, response);
        } else {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print("<html><body style='font-family: Verdana, sans-serif; background: black; color: white; text-align: center;'>"
                    + "<h1>No direct Script Access allowed</h1>"
                    + "</body></html"
            );
        }
    }

  

    @Override
    public void destroy() {
    }

}
