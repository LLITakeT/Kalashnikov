/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.test.serv;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.mail.*; 

/**
 *
 * @author Sergey
 */
@WebServlet(name = "myserv", urlPatterns = {"/myserv"})
public class myserv extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected List dataList = new ArrayList();
    protected String emailto;
    protected String emailfrom;
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = getServletContext();
        emailto = context.getInitParameter("emailto");
        emailfrom = context.getInitParameter("emailfrom");
        
        dataList.add("1");
        dataList.add("Один");
        dataList.add("2");
        dataList.add("Два");
        dataList.add("3");
        dataList.add("Три");
        dataList.add("4");
        dataList.add("Четыре");
        dataList.add("5");
        dataList.add("Пять");
        dataList.add("6");
        dataList.add("Шесть");
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("data", dataList);
        if (request.getParameter("action").equals("mail")) {
            try (PrintWriter out = response.getWriter()) {
                //Handle exception
                try {
                    Email email = new SimpleEmail();
                    email.setHostName("smtp.yandex.ru");
                    email.setSmtpPort(465);
                    email.setAuthenticator(new DefaultAuthenticator("LLITakeTitan", "nezhin"));
                    email.setSSLOnConnect(true);
                    email.setFrom(emailfrom); //do not change
                    email.setSubject("TestMail");
                    email.setMsg("This is a test mail ... :-)");
                    email.addTo(emailto);
                    email.send();
                    
                    out.println("{\"status\":\"OK\",\"text\":\"Email has been sent to "+emailto+"\"}");
                } catch (Exception e) {
                    out.println("{\"status\":\"BAD\",\"text\":\""+e.getMessage()+"\"}");
                }
                
            }
        } else {
            response.setContentType("text/html;charset=UTF-8");
            request.getRequestDispatcher("welcome.jsp").forward(request, response);   
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
