package controller;

import DataAccess.UserDB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "ValidateOtp", urlPatterns = {"/ValidateOtp"})
public class ValidateOtp extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int otp = Integer.parseInt(request.getParameter("otp"));
        int sessionOtp = (Integer) session.getAttribute("otp");
        String type = (String) session.getAttribute("type");
        String email = (String) session.getAttribute("email");

        RequestDispatcher dispatcher;

        if (otp == sessionOtp) {
            if ("register".equals(type)) {
                // User registration: confirm OTP and update user status to 'verified'
                UserDB userDB = new UserDB();
                userDB.updateUser_StatusToVerified(email);
                request.setAttribute("infoMessage", "Registration successful! You can now log in.");
                dispatcher = request.getRequestDispatcher("login.jsp");
            } else if ("forgotPassword".equals(type)) {
                // Password reset: redirect to new password page
                dispatcher = request.getRequestDispatcher("newpassword.jsp");
            } else {
                request.setAttribute("message", "Invalid OTP type.");
                dispatcher = request.getRequestDispatcher("error.jsp");
            }
        } else {
            request.setAttribute("message", "Invalid OTP. Please try again.");
            dispatcher = request.getRequestDispatcher("enterotp.jsp");
        }

        dispatcher.forward(request, response);
    }
}
