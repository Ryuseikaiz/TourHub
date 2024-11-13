/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DataAccess.KhanhDB;
import DataAccess.UserDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import java.math.BigDecimal;
import java.sql.SQLException;
import model.User;
import model.Booking;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.Date;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "BookingOverviewServlet", urlPatterns = {"/BookingOverview"})
public class BookingOverviewServlet extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BookingOverviewServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingOverviewServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        HttpSession session = request.getSession();
        UserDB userDB = new UserDB();
        KhanhDB khanhDB = new KhanhDB();

        // Get the user from the session
        User user = userDB.getUserFromSession(session);

        if (user == null) {
            // Redirect to login page if the user does not exist in the session
            response.sendRedirect("login.jsp");
            return; // Stop further execution
        }

        // Get cusId from the User object
        int cusId = 0; // Assuming user_Id corresponds to cusId

        try {
            int userId = userDB.getUserFromSession(session).getUser_Id(); // Example user ID
            cusId = khanhDB.getCusIdFromUserId(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Get and validate parameters
        String selectedDateString = request.getParameter("selectedDate");
        String totalCost = request.getParameter("totalCost");
        String bookingDetail = request.getParameter("bookingDetail");
        String optionIdString = request.getParameter("optionId");
        String discountCost = request.getParameter("discountCost");
        String discountId = request.getParameter("discountId");
        String totalNoDis = request.getParameter("totalNoDis");

        System.out.println("Selected Date: " + selectedDateString);
        System.out.println("Total Cost: " + totalCost);
        System.out.println("Booking Detail: " + bookingDetail);
        System.out.println("Discount Cost: " + discountCost);
        System.out.println("Discount Id: " + discountId);
        System.out.println("Total no dis: " + totalNoDis);
                
        System.out.println("Option ID: " + optionIdString);

        if (selectedDateString == null || totalCost == null || bookingDetail == null || optionIdString == null) {

            // Redirect to an error page if any required parameter is missing
            response.sendRedirect(request.getContextPath() + "/error.jsp?message=Missing parameters");
            return;
        }

        // Convert optionId from String to int
        int optionId = 0; // Initialize optionId
        try {
            optionId = Integer.parseInt(optionIdString); // Convert String to int
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp?message=Invalid Option ID format");
            return;
        }

        String tourId = null;

        try {
            // Fetch the tourId by optionId
            tourId = khanhDB.getTourIdByOptionId(optionIdString); // Call with String representation if needed
            if (tourId == null) {
                // Redirect to an error page if no tour is found for the given optionId
                response.sendRedirect(request.getContextPath() + "/error.jsp?message=No Tour found for Option ID " + optionIdString);
                return;
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving tour ID: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/error.jsp?message=Error retrieving tour ID");
            return;
        }

        // Default booking status
        String bookStatus = "Pending";

        // Fetch the tourId by optionId (as a string)
        int slotOrder = 1;
        String tourDate = selectedDateString; // Keep this as String for now
        String cancelDate = "";
        String bookDate = selectedDateString;
        BigDecimal refundAmount = BigDecimal.ZERO;


        // Convert selectedDateString to java.sql.Date
        java.sql.Date sqlDate = null;
        try {
            sqlDate = convertStringToSqlDate(selectedDateString); // Use the convertStringToSqlDate method
        } catch (ParseException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp?message=Invalid date format");
            return;
        }
        
        System.out.println(sqlDate);

        int scheduleId = 0;
        try {
            scheduleId = khanhDB.getScheduleId(optionId, sqlDate); // Use sqlDate instead of selectedDateString
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(BookingOverviewServlet.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        
        System.out.println(scheduleId);

        // Now, you can use tourId in your booking process or elsewhere.
        try {
            // Import the booking using the updated tourId
            khanhDB.importBooking(tourId, selectedDateString, totalCost, bookingDetail, bookStatus, String.valueOf(optionId), scheduleId, cusId, slotOrder, selectedDateString, cancelDate, selectedDateString, refundAmount);
            System.out.println("Booking successfully imported.");          
        } catch (SQLException e) {
            System.err.println("Error importing booking: " + e.getMessage());
        }


        // Get booking id, cần chỉnh lại cách lấy, vẫn bị trùng
        int bookingId = 0;             

        try {
            bookingId = khanhDB.getLatestBookingId();
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(BookingOverviewServlet.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }


        // Check booking id

        if (bookingId != -1) {
            System.out.println("Booking inserted with ID: " + bookingId);
        } else {
            System.out.println("Failed to retrieve booking ID.");
        }


        // Get booking by id

        Booking book = new Booking();
        try {
            book = khanhDB.getBookingById(bookingId);
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(BookingOverviewServlet.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }

        System.out.println(book.toString());

        request.setAttribute("book", book);
        request.setAttribute("discountCost", discountCost);
        request.setAttribute("totalNoDis", totalNoDis);
        request.setAttribute("user", user);
        request.setAttribute("discountId", discountId);
        request.setAttribute("previousSelectedDate", selectedDateString);
        request.getRequestDispatcher("/booking-overview.jsp").forward(request, response);
    }

    public static Date convertStringToSqlDate(String dateStr) throws ParseException {
        // Định dạng ngày dựa trên chuỗi nhập vào
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

        // Chuyển đổi chuỗi ngày thành java.util.Date
        java.util.Date parsedDate = dateFormat.parse(dateStr);

        // Chuyển từ java.util.Date sang java.sql.Date
        return new java.sql.Date(parsedDate.getTime());
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
