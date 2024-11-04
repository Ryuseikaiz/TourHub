/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DataAccess.ThienDB;
import com.google.gson.JsonObject;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.User;
import model.Wishlist;

/**
 *
 * @author NOMNOM
 */
@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist"})
public class WishlistServlet extends HttpServlet {

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
            out.println("<title>Servlet WishlistServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet WishlistServlet at " + request.getContextPath() + "</h1>");
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
        // Fetch wishlist data from the database
        User currentUser = (User) request.getSession().getAttribute("currentUser");

        ThienDB wishlistdb = new ThienDB();
        int cus_Id = wishlistdb.getCusIdFromUserId(currentUser.getUser_Id());
        List<Wishlist> wishlistItems = wishlistdb.getWishlistFromDB(cus_Id);
        System.out.println(cus_Id);
        System.out.println(wishlistItems);

        // Set the wishlist data as a request attribute
        request.setAttribute("wishlistItems", wishlistItems);

        // Forward the request to the JSP
        // nên để response về web nớ
        request.getRequestDispatcher("user-wishlist.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        String tourId = request.getParameter("tourId");
        String returnUrl = request.getParameter("returnUrl");

        if ("delete".equals(action)) {
            deleteWishlistItem(request, response);
        } else if ("add".equals(action)) {
            addWishlistItem(request, response, tourId, returnUrl);
        } else {
            processRequest(request, response);
        }
    }

    private void deleteWishlistItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        String wishIdStr = request.getParameter("wishId");
        String message;
        ThienDB wishlistdb = new ThienDB();

        if (wishIdStr != null) {
            int wishId = Integer.parseInt(wishIdStr);

            boolean isDeleted = wishlistdb.deleteWishlistItem(wishId);

            if (isDeleted) {
                message = "Wishlist item deleted successfully.";
            } else {
                message = "Failed to delete wishlist item.";
            }
        } else {
            message = "Missing wishlist ID.";
        }

        // Fetch the updated wishlist items
        List<Wishlist> updatedWishlistItems = wishlistdb.getWishlistItemsForUser(currentUser.getUser_Id());
        request.setAttribute("wishlistItems", updatedWishlistItems);
        request.setAttribute("message", message);
        request.getRequestDispatcher("user-wishlist.jsp").forward(request, response);
    }

    private void addWishlistItem(HttpServletRequest request, HttpServletResponse response, String tourId, String returnUrl)
            throws ServletException, IOException {
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        ThienDB wishlistdb = new ThienDB();
        int cus_Id = wishlistdb.getCusIdFromUserId(currentUser.getUser_Id());

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8"); // Set the response encoding
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        JsonObject jsonResponse = new JsonObject();

        // Check if the item already exists in the wishlist
        boolean itemExists = wishlistdb.checkIfWishlistItemExists(cus_Id, tourId);

        if (!itemExists) {
            // Attempt to add to wishlist
            boolean success = wishlistdb.addToWishlist(cus_Id, tourId);
            if (success) {
                jsonResponse.addProperty("message", "Item added to wishlist successfully.");
            } else {
                jsonResponse.addProperty("message", "Failed to add item to wishlist.");
            }
        } else {
            jsonResponse.addProperty("message", "Item is already in the wishlist.");
        }

        // Write the JSON response
        out.print(gson.toJson(jsonResponse));
        out.flush();
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
