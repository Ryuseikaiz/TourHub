package controller;

import DataAccess.ThienDB;
import DataAccess.UserDB;
import model.User;
import entity.GoogleAccount;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String code = request.getParameter("code"); // Google login code

        UserDB userDB = new UserDB();
        User user = null;

        if (code != null) {
            // Google Login Flow
            GoogleLogin googleLogin = new GoogleLogin();
            String accessToken = googleLogin.getToken(code);

            if (accessToken == null) {
                System.out.println("Failed to obtain access token.");
                request.setAttribute("errorMessage", "Google login failed. Please try again.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            GoogleAccount googleAccount = googleLogin.getUserInfo(accessToken);

            // Check if Google account exists in the User table
            user = userDB.authenticate(googleAccount.getEmail(), null);

            if (user == null) {
                // New Google user, create and save in DB
                user = new User();
                user.setEmail(googleAccount.getEmail());
                user.setFirst_Name(googleAccount.getGiven_name());
                user.setLast_Name(googleAccount.getFamily_name());
                user.setPassword(""); // No password initially for Google users
                user.setCreated_At(new java.util.Date());
                user.setUser_Status("Verified");
                user.setAvatar(googleAccount.getPicture());
                    
                boolean isRegistered = userDB.registerUser(user);
                if (!isRegistered) {
                    System.out.println("Failed to register new Google user.");
                    request.setAttribute("errorMessage", "Failed to register with Google. Please try again.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }

                // Set user in session and redirect
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);
                session.setAttribute("infoMessage", "Login again to complete some information!");
                response.sendRedirect("login.jsp");
                return;
            } else if (user.getPassword().equals("")) {
                // If user exists but has an empty password, redirect to Google register
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);
                response.sendRedirect("googleregister.jsp");
                return;
            }
        } else if (email != null && password != null) {
            // Manual login
            user = userDB.authenticate(email, password);

            if (user == null) {
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
        } else {
            // Neither manual login nor Google login attempt
            response.sendRedirect("login.jsp");
            return;
        }

        if (user != null) {
            // Check if the user status is "Unverified"
            if (user.getUser_Status().equals("Unverified")) {
                // Generate OTP
                Random rand = new Random();
                int otp = rand.nextInt(999999);

                // Send the OTP to the user's email
                sendOtpEmail(user.getEmail(), otp);

                // Store OTP and email in session for validation later
                HttpSession session = request.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("email", user.getEmail());
                session.setAttribute("type", "login");  // Set type for login OTP

                // Redirect to the OTP verification page
                request.setAttribute("message", "OTP has been sent to your email. Please verify.");
                request.getRequestDispatcher("enterotp.jsp").forward(request, response);
                return;
            } else if (user.getUser_Status().equals("Banned")) {
                request.setAttribute("message", "Your account was banned");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            } else {
                // User is verified, proceed with role-based logic
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);

                // Check if the user is a customer and has incomplete info
                if (user.getRole().equals("Customer") && !userDB.hasCustomerInfo(user.getUser_Id())) {
                    response.sendRedirect("customerInfo.jsp");
                    return;
                }

                // Check if the user is a provider and has incomplete info
                if (user.getRole().equals("Provider") && !userDB.hasCompanyInfo(user.getUser_Id())) {
                    response.sendRedirect("companyInfo.jsp");
                    return;
                }
                
//            request.getRequestDispatcher("/home").forward(request, response);
                // Redirect to the homepage or user dashboard
                response.sendRedirect("home");
                return;  // Important to return after forward
            }
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles Google and manual login, including OTP for unverified users";
    }
}
