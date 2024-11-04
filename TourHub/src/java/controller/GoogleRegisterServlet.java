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

        // Lấy các trường từ form
        String phone = request.getParameter("phone");
        String province = request.getParameter("provinceName");
        String district = request.getParameter("districtName");
        String commune = request.getParameter("communeName");
        String streetAddress = request.getParameter("address");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

  

        // Kết hợp các trường địa chỉ
        String fullAddress = String.join(" - ", streetAddress, commune, district, province );

        // Cập nhật đối tượng user với thông tin mới
        user.setPhone(phone);
        user.setAddress(fullAddress);  // Lưu địa chỉ kết hợp
        user.setPassword(Encrypt.toSHA256(password)); // Encrypt password
        user.setRole(role);

        // Lưu thông tin người dùng đã cập nhật vào cơ sở dữ liệu
        UserDB userDB = new UserDB();
        boolean isUpdated = userDB.updateGoogleAccount(user);

        if (isUpdated) {
            // Update session with the latest data
            session.setAttribute("currentUser", user);
            System.out.println("User information successfully updated and saved in session.");

            // Chuyển hướng dựa trên vai trò
            if ("Customer".equals(role)) {
                response.sendRedirect("customerInfo.jsp");
            } else if ("Provider".equals(role)) {
                response.sendRedirect("companyInfo.jsp");
            } else {
                // Chuyển hướng mặc định nếu không có vai trò nào
                session.setAttribute("successMessage", "Registration completed successfully! Please log in.");
                response.sendRedirect("login.jsp");
            }
        } else {
            System.out.println("Database update failed on first attempt.");
            request.setAttribute("errorMessage", "Failed to update your registration. Please try again.");
            request.getRequestDispatcher("googleregister.jsp").forward(request, response);
        }
    }
}
