package controller;

import DataAccess.BookingDB;
import DataAccess.CompanyDB;
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

@WebServlet(name = "ProviderChartServlet", urlPatterns = {"/charts"})
public class ProviderChartServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ProviderChartServlet.class.getName());

    // Method to add CORS headers to the response
    private void addCORSHeaders(HttpServletResponse response) {
        response.setHeader("Access-Control-Allow-Origin", "*"); // Use "*" for testing or specify your domain
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set CORS headers
        addCORSHeaders(response);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            LOGGER.log(Level.WARNING, "Unauthorized access attempt");
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User is not logged in");
            return;
        }

        User user = (User) session.getAttribute("currentUser");
        int companyId;
        CompanyDB companyDB = new CompanyDB();

        String yearParam = request.getParameter("year");
        int year;
        try {
            year = (yearParam != null && !yearParam.isEmpty()) ? Integer.parseInt(yearParam) : LocalDate.now().getYear();
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid year parameter: " + yearParam, e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid year parameter");
            return;
        }

        try {
            companyId = companyDB.getCompanyIdFromUserId(user.getUser_Id());
            LOGGER.log(Level.INFO, "Retrieved companyId: " + companyId);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error retrieving company ID", ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
            return;
        }

        hoang_UserDB bookDB = new hoang_UserDB();
        Map<Integer, Integer> monthlyBookings = bookDB.getBookingMonthly(companyId, year);
        double[] monthlyProfitsThisYear = bookDB.getMonthlyProfitByYear(companyId, year);
        double[] monthlyProfitsLastYear = bookDB.getMonthlyProfitByYear(companyId, year - 1);
        List<Map<String, Object>> hotDestinations = bookDB.getHotDestination(companyId, year);

        // Ensure that the retrieved data is not null or empty
        List<Map<String, Object>> monthlyBookingsList = new ArrayList<>();
        if (monthlyBookings != null) {
            for (Map.Entry<Integer, Integer> entry : monthlyBookings.entrySet()) {
                Map<String, Object> bookingData = new HashMap<>();
                bookingData.put("month", entry.getKey());
                bookingData.put("totalBookings", entry.getValue());
                monthlyBookingsList.add(bookingData);
            }
        }

        List<Map<String, Object>> profitsThisYearList = new ArrayList<>();
        List<Map<String, Object>> profitsLastYearList = new ArrayList<>();
        for (int month = 0; month < 12; month++) {
            Map<String, Object> profitThisYearData = new HashMap<>();
            profitThisYearData.put("month", month + 1);
            profitThisYearData.put("profit", monthlyProfitsThisYear != null ? monthlyProfitsThisYear[month] : 0);
            profitsThisYearList.add(profitThisYearData);

            Map<String, Object> profitLastYearData = new HashMap<>();
            profitLastYearData.put("month", month + 1);
            profitLastYearData.put("profit", monthlyProfitsLastYear != null ? monthlyProfitsLastYear[month] : 0);
            profitsLastYearList.add(profitLastYearData);
        }

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

        Map<String, Object> responseData = new HashMap<>();
        responseData.put("monthlyBookings", monthlyBookingsList);
        responseData.put("monthlyProfitsThisYear", profitsThisYearList);
        responseData.put("monthlyProfitsLastYear", profitsLastYearList);
        responseData.put("categoryLabels", categoryLabels);
        responseData.put("categoryData", categoryData);

        String jsonResponse = new Gson().toJson(responseData);

        try (PrintWriter out = response.getWriter()) {
            out.print(jsonResponse);
            out.flush();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle CORS preflight requests
        addCORSHeaders(response);
        response.setStatus(HttpServletResponse.SC_OK);
    }

    @Override
    public String getServletInfo() {
        return "Provider Chart Servlet with CORS support for Azure";
    }
}