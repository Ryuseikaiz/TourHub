package controller;

import DataAccess.CompanyDB;
import DataAccess.KhanhDB;
import DataAccess.ThienDB;
import DataAccess.UserDB;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Booking;
import model.Company;
import model.User;

import java.io.*;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.FileSystems;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.*;
import javax.mail.internet.*;

@WebServlet(name = "FinishBookingServlet", urlPatterns = {"/FinishBooking"})
public class FinishBookingServlet extends HttpServlet {

    // Handles HTTP GET requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String book_Id_raw = request.getParameter("id");
        String status = request.getParameter("status");
        String discountCost = request.getParameter("discountCost");
        String discountId = request.getParameter("discountId");

        KhanhDB u = new KhanhDB();
        ThienDB thienDB = new ThienDB();
        UserDB userDB = new UserDB();
        Booking book = new Booking();
        int discountIdInt = 0;
        int book_Id = Integer.parseInt(book_Id_raw);

        if (status.contains("Complete")) {
            try {
                u.updateBookingStatusToBooked(book_Id);
                if (discountCost != null) {
                    discountIdInt = Integer.parseInt(discountId);
                    u.decrementDiscountQuantity(discountIdInt);
                }
                book = u.getBookingById(book_Id);
                u.importBill(book.getTotal_Cost(), LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")), "QR", book_Id);
                User user = userDB.getUserFromSession(request.getSession());

                if ("Booked".equalsIgnoreCase(book.getBook_Status())) {
                    sendBookingConfirmationEmail(request, user.getEmail(), book, user);
                    setBalanceAfterBookingSuccess(book, request, response);
                    thienDB.addNotification(user.getUser_Id(), "You just booked " + book.getTour_Name());
                    thienDB.addNotification(new CompanyDB().getProviderByTourId(book.getTour_Id()).getUser_Id(),
                            user.getFirst_Name() + " " + user.getLast_Name() + " just booked your tour " + book.getTour_Name());
                    response.getWriter().write("Email sent successfully!");
                } else {
                    response.getWriter().write("Tour status is not 'Booked'.");
                }
            } catch (SQLException ex) {
                Logger.getLogger(FinishBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        request.setAttribute("booking", book);
        request.getRequestDispatcher("/booked-tour.jsp").forward(request, response);
    }

    // Upload PDF to Firebase Storage using REST API
    private String uploadPdfToFirebase(String pdfFilePath) throws IOException {
        File pdfFile = new File(pdfFilePath);
        String uniqueFileName = "bookingConfirmation_" + System.currentTimeMillis() + ".pdf"; // Add timestamp to file name
        String firebaseStorageUrl = "https://firebasestorage.googleapis.com/v0/b/tourhub-41aa5.appspot.com/o/bookingConfirmations%2F"
                + uniqueFileName + "?uploadType=media";

        HttpURLConnection connection = (HttpURLConnection) new URL(firebaseStorageUrl).openConnection();
        connection.setDoOutput(true);
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/pdf");

        try (OutputStream outputStream = connection.getOutputStream(); FileInputStream pdfStream = new FileInputStream(pdfFile)) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = pdfStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }

        int responseCode = connection.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            return "https://firebasestorage.googleapis.com/v0/b/tourhub-41aa5.appspot.com/o/bookingConfirmations%2F"
                    + uniqueFileName + "?alt=media";
        } else {
            throw new IOException("Failed to upload file. HTTP response code: " + responseCode);
        }
    }

    // Send Booking Confirmation Email with QR Code Attachment
    public void sendBookingConfirmationEmail(HttpServletRequest request, String toEmail, Booking bookedDetail, User userBooking) {
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
            File uploadFolder = getFolderUpload(request);
            String pdfFilePath = uploadFolder.getAbsolutePath() + "/bookingConfirmation_" + System.currentTimeMillis() + ".pdf"; // Unique PDF name
            generateBookingPDF(bookedDetail, userBooking, pdfFilePath);
            String pdfDownloadUrl = uploadPdfToFirebase(pdfFilePath);

            // Generate QR Code for the PDF link
            String qrCodePath = generateQrCode(pdfDownloadUrl);

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Tour Booking Confirmation");

            String emailContent = "Dear " + userBooking.getFirst_Name() + " " + userBooking.getLast_Name() + ",\n\n"
                    + "Thank you for booking your tour with us! We are delighted to confirm your reservation. Here are the details of your tour:\n\n"
                    + "Booking ID: " + bookedDetail.getBook_Id() + "\n"
                    + "Tour Name: " + bookedDetail.getTour_Name() + "\n"
                    + "Tour Date: " + bookedDetail.getTour_Date() + "\n"
                    + "Number of Slots Booked: " + bookedDetail.getSlot_Order() + "\n"
                    + "Booking Details: " + bookedDetail.getBooking_Detail() + "\n"
                    + "Tour Option: " + bookedDetail.getOption_Name() + "\n\n"
                    + "Please show this email to checkout.\n\n"
                    + "If you have any questions or need further assistance, please do not hesitate to reach out to us.\n\n"
                    + "We look forward to providing you with an unforgettable experience!\n\n"
                    + "Best regards,\nTourHub - Buy a tour without leaving your home";

            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setText(emailContent);

            // Add QR Code as image attachment
            MimeBodyPart qrCodeAttachment = new MimeBodyPart();
            qrCodeAttachment.attachFile(qrCodePath);

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(textPart);
            multipart.addBodyPart(qrCodeAttachment); // Attach the QR Code image
            message.setContent(multipart);

            Transport.send(message);
            System.out.println("Email sent successfully with Firebase PDF link in QR code!");

        } catch (MessagingException | IOException | DocumentException | WriterException e) {
            e.printStackTrace();
        }
    }

