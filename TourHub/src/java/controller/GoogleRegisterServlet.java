package controller;

import DataAccess.UserDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import java.io.IOException;
import utils.Encrypt;

@WebServlet(name = "GoogleRegisterServlet", urlPatterns = {"/completeRegistration"})
public class GoogleRegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the session and confirm it's active
        HttpSession session = request.getSession(false);  // Avoid creating a new session
        if (session == null) {
            System.out.println("Session not found. Redirecting to login page.");
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("currentUser");

        if (user == null) {
            System.out.println("Session expired or user not logged in.");
            response.sendRedirect("login.jsp");
            return;
        }

        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Validate password
        if (!isValidPassword(password)) {
            System.out.println("Password validation failed.");
            request.setAttribute("errorMessage", "Password must be 8-16 characters long, include at least 1 uppercase letter and 1 special character.");
            request.getRequestDispatcher("googleregister.jsp").forward(request, response);
            return;
        }

        // Update user object with new information
        user.setPhone(phone);
        user.setAddress(address);
        user.setPassword(Encrypt.toSHA256(password)); // Encrypt password
        user.setRole(role);

        // Save the updated user info to the database
        UserDB userDB = new UserDB();
        boolean isUpdated = userDB.updateGoogleAccount(user);

        if (isUpdated) {
            // Update session with the latest data
            session.setAttribute("currentUser", user);
            System.out.println("User information successfully updated and saved in session.");

            // Redirect based on role
            if ("Customer".equals(role)) {
                response.sendRedirect("customerInfo.jsp");
            } else if ("Provider".equals(role)) {
                response.sendRedirect("companyInfo.jsp");
            } else {
                // Default redirection if no specific role match
                session.setAttribute("successMessage", "Registration completed successfully! Please log in.");
                response.sendRedirect("login.jsp");
            }
        } else {
            System.out.println("Database update failed on first attempt.");
            request.setAttribute("errorMessage", "Failed to update your registration. Please try again.");
            request.getRequestDispatcher("googleregister.jsp").forward(request, response);
        }
    }

    private boolean isValidPassword(String password) {
        return password.length() >= 8 && password.length() <= 16
                && password.chars().anyMatch(Character::isUpperCase)
                && password.chars().anyMatch(Character::isLowerCase)
                && password.chars().anyMatch(Character::isDigit)
                && !password.contains(" ");  // Ensure no whitespace
    }
}
