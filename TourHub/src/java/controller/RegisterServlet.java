package controller;

import DataAccess.UserDB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import java.io.IOException;
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
import utils.Encrypt;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String province = request.getParameter("provinceName");
        String district = request.getParameter("districtName");
        String commune = request.getParameter("communeName");
        String streetAddress = request.getParameter("streetAddress");  // Địa chỉ đường phố
        String role = request.getParameter("role");
        String avatar = null;

        UserDB userDB = new UserDB();
        String error = "";

        // Check for email existence
        if (userDB.isEmailExists(email)) {
            error += "Email already exists. ";
        }

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.setAttribute("email", email);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("phone", phone);
            request.setAttribute("streetAddress", streetAddress);
            request.setAttribute("province", province);
            request.setAttribute("district", district);
            request.setAttribute("commune", commune);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        String fullAddress = String.join(" - ", streetAddress, commune, district, province);
        // If no errors, proceed to register the user
        String hashedPassword = Encrypt.toSHA256(password);
        boolean isRegistered = userDB.registerUser(new User(0, hashedPassword, firstName, lastName, phone, email, fullAddress, new Date(), "Unverified", role, avatar));

        if (isRegistered) {
            // Generate OTP
            Random rand = new Random();
            int otp = rand.nextInt(999999);

            // Send the OTP to the user's email
            sendOtpEmail(email, otp);

            // Store OTP in session for validation later
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);
            session.setAttribute("type", "register");  // Set type for registration
            // Redirect to the OTP verification page
            request.setAttribute("message", "OTP has been sent to your email. Please verify.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("enterotp.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private void sendOtpEmail(String to, int otp) {
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
            message.setSubject("OTP for Email Verification");
            message.setText("Your OTP is: " + otp);
            Transport.send(message);
            System.out.println("OTP email sent successfully.");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
