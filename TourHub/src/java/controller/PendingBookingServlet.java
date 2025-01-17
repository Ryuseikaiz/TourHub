/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DataAccess.BookingDB;
import DataAccess.CompanyDB;
import DataAccess.UserDB;
import DataAccess.hoang_UserDB;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.BookingDetails;

/**
 *
 * @author hoang
 */
@WebServlet(name = "BookingServlet", urlPatterns = {"/pending-bookings"})
public class PendingBookingServlet extends HttpServlet {

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
        doGet(request, response);
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
        hoang_UserDB bookingManager = new hoang_UserDB();
        int companyId;
        try {
            // Fetch the provider Id from user session
            companyId = new hoang_UserDB().getProviderIdFromUserId(new UserDB().getUserFromSession(request.getSession()).getUser_Id());
        } catch (SQLException ex) {
            Logger.getLogger(SearchTourByIdServlet.class.getName()).log(Level.SEVERE, null, ex);
            return;
        }
        List<BookingDetails> bookings = bookingManager.getBookingDetails(companyId);
        System.out.println(bookings.size());
        request.getSession().setAttribute("bookings", bookings);
        request.getRequestDispatcher("provider-booking.jsp").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String bookingIdStr = request.getParameter("bookingId"); // Get the booking ID from the request
        hoang_UserDB bookingDB = new hoang_UserDB();

        try {
            // Parse the bookingId from String to int
            int bookingId = Integer.parseInt(bookingIdStr); // Parse the String to int

            // Check the action and update booking status accordingly
            switch (action) {
                case "accept":
                    bookingDB.updateBookingStatus(bookingId, "Booked");
                    request.setAttribute("successMessage", "Booking accepted successfully.");
                    break;
                case "reject":
                    bookingDB.updateBookingStatus(bookingId, "Cancelled");
                    request.setAttribute("successMessage", "Booking rejected successfully.");
                    break;
                default:
                    request.setAttribute("errorMessage", "Invalid action.");
                    break;
            }

            // Forward to the booking page to display the messages
            request.getRequestDispatcher("provider-booking.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Handle invalid booking ID format
            request.setAttribute("errorMessage", "Invalid booking ID format.");
            request.getRequestDispatcher("provider-booking.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(PendingBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("errorMessage", "Database error occurred. Please try again later.");
            request.getRequestDispatcher("provider-booking.jsp").forward(request, response);
        }
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
