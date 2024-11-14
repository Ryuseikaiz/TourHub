package controller;

import DataAccess.UserDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "VerifyServlet", urlPatterns = {"/verifyOtp"})
public class VerifyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        int sessionOtp = (int) session.getAttribute("otp");
        String enteredOtp = request.getParameter("otp");

        if (email == null || sessionOtp == 0) {
            // Session expired or invalid
            request.setAttribute("error", "Session expired. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validate OTP
        if (Integer.parseInt(enteredOtp) == sessionOtp) {
            // OTP matches, proceed with verification
            UserDB userDB = new UserDB();
            userDB.updateUser_StatusToVerified(email);  // Update user to "verified"
            
            session.removeAttribute("otp");  // Remove OTP from session after verification
            session.removeAttribute("email");
            
            // Redirect to login page or a success page
            request.setAttribute("infoMessage", "Email verified successfully. You can now log in.");
            response.sendRedirect("login.jsp");
        } else {
            // OTP does not match
            request.setAttribute("error", "Invalid OTP. Please try again.");
            request.getRequestDispatcher("enterotp.jsp").forward(request, response);
        }
    }
}