    // Generate QR Code for the PDF link
    private String generateQrCode(String pdfDownloadUrl) throws WriterException, IOException {
        String qrCodePath = "QRCode_" + System.currentTimeMillis() + ".png";  // Add timestamp to make QR code name unique
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        int width = 300;
        int height = 300;

        // Generate the QR code as a BitMatrix
        BitMatrix bitMatrix = qrCodeWriter.encode(pdfDownloadUrl, BarcodeFormat.QR_CODE, width, height);

        // Define the file path to save the QR code image
        java.nio.file.Path path = FileSystems.getDefault().getPath(qrCodePath);

        // Write the BitMatrix as an image to the specified file path
        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);

        return qrCodePath;  // Return the path to the QR code image file
    }

    // Generate Booking PDF
    private void generateBookingPDF(Booking bookedDetail, User userBooking, String pdfFilePath) throws DocumentException, IOException {
        Document document = new Document();
        PdfWriter.getInstance(document, new FileOutputStream(pdfFilePath));
        document.open();
        document.add(new Paragraph("Booking Confirmation"));
        document.add(new Paragraph("Dear " + userBooking.getFirst_Name() + " " + userBooking.getLast_Name() + ","));
        document.add(new Paragraph("Thank you for booking your tour with us!"));
        document.add(new Paragraph("Booking ID: " + bookedDetail.getBook_Id()));
        document.add(new Paragraph("Tour Name: " + bookedDetail.getTour_Name()));
        document.add(new Paragraph("Tour Date: " + bookedDetail.getTour_Date()));
        document.add(new Paragraph("Number of Slots Booked: " + bookedDetail.getSlot_Order()));
        document.add(new Paragraph("Booking Details: " + bookedDetail.getBooking_Detail()));
        document.add(new Paragraph("Tour Option: " + bookedDetail.getOption_Name()));
        document.close();
    }

    // Create folder upload path
    private File getFolderUpload(HttpServletRequest request) {
        File folder = new File(request.getServletContext().getRealPath("/uploads"));
        if (!folder.exists()) {
            folder.mkdirs();
        }
        return folder;
    }

    // Update company balance after booking success
    public void setBalanceAfterBookingSuccess(Booking booking, HttpServletRequest request, HttpServletResponse response) {
        Company company = new CompanyDB().getProviderByTourId(booking.getTour_Id());
        if (company != null && "Booked".equalsIgnoreCase(booking.getBook_Status())) {
            company.setBalance(company.getBalance().add(booking.getTotal_Cost().multiply(new BigDecimal("0.9"))));
            new CompanyDB().updateCompanyBalance(company);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to finish booking and send confirmation email with PDF.";
    }
}
