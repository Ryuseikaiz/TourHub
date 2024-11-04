/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DataAccess.ProvinceDB;
import DataAccess.hoang_UserDB;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.Normalizer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import model.Province;
import model.Tour;
import utils.RemoveDiacritics;

/**
 *
 * @author hoang
 */
@WebServlet(name = "SearchTourServlet", urlPatterns = {"/search"})
public class SearchTourServlet extends HttpServlet {

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
            out.println("<title>Servlet SearchTourServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchTourServlet at " + request.getContextPath() + "</h1>");
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
        // Get the search query from the request parameters
        String searchQuerry = request.getParameter("querry");
        // Optional: Trim the search query to remove leading/trailing whitespace
        if (searchQuerry != null) {
            searchQuerry = searchQuerry.trim();

        }

        // Set the search query as a request attribute to be accessed later
        request.setAttribute("querry", searchQuerry); // Corrected "querry" to "query"

        // Forward the request to the "allTour" servlet or JSP page
        // Ensure the path is correct based on your application structure
        request.getRequestDispatcher("allTour").forward(request, response);
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
        String query = request.getParameter("q"); // Get the search query from the request body
        String querryFormat = new RemoveDiacritics().removeAccent(query.toLowerCase());
        // Fetch matching tours and provinces
        List<Tour> tours = new hoang_UserDB().searchTours(querryFormat);
        List<Province> provinces = new ProvinceDB().getProvinceByQuery(querryFormat); // Add a method to search provinces

        System.out.println("Tours: " + tours.toString());
        System.out.println("Provinces: " + provinces.toString());
        System.out.println("TESSTTTTTTT");

        // Create a map to hold both results
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("tours", tours);
        resultMap.put("provinces", provinces);

        // Convert the map to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8"); // Ensure proper encoding
        response.getWriter().write(new Gson().toJson(resultMap));
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
