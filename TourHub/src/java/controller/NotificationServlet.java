/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DataAccess.ThienDB;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import model.Notification;
import model.User;

/**
 *
 * @author NOMNOM
 */
@WebServlet(name = "NotificationServlet", urlPatterns = {"/notifications"})
public class NotificationServlet extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NotificationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NotificationServlet at " + request.getContextPath() + "</h1>");
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
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not authenticated");
            return;
        }

        int userId = currentUser.getUser_Id();
        ThienDB notificationsDAO = new ThienDB();

        try {
            // Get notifications from the DAO
            List<Notification> notifications = notificationsDAO.getNotificationsByUserId(userId);

            // Set notifications in request scope
            request.setAttribute("notifications", notifications);
            request.getRequestDispatcher("/user-notification.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to retrieve notifications");
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            User currentUser = (User) request.getSession().getAttribute("currentUser");
            if (currentUser == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not authenticated");
                return;
            }

            ThienDB notificationsDAO = new ThienDB();
            try {
                List<Notification> notifications = notificationsDAO.getNotificationsByUserId(currentUser.getUser_Id());
                String notificationsJson = new Gson().toJson(notifications);

                // Set appropriate headers to prevent caching
                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                response.setHeader("Pragma", "no-cache");
                response.setDateHeader("Expires", 0);

                out.write(notificationsJson);
                out.flush(); // Ensure the response is sent fully
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.write("{\"error\": \"Failed to retrieve notifications\"}");
                out.flush(); // Ensure the error message is sent
            }
        } catch (IOException e) {
            e.printStackTrace(); // Log any IO issues that could affect response
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Notification handling servlet";
    }// </editor-fold>
}