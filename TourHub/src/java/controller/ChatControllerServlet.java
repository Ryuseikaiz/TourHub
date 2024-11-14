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
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Message;
import model.User;

/**
 *
 * @author NOMNOM
 */
@WebServlet(name = "ChatControllerServlet", urlPatterns = {"/ChatController"})
public class ChatControllerServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("home");
            return;
        }
        int currentUserId = currentUser.getUser_Id();
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "getChatMessages":
                    getChatMessages(request, response, currentUserId);
                    break;
                case "sendMessage":
                    sendMessage(request, response, currentUserId);
                    break;
                case "getChatRooms":
                    getChatRooms(request, response, currentUserId);
                    break;
                case "getAdminRoom":
                    getAdminRoom(request, response, currentUserId);
                    break;
                case "adminPreChat":
                    adminPreChat(request, response, currentUserId);
                default:
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    break;
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    // Lấy tin nhắn giữa currentUserId và userId được cung cấp
    private void getChatMessages(HttpServletRequest request, HttpServletResponse response, int currentUserId)
            throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        System.out.println("chatmess" + userId);
        List<Message> messages = ThienDB.getChatMessages(currentUserId, userId);
        System.out.println(messages);
        Gson gson = new Gson();
        String json = gson.toJson(messages);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    // Gửi tin nhắn từ currentUserId tới một userId khác
    private void sendMessage(HttpServletRequest request, HttpServletResponse response, int currentUserId)
            throws IOException {
        int user1 = Integer.parseInt(request.getParameter("senderId"));
        int user2 = Integer.parseInt(request.getParameter("receiverId"));
        String messageText = request.getParameter("messageText");

        Message message = null;
        if (user1 == currentUserId) {
            message = new Message(user1, user2, messageText);
        }

        if (user2 == currentUserId) {
            message = new Message(user2, user1, messageText);
        }

        ThienDB messageDAO = new ThienDB();
        boolean isInserted = messageDAO.insertMessage(message);

        if (isInserted) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    // Lấy danh sách người dùng đang hoạt động cho currentUserId
    private void getChatRooms(HttpServletRequest request, HttpServletResponse response, int currentUserId)
            throws IOException {
        List<User> activeUsers = ThienDB.getActiveChatUsers(currentUserId);
        Gson gson = new Gson();
        String json = gson.toJson(activeUsers);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    // Lấy danh sách người dùng đang hoạt động cho currentUserId
    private void getAdminRoom(HttpServletRequest request, HttpServletResponse response, int currentUserId)
            throws IOException {
        List<User> activeUsers = ThienDB.getAdminChat();
        Gson gson = new Gson();
        String json = gson.toJson(activeUsers);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    private void adminPreChat(HttpServletRequest request, HttpServletResponse response, int currentUserId)
            throws IOException {
        ThienDB message = new ThienDB();
        message.AdminPreMessage(currentUserId);
        System.out.println("adminPreChatFunction");
        response.sendRedirect("user-chat.jsp");
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
        processRequest(request, response);
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
