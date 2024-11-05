/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DataAccess.BookingDB;
import DataAccess.CompanyDB;
import DataAccess.UserDB;
import DataAccess.hoang_UserDB;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author hoang
 */
@WebServlet(name = "ProviderChartServlet", urlPatterns = {"/charts"})
public class ProviderChartServlet extends HttpServlet {

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
            out.println("<title>Servlet ProviderChartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProviderChartServlet at " + request.getContextPath() + "</h1>");
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
        // Check if the user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User is not logged in");
            return;
        }

        // Retrieve the logged-in user
        User user = (User) session.getAttribute("currentUser");
        int companyId;
        CompanyDB companyDB = new CompanyDB();

        // Get the year parameter from the request (default to the current year if not provided)
        String yearParam = request.getParameter("year");
        int year;        
        try {
            // Default to current year if the year parameter is missing or invalid
            year = (yearParam != null && !yearParam.isEmpty()) ? Integer.parseInt(yearParam) : LocalDate.now().getYear();
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid year parameter");
            return;
        }

        try {
            // Get company ID based on the user ID
            companyId = companyDB.getCompanyIdFromUserId(user.getUser_Id());
        } catch (SQLException ex) {
            Logger.getLogger(ProviderAnalysServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
            return;
        }

        // Fetch monthly bookings for the company
        hoang_UserDB bookDB = new hoang_UserDB();
        Map<Integer, Integer> monthlyBookings = bookDB.getBookingMonthly(companyId, year);

        // Fetch monthly profits for the selected year
        double[] monthlyProfitsThisYear = bookDB.getMonthlyProfitByYear(companyId, year);
        double[] monthlyProfitsLastYear = bookDB.getMonthlyProfitByYear(companyId, year - 1);

        // Set the response to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Build the JSON response
        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("{");

        // Append monthly bookings
        jsonResponse.append("\"monthlyBookings\": [");
        if (monthlyBookings.isEmpty()) {
            jsonResponse.append("],"); // Empty array case
        } else {
            for (Map.Entry<Integer, Integer> entry : monthlyBookings.entrySet()) {
                jsonResponse.append(String.format("{\"month\": %d, \"totalBookings\": %d},", entry.getKey(), entry.getValue()));
            }
            jsonResponse.setLength(jsonResponse.length() - 1); // Safely remove the last comma
        }
        jsonResponse.append("],"); // Close monthlyBookings array

        // Append monthly profits for this year
        jsonResponse.append("\"monthlyProfitsThisYear\": [");
        for (int month = 0; month < 12; month++) {
            jsonResponse.append(String.format("{\"month\": %d, \"profit\": %.2f},", month + 1, monthlyProfitsThisYear[month]));
        }
        jsonResponse.setLength(jsonResponse.length() - 1); // Remove the last comma
        jsonResponse.append("],"); // Close monthlyProfitsThisYear array

        // Append monthly profits for last year
        jsonResponse.append("\"monthlyProfitsLastYear\": [");
        for (int month = 0; month < 12; month++) {
            jsonResponse.append(String.format("{\"month\": %d, \"profit\": %.2f},", month + 1, monthlyProfitsLastYear[month]));
        }
        jsonResponse.setLength(jsonResponse.length() - 1); // Remove the last comma
        jsonResponse.append("],"); // Close monthlyProfitsLastYear array

        // Fetch hot destinations (assuming you have already done this)
        List<Map<String, Object>> hotDestinations = bookDB.getHotDestination(companyId, year);

        // Prepare data for hot destinations
        List<String> categoryLabels = new ArrayList<>();
        List<Integer> categoryData = new ArrayList<>();

        if (hotDestinations != null && !hotDestinations.isEmpty()) {
            for (Map<String, Object> destination : hotDestinations) {
                String location = (String) destination.getOrDefault("location", "Unknown");
                int count = (Integer) destination.getOrDefault("count", 0);
                categoryLabels.add(location);
                categoryData.add(count);
            }
        }

        // Append hot destination data to the JSON response
        jsonResponse.append("\"categoryLabels\": ").append(new Gson().toJson(categoryLabels)).append(",");
        jsonResponse.append("\"categoryData\": ").append(new Gson().toJson(categoryData));

        // Close the JSON object
        jsonResponse.append("}");

        // Send the JSON response to the client        
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
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
