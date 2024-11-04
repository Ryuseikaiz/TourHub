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
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Booking;

/**
 *
 * @author LENOVO
 */
@WebServlet(name="CustomerInformationServlet", urlPatterns={"/CustomerInformation"})
public class CustomerInformationServlet extends HttpServlet {
   
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
            out.println("<title>Servlet CustomerInformationServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerInformationServlet at " + request.getContextPath () + "</h1>");
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
        // Lấy các thông tin từ request
        KhanhDB khanhDB = new KhanhDB();
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String bookId = request.getParameter("bookId");
        String discountCost = request.getParameter("discountCost");
        String totalNoDis = request.getParameter("totalNoDis");
        
        System.out.println("Total No Dis Tour Pay: " + totalNoDis);

        System.out.println("Discount cost: " + discountCost);
        // Kiểm tra nếu có thông tin bị thiếu hoặc rỗng
        if (fullname == null || fullname.trim().isEmpty() || 
            phone == null || phone.trim().isEmpty() ||
            bookId == null || bookId.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {

            System.out.println("Cannot get customer information");

            // Phản hồi lỗi về phía client
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Thông tin không hợp lệ. Vui lòng điền đầy đủ thông tin.");
            return; // Dừng lại nếu có lỗi
        }

        // Nếu thông tin hợp lệ, in ra console
        System.out.println("Customer information: " + fullname + " " + phone + " " + email + " " + bookId);

        // Xử lý thông tin (lưu vào database hoặc các tác vụ khác)
        int converttedBookId = Integer.parseInt(bookId);
        Booking book = new Booking();
        try {
            book = khanhDB.getBookingById(converttedBookId);
            // Phản hồi thành công về client
            
        } catch (SQLException ex) {
            Logger.getLogger(CustomerInformationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        System.out.println(book.toString());
        
        response.setContentType("text/plain");
        response.getWriter().write("Thông tin liên hệ đã được nhận!");
        request.setAttribute("book", book);
        request.setAttribute("discountCost", discountCost);
        request.setAttribute("totalNoDis", totalNoDis);
        request.getRequestDispatcher("/tour-pay.jsp").forward(request, response);
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
