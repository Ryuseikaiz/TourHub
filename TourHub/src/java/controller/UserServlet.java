/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DataAccess.ThienDB;
import DataAccess.UserDB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import model.User;
import utils.Encrypt;

/**
 *
 * @author NOMNOM
 */
@WebServlet(name = "UserServlet", urlPatterns = {"/user"})
public class UserServlet extends HttpServlet {

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
        String action = request.getParameter("action");

        if (action == null) {
            action = "login"; // Default action
        }

        switch (action.toLowerCase()) {
            case "updatecustomer":
                handleUpdateCustomer(request, response);
                break;
            case "updateprovider":
                handleUpdateProvider(request, response);
                break;
            case "updatepass":
                handleUpdatePassword(request, response);
                break;
            case "updateemail":
                handleUpdateEmail(request, response);
                break;
            case "checkotp":
                handleCheckOtp(request, response);
                break;
            case "manage":
                handleManage(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void handleUpdateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = (User) request.getSession().getAttribute("currentUser");

        int userId = currentUser.getUser_Id();
        String rawPassword = currentUser.getPassword();
        String email = currentUser.getEmail();
        String role = currentUser.getRole();
        String avatar = currentUser.getAvatar();

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String birth_str = request.getParameter("birthday");
        Date cus_Birth = null;

        if (birth_str != null && !birth_str.isEmpty()) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            try {
                // Chuyển đổi từ String sang java.util.Date
                java.util.Date utilDate = dateFormat.parse(birth_str);
                // Chuyển đổi từ java.util.Date sang java.sql.Date
                cus_Birth = new java.sql.Date(utilDate.getTime());
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        User user = new User(userId, rawPassword, firstName, lastName, phone, email, address, "Verified", role, avatar, cus_Birth, currentUser.getCreated_At());

        ThienDB userDB = new ThienDB();
        boolean isUpdated = userDB.updateCustomer(user);

        if (isUpdated) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            response.sendRedirect("user");
        } else {
            response.sendRedirect("user-updateinfo.jsp?error=UpdateFailed");
        }
    }

    private void handleUpdateProvider(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = (User) request.getSession().getAttribute("currentUser");

        int userId = currentUser.getUser_Id();
        String rawPassword = currentUser.getPassword();
        String email = currentUser.getEmail();
        String role = currentUser.getRole();
        String avatar = currentUser.getAvatar();
        BigDecimal balance = currentUser.getBalance();

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String tax_Code = request.getParameter("taxcode");
        String bank_Information = request.getParameter("bankInfo");

        User user = new User(userId, rawPassword, firstName, lastName, phone, email, address, currentUser.getCreated_At(), "verified", role, avatar, tax_Code, balance, bank_Information);

        ThienDB userDB = new ThienDB();
        boolean isUpdated = userDB.updateProvider(user);

        if (isUpdated) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            response.sendRedirect("user");
        } else {
            response.sendRedirect("user-updateinfo.jsp?error=UpdateFailed");
        }
    }

    private void handleUpdatePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ form
        UserDB userDb = new UserDB();
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        int userId = currentUser.getUser_Id();

        String inputPassword = request.getParameter("password");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String currentPassword = Encrypt.toSHA256(inputPassword);

        RequestDispatcher dispatcher;

        // Kiểm tra mật khẩu hiện tại có khớp không
        if (!currentUser.getPassword().equals(currentPassword)) {
            // Mật khẩu hiện tại không đúng
            request.setAttribute("error", "UpdateFailed");
            dispatcher = request.getRequestDispatcher("user-updateinfo.jsp?buttonChange=pass&error=UpdateFailed");
            dispatcher.forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu mới và mật khẩu xác nhận có khớp không
        if (!newPassword.equals(confirmPassword)) {
            // Mật khẩu mới không khớp với mật khẩu xác nhận
            request.setAttribute("error", "UpdateFailed");
            dispatcher = request.getRequestDispatcher("user-updateinfo.jsp?buttonChange=pass&error=UpdateFailed");
            dispatcher.forward(request, response);
            return;
        }

        String newHashedPassword = Encrypt.toSHA256(newPassword); // Hash the new password
        boolean isUpdated = userDb.updatePassword(userId, newHashedPassword); // Use the hashed password

        if (isUpdated) {
            // Nếu cập nhật thành công, lưu thông tin mới vào session
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", userDb.getUser(userId)); // Lấy user mới sau khi update

            // Chuyển hướng trở lại trang thông tin người dùng
            response.sendRedirect("user");
        } else {
            // Xử lý nếu cập nhật thất bại
            request.setAttribute("error", "UpdateFailed");
            dispatcher = request.getRequestDispatcher("user-updateinfo.jsp?buttonChange=pass&error=UpdateFailed");
            dispatcher.forward(request, response);
        }
    }

