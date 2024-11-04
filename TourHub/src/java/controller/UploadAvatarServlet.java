/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DataAccess.ThienDB;
import DataAccess.UserDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import model.User;

/**
 *
 * @author NOMNOM
 */
@MultipartConfig
@WebServlet(name = "UploadAvatarServlet", urlPatterns = {"/UploadAvatarServlet"})
public class UploadAvatarServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "../../web/assests/images/avatar"; // Thư mục lưu ảnh upload
    private static final String BACKUP_DIR = "../../web/assests/images/backupavatar"; // Thư mục lưu bản sao ảnh

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tệp từ request
        Part filePart = request.getPart("avatar");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Đường dẫn thư mục ảnh upload
        String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIR; // Thêm "/" vào đây
        System.out.println("Upload Path: " + uploadPath);

        // Tạo thư mục upload nếu chưa có
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Lưu tệp ảnh vào thư mục upload
        String uploadedFilePath = uploadPath + File.separator + fileName;
        filePart.write(uploadedFilePath);

        // Tạo bản sao của ảnh trong thư mục backup
        String backupPath = getServletContext().getRealPath("/") + BACKUP_DIR; // Thêm "/" vào đây
        File backupDir = new File(backupPath);
        if (!backupDir.exists()) {
            backupDir.mkdirs();
        }

        // Đường dẫn file backup
        String backupFilePath = backupPath + File.separator + fileName;
        copyFile(uploadedFilePath, backupFilePath); // Sao chép ảnh

        // Lấy userId từ session
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        int userId = currentUser.getUser_Id();

        // Lưu đường dẫn tương đối vào database
        String avatarPath = "assests\\images\\avatar" + "\\" + fileName;
        ThienDB dao = new ThienDB();
        boolean isUpdated = dao.updateUserAvatar(userId, avatarPath);

        if (isUpdated) {
            System.out.println("Avatar updated and saved successfully.");
        } else {
            System.out.println("Failed to update avatar.");
        }
        currentUser.setAvatar(avatarPath);  // Cập nhật avatar trong session
        request.getSession().setAttribute("currentUser", currentUser);  // Cập nhật session
        // Chuyển hướng về trang profile
        response.sendRedirect("user");
    }

    // Hàm sao chép file từ nguồn sang đích
    private void copyFile(String sourcePath, String destPath) throws IOException {
        try (FileInputStream fis = new FileInputStream(sourcePath); FileOutputStream fos = new FileOutputStream(destPath)) {

            byte[] buffer = new byte[1024];
            int length;
            while ((length = fis.read(buffer)) > 0) {
                fos.write(buffer, 0, length);
            }
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
        processRequest(request, response);
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
