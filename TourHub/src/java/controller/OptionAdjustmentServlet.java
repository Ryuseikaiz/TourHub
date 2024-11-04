/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DataAccess.KhanhDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import model.TourOption;
import model.TourPeople;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Discount;
/**
 *
 * @author LENOVO
 */
@WebServlet(name="OptionAdjustmentServlet", urlPatterns={"/optionAdjustment"})
public class OptionAdjustmentServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet OptionAdjustmentServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OptionAdjustmentServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        KhanhDB u = new KhanhDB();
        String optionIdRaw = request.getParameter("id");
        
        String selectedDate = request.getParameter("selectedDate");
        System.out.println(selectedDate);
        
        String tour_Id = "";
        Discount dis = new Discount();
        List<Discount> discounts = new ArrayList<>();
        try {
            tour_Id = u.getTourIdByOptionId(optionIdRaw);
            discounts = u.getAllDiscountByTourId(tour_Id);
        } catch (SQLException ex) {
            Logger.getLogger(OptionAdjustmentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        
        int optionId = Integer.parseInt(optionIdRaw);
        
        TourOption option = u.getTourOptionById(optionId);
        
        List<TourPeople> peopleList = u.getTourPeopleByOptionId(optionId);
        
        request.setAttribute("option", option);
        request.setAttribute("peopleList", peopleList);
        request.setAttribute("previousSelectedDate", selectedDate);
        request.setAttribute("discounts", discounts);
        
        request.getRequestDispatcher("/option-adjustment.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
