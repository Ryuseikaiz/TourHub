/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DataAccess.BookingDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import model.Booking;
import model.User;

/**
 *
 * @author NOMNOM
 */
@WebServlet(name = "ExportFileServlet", urlPatterns = {"/exportfile"})
public class ExportFileServlet extends HttpServlet {

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
        // Set the content type to text/csv
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"report.csv\"");

        try {
            // Fetch booking data
            BookingDB book = new BookingDB();
            double totalBookingsDouble = book.getTotalBookings();
            BigDecimal totalRevenue = book.getTotalRevenue();
            double cancellationRate = book.getCancellationRate();

            System.out.println(totalRevenue);

            // Convert and format values
            int totalBookings = (int) totalBookingsDouble;
            BigDecimal roundedCancellationRate = BigDecimal.valueOf(cancellationRate)
                    .setScale(2, RoundingMode.HALF_UP);

            // Format the number with commas and no decimal places
            NumberFormat formatter = new DecimalFormat("#,##0");
            String formattedRevenue = formatter.format(totalRevenue.multiply(BigDecimal.valueOf(1000)));
            String RevenueDot = formattedRevenue.replace(",", ".");

            // Add the "VND" suffix
            String RevenueStr = RevenueDot + " VND";

            // Fetch additional data
            Map<String, Integer> bookingsByCompany = book.getBookingsByCompany();
            Map<String, Integer> bookingsByLocation = book.getBookingsByLocation();
            List<User> recentUsers = book.getRecentUsers();

            // Prepare CSV output
            try (PrintWriter out = response.getWriter()) {
                // Write CSV header
                out.println("Total Bookings,Total Revenue,Cancellation Rate,Number Bookings By Company,Number Bookings By Location,Recent Users have Register");

                // Convert maps and lists to strings for CSV output
                String companyData = bookingsByCompany.entrySet().stream()
                        .map(entry -> entry.getKey() + ":" + entry.getValue())
                        .collect(Collectors.joining("; "));

                String locationData = bookingsByLocation.entrySet().stream()
                        .map(entry -> entry.getKey() + ":" + entry.getValue())
                        .collect(Collectors.joining("; "));

                String usersData = recentUsers.stream()
                        .map(user -> user.getFirst_Name() + " " + user.getLast_Name()) // Concatenate first and last names
                        .collect(Collectors.joining("; "));

                // Ghi dữ liệu CSV
                out.printf("%d,%s,%.2f,%s,%s,%s%n",
                        totalBookings,
                        RevenueStr, // Đây là chuỗi
                        roundedCancellationRate,
                        companyData.isEmpty() ? "No data" : companyData,
                        locationData.isEmpty() ? "No data" : locationData,
                        usersData.isEmpty() ? "No data" : usersData);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

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
