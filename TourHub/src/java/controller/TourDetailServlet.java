/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DataAccess.KhanhDB;
import DataAccess.ReviewDB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Review;
import model.Tour;
import model.TourDetailDescription;
import model.TourOption;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "TourDetailServlet", urlPatterns = {"/displayTourDetail"})
public class TourDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet TourDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TourDetailServlet at " + request.getContextPath() + "</h1>");
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
        String rawTourId = request.getParameter("id");
        KhanhDB u = new KhanhDB();

        // Lấy thông tin tour
        Tour tour = u.getTourById(rawTourId);
        request.setAttribute("tour", tour);

        // Lấy danh sách TourOption
        List<TourOption> tourOptions = u.getAllTourOptionsByTourId(rawTourId);
      
        request.setAttribute("tourOptions", tourOptions); // Thêm tourOptions vào request

        
        System.out.println(tourOptions);
        
 
        TourDetailDescription description = u.getTourDetailDescriptionByTourId(rawTourId);
        request.setAttribute("tourDetailDescription", description); // Thêm tourOptions vào request
        // Lấy review từ database bằng ReviewDB
        ReviewDB reviewDB = new ReviewDB();
        List<Review> allReviews = reviewDB.getReviewsByTourId(rawTourId);
        request.setAttribute("allReviews", allReviews);
        List<Review> reviews = reviewDB.getTop3ReviewsByTourId(rawTourId);

        // Kiểm tra nếu không có review
        if (reviews == null || reviews.isEmpty()) {
            request.setAttribute("noReviews", true);
        } else {
            request.setAttribute("reviews", reviews);  // Thêm danh sách reviews vào request
        }

        // Chuyển tiếp đến trang JSP (tour-detail.jsp)
        RequestDispatcher dispatcher = request.getRequestDispatcher("/tour-detail.jsp");
        dispatcher.forward(request, response);
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
