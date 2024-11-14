/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

import DataAccess.CompanyDB;
import DataAccess.KhanhDB;
import DataAccess.ThienDB;
import DataAccess.UserDB;
import DataAccess.WithdrawalsDB;
import DataAccess.hoang_UserDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.awt.print.Book;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import model.Booking;
import model.Company;
import model.Customer;
import model.Notification;
import model.Tour;
import model.User;
import utils.CSVReader;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "FinishBookingServlet", urlPatterns = {"/FinishBooking"})
public class FinishBookingServlet extends HttpServlet {

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
            out.println("<title>Servlet FinishBookingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FinishBookingServlet at " + request.getContextPath() + "</h1>");
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
        String book_Id_raw = request.getParameter("id");
        String status = request.getParameter("status");
        String discountCost = request.getParameter("discountCost");
        String totalNoDis = request.getParameter("totalNoDis");
        String discountId = request.getParameter("discountId");
        System.out.println("---Finish Booking");
        System.out.println("Book id: " + book_Id_raw);
        System.out.println("Status:" + status);
        System.out.println("Discount Cost: " + discountCost);
        System.out.println("Total no dis: " + totalNoDis);
        System.out.println("Discount Id: " + discountId);

        KhanhDB u = new KhanhDB();
        ThienDB thienDB = new ThienDB();
        UserDB userDB = new UserDB();
        Booking book = new Booking();
        int discountIdInt = 0;
        int book_Id = Integer.parseInt(book_Id_raw);

