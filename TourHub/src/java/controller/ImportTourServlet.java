package controller;

import DataAccess.TourDB;
import utils.CSVReader;
import model.Tour;

import java.io.IOException;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import utils.RemoveDiacritics;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
@WebServlet(name = "ImportTourServlet", urlPatterns = {"/import-tour"})
public class ImportTourServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<!DOCTYPE html>");
        response.getWriter().println("<html>");
        response.getWriter().println("<head>");
        response.getWriter().println("<title>Servlet ImportTourServlet</title>");
        response.getWriter().println("</head>");
        response.getWriter().println("<body>");
        response.getWriter().println("<h1>Servlet ImportTourServlet at " + request.getContextPath() + "</h1>");
        response.getWriter().println("</body>");
        response.getWriter().println("</html>");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        String message = "";

        if (action == null) {
            response.getWriter().println("No action specified.");
            return;
        }

        switch (action) {
            case "save-import":
                // Handle file upload
                Part filePart = request.getPart("file");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = filePart.getSubmittedFileName();

                    // Check if the file is a .csv file
                    if (!fileName.endsWith(".csv")) {
                        message = "Invalid file type. Please upload a .csv file.";
                        request.setAttribute("message", message);
                        request.getRequestDispatcher("my-tour").forward(request, response);
                        return;  // Stop further execution if the file is not a .csv file
                    }

                    File uploadFolder = getFolderUpload(request);
                    File file = new File(uploadFolder, fileName);

                    try (InputStream fileContent = filePart.getInputStream(); FileOutputStream outputStream = new FileOutputStream(file)) {
                        int read;
                        byte[] bytes = new byte[1024];
                        while ((read = fileContent.read(bytes)) != -1) {
                            outputStream.write(bytes, 0, read);
                        }
                        message = "File uploaded and tour added successfully!";
                    } catch (IOException e) {
                        message = "Failed to read the file.";
                        e.printStackTrace();
                    }
                } else {
                    message = "No file selected for upload.";
                }
                request.setAttribute("message", message);
                request.getRequestDispatcher("import-tour?action=save-to-db").forward(request, response);
                CSVReader fileReader = new CSVReader();
                fileReader.deleteAllFilesInDir(getFolderUpload(request).toString());
                break;
            case "save-to-db":
                String msg = "";
                try {
                    saveTourImportCSV(request, response);
                } catch (SQLException | IOException ex) {
                    msg = "Failed to add tours.";
                    ex.printStackTrace();
                }
                request.getRequestDispatcher("my-tour").forward(request, response);
                break;
            default:
                response.getWriter().println("Invalid action specified.");
                break;
        }
    }

    public void saveTourImportCSV(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {

        CSVReader fileReader = new CSVReader();
        File fileAdded = fileReader.getLatestFileFromDir(getFolderUpload(request).toString());
        List<Tour> toursAdded = fileReader.readTourFromFile(fileAdded.toString());
        String tourImg = "";
        TourDB tourDB = new TourDB();

        for (Tour tour : toursAdded) {
            tourDB.saveTourToDatabase(request, tour.getTour_Name(), tour.getTour_Description(),
                    tour.getStart_Date().toString(), tour.getEnd_Date().toString(), new RemoveDiacritics().removeAccent(tour.getLocation()),
                    tour.getTotal_Time(), tour.getSlot(), tourImg);
        }

    }

    private File getFolderUpload(HttpServletRequest request) {
        String uploadPath = request.getServletContext().getRealPath("/assests/tour-imported");
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