    private void handleUpdateEmail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String avatar = request.getParameter("avatar");
        String email = request.getParameter("email");

        RequestDispatcher dispatcher = null;
        HttpSession mySession = request.getSession();

        if (email != null && !email.trim().isEmpty()) {
            UserDB dao = new UserDB();

            //Kiem tra email da dang ki chua
            boolean emailExists = dao.checkEmailExists(email);

            if (!emailExists) {

                Random rand = new Random();
                int otpvalue = rand.nextInt(1255650);

                String to = email;
                Properties props = new Properties();
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");

                Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("tourhubforlife@gmail.com", "zlnk ggii octx hbdf");
                    }
                });

                try {
                    MimeMessage message = new MimeMessage(session);
                    message.setFrom(new InternetAddress("tourhubforlife@gmail.com"));
                    message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                    message.setSubject("OTP for Password Reset");
                    message.setText("Your OTP is: " + otpvalue);

                    Transport.send(message);
                    System.out.println("Message sent successfully");
                } catch (MessagingException e) {
                    throw new RuntimeException("Error sending email", e);
                }

                dispatcher = request.getRequestDispatcher("user-otp.jsp");
                request.setAttribute("message", "OTP is sent to your email id");
                mySession.setAttribute("otp", otpvalue);
                mySession.setAttribute("email", email);
                mySession.setAttribute("avatar", avatar);
                mySession.setAttribute("userId", userId);  // Set type for password reset
                dispatcher.forward(request, response);
            } else {
                dispatcher = request.getRequestDispatcher("user-updateinfo.jsp?buttonChange=email");
                request.setAttribute("error", "Email is already registered");
                dispatcher.forward(request, response);
            }
        } else {

            dispatcher = request.getRequestDispatcher("user-updateinfo.jsp?buttonChange=email");
            request.setAttribute("error", "Please enter a valid email address");
            dispatcher.forward(request, response);
        }

    }

    private void handleCheckOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher;
        int otp = Integer.parseInt(request.getParameter("otp"));
        int sessionOtp = (Integer) session.getAttribute("otp");
        String email = (String) session.getAttribute("email");
        int userId = (Integer) session.getAttribute("userId");

        if (otp == sessionOtp) {

            UserDB userDb = new UserDB();

            userDb.updateEmail(userId, email);
            User newUser = userDb.getUser(userId);

            session.setAttribute("currentUser", newUser);
            response.sendRedirect("user");

        } else {
            request.setAttribute("message", "Invalid OTP. Please try again.");
            dispatcher = request.getRequestDispatcher("user-otp.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void handleManage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int user = -1;
        HttpSession session = request.getSession();
        session.setAttribute("currentUser", user);
        System.out.println(user);
        UserDB userdb = new UserDB();

        try {
            List<User> users = userdb.getAllUsers();
            System.out.println(users);
            request.setAttribute("users", users);
            request.getRequestDispatcher("includes/admin/user.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
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
        ThienDB userdb = new ThienDB();
        User currentUser = (User) request.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect("home"); // Redirect to home if the user is not logged in
            return;
        }

        int userId = currentUser.getUser_Id();
        String role = currentUser.getRole();

        User user = null;

        // Use .equals() for string comparison in Java
        if ("Customer".equals(role)) {
            user = userdb.getCustomer(userId);

            Date birthdayDate = user.getCus_Birth();
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            String birthdayString = dateFormat.format(birthdayDate);
            request.setAttribute("formattedBirthday", birthdayString);

        } else if ("Provider".equals(role)) {
            user = userdb.getProvider(userId);
        }

        request.setAttribute("user", user);
        request.getSession().setAttribute("currentUser", user);
        request.getRequestDispatcher("user-profile.jsp").forward(request, response);
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
