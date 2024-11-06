/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DataAccess.BookingDB;
import DataAccess.CompanyDB;
import DataAccess.TourDB;
import DataAccess.hoang_UserDB;
import com.google.gson.JsonObject;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.BookingDetails;
import model.User;

/**
 *
 * @author hoang
 */
@WebServlet(name = "ProviderAnalysServlet", urlPatterns = {"/provider-analys"})
public class ProviderAnalysServlet extends HttpServlet {

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
        doPost(request, response);
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
        User user = (User) session.getAttribute("currentUser");

        // Retrieve the date string from the request
        String dateString = request.getParameter("date");

        // Initialize dateInput
        java.sql.Date dateInput = null; // Use java.sql.Date directly

        // Check if the dateString is not null and try to parse it
        if (dateString != null && !dateString.isEmpty()) {
            try {
                // Parse the date string to java.util.Date
                java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateString);
                dateInput = new java.sql.Date(utilDate.getTime()); // Convert to java.sql.Date
            } catch (ParseException e) {
                e.printStackTrace(); // Handle parsing error
                // Optionally, you could set dateInput to null or handle it differently
            }
        }

        // Check if the user is null
        if (user == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if not authenticated
            return; // Stop further processing
        }

        TourDB tourDB = new TourDB();
        CompanyDB companyDB = new CompanyDB();
        hoang_UserDB bookingDB = new hoang_UserDB();
        int companyId = 0;

        try {
            companyId = companyDB.getCompanyIdFromUserId(user.getUser_Id());
        } catch (SQLException ex) {
            Logger.getLogger(ProviderAnalysServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        float totalProfitThisMonth = tourDB.getTotalProfit(companyId);
        // Create a NumberFormat instance for VND currency
        NumberFormat vndFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

// Format the totalProfitThisMonth to VND
        String formattedProfit = vndFormat.format(totalProfitThisMonth);
        int visitToday = tourDB.getTodayVisit(companyId); // Assuming getVisitsByDate accepts a date
        int bookingThisMonth = bookingDB.getTotalBookingThisMonth(companyId); // Use dateInput if available
        List<BookingDetails> bookings = bookingDB.getBookingDetails(companyId); // Consider if you need to filter this by date as well

        // After parsing the dateString
        if (dateString != null && !dateString.isEmpty()) {
            try {
                java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateString);
                dateInput = new java.sql.Date(utilDate.getTime());
                session.setAttribute("date", dateInput); // Store the date in session
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        // Set session attributes for the JSP
        request.getSession().setAttribute("totalProfitThisMonth", formattedProfit);
        request.getSession().setAttribute("visitToday", visitToday);
        request.getSession().setAttribute("bookingThisMonth", bookingThisMonth);
        request.getSession().setAttribute("currentUser", user);
        request.getSession().setAttribute("bookings", bookings);
        session.setAttribute("date", dateInput);

        request.getRequestDispatcher("provider-analysis.jsp").forward(request, response);
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
        // Get current user from session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        // Retrieve the date string from the request
        String dateString = request.getParameter("date");

        // Initialize dateInput (use java.sql.Date directly)
        java.sql.Date dateInput = null;

        // Check if dateString is not null or empty
        if (dateString != null && !dateString.isEmpty()) {
            try {
                // Parse the date string to java.util.Date
                java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateString);
                dateInput = new java.sql.Date(utilDate.getTime()); // Convert to java.sql.Date
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        // After parsing the dateString
        if (dateString != null && !dateString.isEmpty()) {
            try {
                java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateString);
                dateInput = new java.sql.Date(utilDate.getTime());
                session.setAttribute("date", dateInput); // Store the date in session
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        // If user is null, send error response (JSON)
        if (user == null) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("error", "User not logged in");
            response.getWriter().write(errorResponse.toString());
            return;
        }
        // Create instances of your databases
        TourDB tourDB = new TourDB();
        CompanyDB companyDB = new CompanyDB();
        hoang_UserDB bookingDB = new hoang_UserDB();
        int companyId = 0;

        // Get company ID associated with the current user
        try {
            companyId = companyDB.getCompanyIdFromUserId(user.getUser_Id());
        } catch (SQLException ex) {
            Logger.getLogger(ProviderAnalysServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Fetch data based on the date provided (or lack of it)
        float profitAMonth = (dateInput != null)
                ? tourDB.getTotalProfitAMonth(companyId, dateInput)
                : tourDB.getTotalProfit(companyId);

        int visitToday = (dateInput != null)
                ? tourDB.getTodayVisitsByDate(companyId, dateInput)
                : tourDB.getTodayVisit(companyId);

        int bookingThisMonth = (dateInput != null)
                ? bookingDB.getTotalBookingAMonthByDate(companyId, dateInput)
                : bookingDB.getTotalBookingThisMonth(companyId);

        // Prepare the JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("profitAMonth", profitAMonth);
        jsonResponse.addProperty("visitToday", visitToday);
        jsonResponse.addProperty("bookingThisMonth", bookingThisMonth);

        // Write the JSON response
        response.getWriter().write(jsonResponse.toString());
        response.getWriter().flush();

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

    public static void main(String[] args) {
        TourDB tourDB = new TourDB();
        int totalVisitATour = tourDB.getTodayVisitsByDate(2, new Date("2024-09-26"));
        System.out.println(totalVisitATour);
    }
}
