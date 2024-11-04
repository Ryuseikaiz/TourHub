/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DataAccess.BookingDB;
import DataAccess.ThienDB;
import com.google.gson.Gson;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Booking;
import model.Tour;
import model.User;

/**
 *
 * @author NOMNOM
 */
@WebServlet(name = "booking", urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

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
            out.println("<title>Servlet BookingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("viewtour".equals(action)) {
            handleViewTour(request, response);
        } else {
            // Lấy người dùng hiện tại từ session
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("currentUser");

            if (currentUser != null) {
                ThienDB bookingDB = new ThienDB();

                // Lấy tham số status từ request
                String status = request.getParameter("status");
                List<Booking> bookings;

                // Kiểm tra nếu có status, lọc các bookings theo status
                if (status != null && !status.isEmpty()) {
                    bookings = bookingDB.getUserStatusBookingDetails(currentUser.getUser_Id(), status);
                } else {
                    // Nếu không có status, lấy tất cả bookings
                    bookings = bookingDB.getUserBookingDetails(currentUser.getUser_Id());
                }

                // Gửi danh sách bookings và status hiện tại đến JSP
                request.setAttribute("bookings", bookings);
                request.setAttribute("selectedStatus", status);
            }

            // Chuyển tiếp đến trang JSP để hiển thị bookings
            RequestDispatcher dispatcher = request.getRequestDispatcher("user-booking.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "login"; // Default action
        }

        switch (action.toLowerCase()) {
            case "cancelbook":
                handleCancelBook(request, response);
                break;
            case "refundbook":
                handleRefundBook(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    protected void handleCancelBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("id");
        User currentUser = (User) request.getSession().getAttribute("currentUser");

        ThienDB bookingDB = new ThienDB();
        int customerId = bookingDB.getCusIdFromUserId(currentUser.getUser_Id());

        // Prepare a JSON response
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            boolean updateSuccess = bookingDB.updateBookingStatus(customerId, bookingId, "Cancelled");
            String message = updateSuccess ? "Booking cancelled successfully!" : "Failed to cancel booking.";

            // Directly output the JSON response
            String jsonResponse = "{\"message\": \"" + message + "\"}";
            out.print(jsonResponse);
        } catch (Exception e) {
            e.printStackTrace();
            // Return an error message in JSON format
            String jsonResponse = "{\"message\": \"An error occurred: " + e.getMessage() + "\"}";
            out.print(jsonResponse);
        } finally {
            out.flush();
            out.close();
        }
    }

    protected void handleRefundBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("id");
        User currentUser = (User) request.getSession().getAttribute("currentUser");

        ThienDB bookingDB = new ThienDB();
        int customerId = bookingDB.getCusIdFromUserId(currentUser.getUser_Id());

        // Prepare a JSON response
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            boolean updateSuccess = bookingDB.updateBookingStatus(customerId, bookingId, "Refund");
            String message = updateSuccess ? "Booking refunded successfully!" : "Failed to refund booking.";

            // Directly output the JSON response
            String jsonResponse = "{\"message\": \"" + message + "\"}";
            out.print(jsonResponse);
        } catch (Exception e) {
            e.printStackTrace();
            // Return an error message in JSON format
            String jsonResponse = "{\"message\": \"An error occurred: " + e.getMessage() + "\"}";
            out.print(jsonResponse);
        } finally {
            out.flush();
            out.close();
        }
    }

    public void handleViewTour(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tourName = request.getParameter("name");

        ThienDB bookingDB = new ThienDB();
        String id = bookingDB.getTourIdByName(tourName); // Phương thức này lấy thông tin tour theo tên

        if (id != null) {
            response.sendRedirect("displayTourDetail?id=" + id);
        } else {
            response.sendRedirect("error.jsp"); // Nếu tour không tồn tại, chuyển hướng đến trang lỗi
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
