/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DataAccess.KhanhDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.awt.print.Book;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Booking;

/**
 *
 * @author LENOVO
 */
@WebServlet(name="FinishBookingServlet", urlPatterns={"/FinishBooking"})
public class FinishBookingServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FinishBookingServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FinishBookingServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String book_Id_raw = request.getParameter("id");
        System.out.println(book_Id_raw);
        KhanhDB u = new KhanhDB();
        
        int book_Id = Integer.parseInt(book_Id_raw);
        try {
            u.updateBookingStatusToBooked(book_Id);
        } catch (SQLException ex) {
            Logger.getLogger(FinishBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        Booking book = new Booking();
        
        try {
            book = u.getBookingById(book_Id);
        } catch (SQLException ex) {
            Logger.getLogger(FinishBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        BigDecimal amount = book.getTotal_Cost();
        String pay_Method = "QR";
        
        // Get the current date in the format "dd/MM/yyyy"
        LocalDate currentDate = LocalDate.now();
        String billDate = currentDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        
        try {
            u.importBill(amount, billDate, pay_Method, book_Id);
        } catch (SQLException ex) {
            Logger.getLogger(FinishBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        request.setAttribute("booking", book);
        request.getRequestDispatcher("/booked-tour.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
