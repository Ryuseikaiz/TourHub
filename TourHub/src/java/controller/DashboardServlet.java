/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DataAccess.BookingDB;
import DataAccess.UserDB;
import com.google.gson.Gson;
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
import java.util.List;
import java.util.Map;
import model.User;

/**
 *
 * @author NOMNOM
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

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
            out.println("<title>Servlet DashboardServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DashboardServlet at " + request.getContextPath() + "</h1>");
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
    String format = request.getParameter("format");
    if ("json".equals(format)) {
        // Handle JSON response
        handleJsonRequest(request, response);
    } else {
        // Handle regular dashboard request
        handleDashboardRequest(request, response);
    }
}

private void handleJsonRequest(HttpServletRequest request, HttpServletResponse response)
        throws IOException {
    try {
        BookingDB book = new BookingDB();
        // Lấy năm từ request
        int year = 2023; // default year
        String yearParam = request.getParameter("year");
        if (yearParam != null) {
            year = Integer.parseInt(yearParam);
        }

        // Lấy số lượng đặt tour theo tháng
        Map<String, Integer> monthlyBookings = book.getMonthlyBookingsCount(year);

        // Chuyển đổi dữ liệu thành JSON
        String jsonResponse = new Gson().toJson(monthlyBookings);

        // Gửi phản hồi JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse);
    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"error\": \"Error fetching data.\"}");
    }
}

private void handleDashboardRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        BookingDB book = new BookingDB();
        double totalBookingsDouble = book.getTotalBookings();
        BigDecimal totalRevenue = book.getTotalRevenue();
        double cancellationRate = book.getCancellationRate();

        int totalBookings = (int) totalBookingsDouble;
        BigDecimal roundedCancellationRate = BigDecimal.valueOf(cancellationRate)
                .setScale(2, RoundingMode.HALF_UP);

        DecimalFormat df = new DecimalFormat("#,##0");
        String formattedTotalRevenue = df.format(totalRevenue.multiply(BigDecimal.valueOf(1000)));

        Map<String, Integer> bookingsByCompany = book.getBookingsByCompany();
        Map<String, Integer> bookingsByLocation = book.getBookingsByLocation();
        List<User> recentUsers = book.getRecentUsers();

        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("totalRevenue", formattedTotalRevenue);
        request.setAttribute("cancellationRate", roundedCancellationRate);
        request.setAttribute("bookingsByCompany", bookingsByCompany);
        request.setAttribute("bookingsByLocation", bookingsByLocation);
        request.setAttribute("recentUsers", recentUsers);

        request.getRequestDispatcher("includes/admin/dashboard.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Đã có lỗi xảy ra: " + e.getMessage());
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
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
        doGet(request, response);
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
