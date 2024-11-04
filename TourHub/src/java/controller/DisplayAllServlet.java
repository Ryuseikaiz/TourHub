/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DataAccess.KhanhDB;
import DataAccess.ProvinceDB;
import DataAccess.TourDB;
import DataAccess.hoang_UserDB;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Province;
import model.Tour;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "DisplaySearchServlet", urlPatterns = {"/allTour"})
public class DisplayAllServlet extends HttpServlet {

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
            out.println("<title>Servlet DisplaySearchServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DisplaySearchServlet at " + request.getContextPath() + "</h1>");
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
        KhanhDB u = new KhanhDB();
        ProvinceDB provinceDB = new ProvinceDB();

        // Get the sort order from the request
        String sortOrder = request.getParameter("sortOrder");
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "popularity";  // Default sort by popularity
        }

        // Get the location or search query from the request
        String location = request.getParameter("location");
        String searchQuery = request.getParameter("querry"); // Using 'query' for consistency
        if (location == null || location.isEmpty()) {
            location = "All";  // Default to "All"
        }

        // Get the price range from the request
        String priceRange = request.getParameter("priceRange");
        int minPrice = 0;
        int maxPrice = 0;

        // Parse the price range if provided
        if (priceRange != null && !priceRange.equals("0-0")) {
            String[] prices = priceRange.split("-");
            minPrice = Integer.parseInt(prices[0]);
            maxPrice = Integer.parseInt(prices[1]);
        }

        List<Province> provinces = provinceDB.getProvinceByQuery(location);

        // If a search query is provided, prioritize that over location
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            location = searchQuery.trim(); // Update location to search query if present
        }

        // Call the getAll method with the sorting, location, and price filters
        List<Tour> list = u.getAllTour(sortOrder, location, minPrice, maxPrice);
        List<Tour> tours = new TourDB().getTours();

        // Set attributes for JSP forwarding
        request.setAttribute("data", list);
        request.setAttribute("tours", tours);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("location", location);
        request.setAttribute("priceRange", priceRange);

        // Check if the request expects JSON response
        String jsonResponse = request.getParameter("responseType");
        if ("json".equalsIgnoreCase(jsonResponse)) {
            // Send JSON response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(new Gson().toJson(tours));
            response.getWriter().write(new Gson().toJson(provinces));
        } else {
            // Forward to the JSP page
            request.getRequestDispatcher("search-page.jsp").forward(request, response);
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