        if (status.contains("Complete")) {
            try {
                u.updateBookingStatusToBooked(book_Id);
            } catch (SQLException ex) {
                Logger.getLogger(FinishBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (discountCost == null) {
                System.out.println("Not using discount");
            } else {
                discountIdInt = Integer.parseInt(discountId);
                System.out.println("Using discount");
                try {
                    u.decrementDiscountQuantity(discountIdInt);
                } catch (SQLException ex) {
                    java.util.logging.Logger.getLogger(BookingOverviewServlet.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
                }
            }

            try {
                book = u.getBookingById(book_Id);
            } catch (SQLException ex) {
                Logger.getLogger(FinishBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            BigDecimal amount = book.getTotal_Cost();
            String pay_Method = "QR";

            // Get the current date in the format "dd/MM/yyyy"
            LocalDate currentDate = LocalDate.now();
            String billDate = currentDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));

            try {
                u.importBill(amount, billDate, pay_Method, book_Id);
            } catch (SQLException ex) {
                Logger.getLogger(FinishBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            User user = userDB.getUserFromSession(request.getSession());
            if ("Booked".equalsIgnoreCase(book.getBook_Status())) {
                sendBookingConfirmationEmail(request, user.getEmail(), book, user);
                setBalanceAfterBookingSuccess(book, request, response);

                String msgProvider = user.getFirst_Name() + " " + user.getLast_Name() + " just book your tour " + book.getTour_Name();
                String msgCustomer = "You just book success " + book.getTour_Name() + " go to My Booking Section to check your booking, Have a good day!";
                int userCompanyId = new CompanyDB().getProviderByTourId(book.getTour_Id()).getUser_Id();
                int userCustomerId = new UserDB().getUserFromSession(request.getSession()).getUser_Id();
                thienDB.addNotification(userCustomerId, msgCustomer);
                thienDB.addNotification(userCompanyId, msgProvider);

                response.getWriter().write("Email sent successfully!");
            } else {
                response.getWriter().write("Tour status is not 'Booked'.");
            }
        } else {
            try {
                book = u.getBookingById(book_Id);
            } catch (SQLException ex) {
                Logger.getLogger(FinishBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        request.setAttribute("booking", book);
        request.getRequestDispatcher("/booked-tour.jsp").forward(request, response);
    }

    private void sendBookingConfirmationEmail(HttpServletRequest request, String toEmail, Booking bookedDetail, User userBooking) {
        CSVReader reader = new CSVReader();
        final String fromEmail = "tourhubforlife@gmail.com";
        final String password = "zlnk ggii octx hbdf";

        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // Get the folder upload path and generate QR code file path
            File uploadFolder = getFolderUpload(request);
            String qrFilePath = uploadFolder.getAbsolutePath() + "/bookingQRCode.png";

            // Generate QR code with booking details and save it to the directory
            String qrContent = generateQRContent(bookedDetail, userBooking);
            generateQRCode(qrContent, qrFilePath);

            // Get the latest QR code file
            File latestQRCode = reader.getLatestFileFromDir(uploadFolder.getAbsolutePath());

            // Create the email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Tour Booking Confirmation");

            // Create the email body
            String emailContent = "Dear " + userBooking.getFirst_Name() + " " + userBooking.getLast_Name() + ",\n\n"
                    + "Thank you for booking your tour with us! We are delighted to confirm your reservation. Here are the details of your tour:\n\n"
                    + "Booking ID: " + bookedDetail.getBook_Id() + "\n"
                    + "Tour Name: " + bookedDetail.getTour_Name() + "\n"
                    + "Tour Date: " + bookedDetail.getTour_Date() + "\n"
                    + "Number of Slots Booked: " + bookedDetail.getSlot_Order() + "\n"
                    + "Booking Details: " + bookedDetail.getBooking_Detail() + "\n"
                    + "Tour Option: " + bookedDetail.getOption_Name() + "\n\n"
                    + "Please show this email to checkout\n\n"
                    + "If you have any questions or need further assistance, please do not hesitate to reach out to us.\n\n"
                    + "We look forward to providing you with an unforgettable experience!\n\n"
                    + "Best regards,\n"
                    + "TourHub - Buy a tour without leaving your home";

            // Attach the email content and QR code
            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setText(emailContent);

            MimeBodyPart qrCodeAttachment = new MimeBodyPart();
            DataSource source = new FileDataSource(latestQRCode);
            qrCodeAttachment.setDataHandler(new DataHandler(source));
            qrCodeAttachment.setFileName("BookingQRCode.png");

            // Create multipart and add parts
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(textPart);
            multipart.addBodyPart(qrCodeAttachment);

            message.setContent(multipart);

            // Send message
            Transport.send(message);
            System.out.println("Email with QR code sent successfully!");

            // Clean up QR code directory
            reader.deleteAllFilesInDir(uploadFolder.getAbsolutePath());

        } catch (MessagingException | IOException | WriterException e) {
            e.printStackTrace();
        }
    }

    // QR Code generation method
    private void generateQRCode(String qrContent, String filePath) throws WriterException, IOException {
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);

        BitMatrix bitMatrix = qrCodeWriter.encode(qrContent, BarcodeFormat.QR_CODE, 300, 300, hints);
        Path path = FileSystems.getDefault().getPath(filePath);
        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);
    }

    // Helper method to create QR code content
    private String generateQRContent(Booking bookedDetail, User userBooking) {
        return "Dear " + userBooking.getFirst_Name() + " " + userBooking.getLast_Name() + ",\n\n"
                + "Thank you for booking with us! Here are your booking details:\n\n"
                + "Booking ID: " + bookedDetail.getBook_Id() + "\n"
                + "Tour Name: " + bookedDetail.getTour_Name() + "\n"
                + "Tour Date: " + bookedDetail.getTour_Date() + "\n"
                + "Slots: " + bookedDetail.getSlot_Order() + "\n"
                + "Details: " + bookedDetail.getBooking_Detail() + "\n"
                + "Option: " + bookedDetail.getOption_Name();
    }

    public void setBalanceAfterBookingSuccess(Booking booking, HttpServletRequest request, HttpServletResponse response) {
        Company company = new CompanyDB().getProviderByTourId(booking.getTour_Id());
        CompanyDB companyDB = new CompanyDB();
        if (company != null && "Booked".equalsIgnoreCase(booking.getBook_Status())) {
            company.setBalance(company.getBalance().add(booking.getTotal_Cost().multiply(new BigDecimal("0.9"))));
            companyDB.updateCompanyBalance(company);
        } else {
            Logger.getLogger(ProviderManagementServlet.class.getName()).log(Level.WARNING, "Company or booking status invalid.");
        }
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

    private File getFolderUpload(HttpServletRequest request) {
        String uploadPath = request.getServletContext().getRealPath("/assests/qr-checkout");
        String cleanedPath = removeBuildPath(uploadPath);

        File folderUpload = new File(cleanedPath);
        if (!folderUpload.exists() && !folderUpload.mkdirs()) {
            System.out.println("Failed to create directory: " + folderUpload.getAbsolutePath());
        }
        return folderUpload;
    }

    private String removeBuildPath(String originalPath) {
        String buildPath = "build\\";
        return originalPath.contains(buildPath) ? originalPath.replace(buildPath, "") : originalPath;
    }
}
