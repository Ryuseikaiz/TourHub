package controller;

import DataAccess.ThienDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import java.io.IOException;

@WebServlet(name = "UploadAvatarServlet", urlPatterns = {"/UploadAvatarServlet"})
public class UploadAvatarServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the new avatar URL from the hidden input field
        String newAvatarUrl = request.getParameter("tour_Img_URLs");

        if (newAvatarUrl != null && !newAvatarUrl.trim().isEmpty()) {
            // Clean up the URL string
            newAvatarUrl = newAvatarUrl.trim();

            // Get the current user from the session
            User currentUser = (User) request.getSession().getAttribute("currentUser");
            if (currentUser != null) {
                ThienDB dao = new ThienDB();
                boolean isUpdated = dao.updateUserAvatar(currentUser.getUser_Id(), newAvatarUrl);

                if (isUpdated) {
                    currentUser.setAvatar(newAvatarUrl); // Update avatar in session
                    request.getSession().setAttribute("currentUser", currentUser); // Refresh session data
                    System.out.println("User avatar updated successfully.");
                    response.sendRedirect("user"); // Redirect to profile or success page
                } else {
                    System.out.println("Failed to update user avatar in the database.");
                    response.sendRedirect("user"); // Redirect to error page
                }
            } else {
                System.out.println("No user found in session.");
                response.sendRedirect("login"); // Redirect to login if no user in session
            }
        } else {
            System.out.println("No new avatar URL provided.");
            response.sendRedirect("user"); // Redirect back to profile or a default page
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to update user avatar URL by replacing the old avatar";
    }
}
