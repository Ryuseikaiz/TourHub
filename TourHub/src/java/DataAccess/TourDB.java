/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DataAccess;

import static DataAccess.DatabaseInfo.DBURL;
import static DataAccess.DatabaseInfo.DRIVERNAME;
import static DataAccess.DatabaseInfo.PASSDB;
import static DataAccess.DatabaseInfo.USERDB;
import jakarta.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;
import java.util.Arrays;
import model.Tour;

/**
 *
 * @author NOMNOM
 */
public class TourDB implements DatabaseInfo {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver" + e);
        }
        try {
            Connection con = DriverManager.getConnection(DBURL, USERDB, PASSDB);
            return con;
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    //Get all tour
    public List<Tour> getTours() {
        List<Tour> tours = new ArrayList<>();
        String query = "SELECT * FROM Tour WHERE tour_Status = 'Active'";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String tourId = rs.getString("tour_Id");
                String tourName = rs.getString("tour_Name");
                String description = rs.getString("tour_Description");
                Date startDate = rs.getDate("start_Date");
                Date endDate = rs.getDate("end_Date");
                float avgRating = rs.getFloat("average_Review_Rating");
                int numOfReview = rs.getInt("number_Of_Review");
                String totalTime = rs.getString("total_Time");
                BigDecimal price = rs.getBigDecimal("price");
                int slot = rs.getInt("slot");
                String location = rs.getString("location");
                String tourStatus = rs.getString("tour_Status");
                int companyId = rs.getInt("company_Id");
                Date createdAt = rs.getDate("created_At");
                String tourImg = rs.getString("tour_Img");

                List<String> tourImgList = splitImages(tourImg);
                Tour tour = new Tour(tourId, tourName, description, startDate, endDate, location, numOfReview, avgRating, numOfReview, totalTime, price, slot, tourStatus, createdAt, tourImgList, companyId);
                tours.add(tour);
            }

        } catch (SQLException ex) {
            Logger.getLogger(TourDB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return tours;
    }

    public float getTotalProfit(int companyId) {
        String query = "SELECT SUM(total_Cost) AS [Total Profit] FROM Booking b JOIN Tour t ON b.tour_Id = t.tour_Id WHERE company_Id = ? AND book_Status = 'Booked'"
                + "AND MONTH(b.book_Date) = MONTH(GETDATE()) "
                + "AND YEAR(b.book_Date) = YEAR(GETDATE())";
        float totalProfit = 0;  // Variable to store the total sum of profit

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, companyId);  // Set the tour_Id parameter
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalProfit = rs.getInt(1);  // Retrieve the sum from the result set
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(TourDB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return totalProfit;  // Return the total visit count
    }

    public int getTodayVisit(int companyId) {
        int visitCount = 0;
        String query = "SELECT COUNT(*) AS visit_count FROM TourVisitCount WHERE company_id = ? AND visitDate = ?";

        try (Connection connection = getConnect(); PreparedStatement pstmt = connection.prepareStatement(query)) {
            // Set the companyId parameter
            pstmt.setInt(1, companyId);
            pstmt.setDate(2, new Date(System.currentTimeMillis()));
            // Execute the query and retrieve the result
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    visitCount = rs.getInt("visit_count");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider using a logging framework
        }

        return visitCount;
    }

    public int addNewCountTourVisit(String tourId) {
        String query = "INSERT INTO TourVisitCount (tour_Id, company_Id) VALUES (?, ?)";
        int companyId = 0;
        try {
            companyId = getCompanyIdFromTourId(tourId);
        } catch (SQLException ex) {
            Logger.getLogger(TourDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, tourId);  // Set the tour_Id parameter
            stmt.setInt(2, companyId);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated;
        } catch (SQLException ex) {
            Logger.getLogger(TourDB.class.getName()).log(Level.SEVERE, null, ex);
            return 0;  // Return false if there was an error
        }
    }

    public int getCompanyIdFromTourId(String tourId) throws SQLException {
        String query = "SELECT c.company_Id FROM Company c "
                + "JOIN Tour t ON c.company_Id = t.company_Id "
                + "WHERE t.tour_Id = ?";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, tourId);
            try (ResultSet resultSet = stmt.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt("company_Id");
                } else {
                    throw new SQLException("No company found for tourId: " + tourId);
                }
            }
        }
    }

    //With a day input
    public float getTotalProfitAMonth(int companyId, java.util.Date visitDate) {
        String query = "SELECT SUM(total_Cost) AS [Total Profit] FROM Booking b"
                + " JOIN Tour t ON b.tour_Id = t.tour_Id WHERE company_Id = ?"
                + " AND book_Status = 'Booked'"
                + " AND MONTH(book_Date) = MONTH(?)"
                + "AND YEAR(book_Date) = YEAR(?)";
        float totalProfitAMonth = 0;  // Variable to store the total profit a month
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, companyId);  // Set the companyId parameter
            stmt.setDate(2, new java.sql.Date(visitDate.getTime())); // Set the visitDate parameter
            stmt.setDate(3, new java.sql.Date(visitDate.getTime())); // Set the visitDate parameter

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalProfitAMonth = rs.getInt(1);  // Retrieve the sum from the result set
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(TourDB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return totalProfitAMonth;  // Return the total profit a month
    }

    public int getTodayVisitsByDate(int companyId, java.util.Date visitDate) {
        int visitCount = 0;
        String query = "SELECT COUNT(*) AS visit_count FROM TourVisitCount WHERE company_Id = ? "
                + "AND DAY(visitDate) = DAY(?) "
                + "AND MONTH(visitDate) = MONTH(?) "
                + "AND YEAR(visitDate) = YEAR(?)";

        try (Connection connection = getConnect(); PreparedStatement pstmt = connection.prepareStatement(query)) {

            // Set parameters for company ID and visit date
            pstmt.setInt(1, companyId);
            pstmt.setDate(2, new java.sql.Date(visitDate.getTime())); // For DAY() comparison
            pstmt.setDate(3, new java.sql.Date(visitDate.getTime())); // For MONTH() comparison
            pstmt.setDate(4, new java.sql.Date(visitDate.getTime())); // For YEAR() comparison

            // Execute the query and retrieve the result
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    visitCount = rs.getInt("visit_count"); // Retrieve the visit count using alias
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider using a logging framework like SLF4J for production
        }

        return visitCount;
    }

    public void saveTourToDatabase(HttpServletRequest request, String tourName, String tourDescription, String startDate,
            String endDate, String location, String duration, int slot, String tourImg) throws SQLException {
        int companyId = new UserDB().getProviderIdFromUserId(new UserDB().getUserFromSession(request.getSession()).getUser_Id());
        String tourId = generateTourId();
        String query = "INSERT INTO Tour (tour_Id, tour_Name, tour_Description, start_Date, end_Date, "
                + "location, total_Time, slot, tour_Status, tour_Img, company_Id, "
                + "purchases_Time, average_Review_Rating, number_Of_Review) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, 0.0, 0)";  // Default values for purchases, rating, reviews

        try (Connection connection = getConnect(); PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, tourId);
            pstmt.setString(2, tourName);
            pstmt.setString(3, tourDescription);
            pstmt.setString(4, startDate);
            pstmt.setString(5, endDate);
            pstmt.setString(6, location);
            pstmt.setString(7, duration);
            pstmt.setInt(8, slot);
            pstmt.setString(9, "Pending");
            pstmt.setString(10, tourImg);
            pstmt.setInt(11, companyId);
            pstmt.executeUpdate();
        }
    }

    private String generateTourId() {
        // Use a random number generator to create a unique ID
        Random random = new Random();
        int idNumber = random.nextInt(10000000); // Generate a number between 0-9999999
        return "T" + String.format("%07d", idNumber); // Format the number to be 7 digits long
    }

    public Tour getTourFromTourID(String tourId, int companyIdInput) {
        Tour tour = null;
        String query = "SELECT * FROM Tour WHERE tour_Id = ? and company_Id = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            // Set the parameter for the prepared statement
            stmt.setString(1, tourId);
            stmt.setInt(2, companyIdInput);
            // Execute the query
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String tourName = rs.getString("tour_Name");
                    String description = rs.getString("tour_Description");
                    Date startDate = rs.getDate("start_Date");
                    Date endDate = rs.getDate("end_Date");
                    float avgRating = rs.getFloat("average_Review_Rating");
                    int numOfReview = rs.getInt("number_Of_Review");
                    String totalTime = rs.getString("total_Time");
                    BigDecimal price = rs.getBigDecimal("price");
                    int slot = rs.getInt("slot");
                    String location = rs.getString("location");
                    String tourStatus = rs.getString("tour_Status");
                    int companyId = rs.getInt("company_Id");
                    Date createdAt = rs.getDate("created_At");
                    String tourImg = rs.getString("tour_Img");

                    List<String> tourImgList = splitImages(tourImg);
                    // Create a new Tour object with the retrieved data
                    tour = new Tour(tourId, tourName, description, startDate, endDate, location, numOfReview, avgRating, numOfReview, totalTime, price, slot, tourStatus, createdAt, tourImgList, companyId);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(TourDB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return tour; // Return the Tour object, or null if not found
    }

    public Tour getTourFromTourID(String tourId) {
        Tour tour = null;
        String query = "SELECT * FROM Tour WHERE tour_Id = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            // Set the parameter for the prepared statement
            stmt.setString(1, tourId);
            // Execute the query
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String tourName = rs.getString("tour_Name");
                    String description = rs.getString("tour_Description");
                    Date startDate = rs.getDate("start_Date");
                    Date endDate = rs.getDate("end_Date");
                    float avgRating = rs.getFloat("average_Review_Rating");
                    int numOfReview = rs.getInt("number_Of_Review");
                    String totalTime = rs.getString("total_Time");
                    BigDecimal price = rs.getBigDecimal("price");
                    int slot = rs.getInt("slot");
                    String location = rs.getString("location");
                    String tourStatus = rs.getString("tour_Status");
                    int companyId = rs.getInt("company_Id");
                    Date createdAt = rs.getDate("created_At");
                    String tourImg = rs.getString("tour_Img");

                    List<String> tourImgList = splitImages(tourImg);
                    // Create a new Tour object with the retrieved data
                    tour = new Tour(tourId, tourName, description, startDate, endDate, location, numOfReview, avgRating, numOfReview, totalTime, price, slot, tourStatus, createdAt, tourImgList, companyId);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(TourDB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return tour; // Return the Tour object, or null if not found
    }

    //Get all tour
    public List<Tour> getToursByProviderID(int companyId) {
        List<Tour> tours = new ArrayList<>();
        String query = "SELECT * FROM Tour WHERE company_Id = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            // Set the companyId parameter in the PreparedStatement
            stmt.setInt(1, companyId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String tourId = rs.getString("tour_Id");
                    String tourName = rs.getString("tour_Name");
                    String description = rs.getString("tour_Description");
                    Date startDate = rs.getDate("start_Date");
                    Date endDate = rs.getDate("end_Date");
                    float avgRating = rs.getFloat("average_Review_Rating");
                    int numOfReview = rs.getInt("number_Of_Review");
                    String totalTime = rs.getString("total_Time");
                    BigDecimal price = rs.getBigDecimal("price");
                    int slot = rs.getInt("slot");
                    String location = rs.getString("location");
                    String tourStatus = rs.getString("tour_Status");
                    Date createdAt = rs.getDate("created_At");
                    String tourImg = rs.getString("tour_Img");

                    List<String> tourImgList = splitImages(tourImg);
                    Tour tour = new Tour(tourId, tourName, description, startDate, endDate, location, numOfReview, avgRating, numOfReview, totalTime, price, slot, tourStatus, createdAt, tourImgList, companyId);
                    tours.add(tour);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(TourDB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return tours;
    }
    //Get all tour

    public List<Tour> getToursByProviderID(int companyId, String status) {
        List<Tour> tours = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM Tour WHERE company_Id = ?");

        // Add conditional status filtering
        if ("Pending".equalsIgnoreCase(status)) {
            query.append(" AND tour_Status = 'Pending'");
        } else if ("Active".equalsIgnoreCase(status)) {
            query.append(" AND tour_Status = 'Active'");
        } else if ("Hidden".equalsIgnoreCase(status)) {
            query.append(" AND tour_Status = 'Hidden'");
        } else if ("Banned".equalsIgnoreCase(status)) {
            query.append(" AND tour_Status = 'Banned'");
        } else if ("Cancelled".equalsIgnoreCase(status)) {
            query.append(" AND tour_Status = 'Cancelled'");
        }
// If "All" or any other value, no additional status filter is added
        System.out.println(query);
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query.toString())) {
            // Set the companyId parameter in the PreparedStatement
            stmt.setInt(1, companyId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String tourId = rs.getString("tour_Id");
                    String tourName = rs.getString("tour_Name");
                    String description = rs.getString("tour_Description");
                    Date startDate = rs.getDate("start_Date");
                    Date endDate = rs.getDate("end_Date");
                    float avgRating = rs.getFloat("average_Review_Rating");
                    int numOfReview = rs.getInt("number_Of_Review");
                    String totalTime = rs.getString("total_Time");
                    BigDecimal price = rs.getBigDecimal("price");
                    int slot = rs.getInt("slot");
                    String location = rs.getString("location");
                    String tourStatus = rs.getString("tour_Status");
                    Date createdAt = rs.getDate("created_At");
                    String tourImg = rs.getString("tour_Img");

                    List<String> tourImgList = splitImages(tourImg);
                    Tour tour = new Tour(tourId, tourName, description, startDate, endDate, location, numOfReview, avgRating, numOfReview, totalTime, price, slot, tourStatus, createdAt, tourImgList, companyId);
                    tours.add(tour);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(TourDB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return tours;
    }

    public boolean setTourStatusToHidden(String tourId) {
        String sql = "UPDATE Tour SET tour_Status = 'Hidden' WHERE tour_Id = ?";

        try (Connection conn = getConnect(); // Assuming you have a method to get DB connection
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, tourId); // Set the tourId for which you want to hide the tour
            int affectedRows = pstmt.executeUpdate();

            return affectedRows > 0 ? true : false;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean setTourStatusToActive(String tourId) {
        String sql = "UPDATE Tour SET tour_Status = 'Active' WHERE tour_Id = ?";

        try (Connection conn = getConnect(); // Assuming you have a method to get DB connection
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, tourId); // Set the tourId for which you want to hide the tour
            int affectedRows = pstmt.executeUpdate();

            return affectedRows > 0 ? true : false;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //get all tour
    public static List<Tour> getAllTours() {
        List<Tour> tourList = new ArrayList<>();
        Connection con = getConnect();  // Kết nối tới database
        if (con == null) {
            System.out.println("Failed to make connection!");
            return tourList;
        }

        String sql = "SELECT * FROM Tour";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Tạo đối tượng Tour từ kết quả truy vấn
                Tour tour = new Tour();
                tour.setTour_Id(rs.getString("tour_Id"));
                tour.setTour_Name(rs.getString("tour_Name"));
                tour.setTour_Description(rs.getString("tour_Description"));
                tour.setStart_Date(rs.getDate("start_Date"));
                tour.setEnd_Date(rs.getDate("end_Date"));
                tour.setLocation(rs.getString("location"));
                tour.setPurchases_Time(rs.getInt("purchases_Time"));
                tour.setAverage_Review_Rating(rs.getDouble("average_Review_Rating"));
                tour.setNumber_Of_Review(rs.getInt("number_Of_Review"));
                tour.setTotal_Time(rs.getString("total_Time"));
                tour.setPrice(rs.getBigDecimal("price"));
                tour.setSlot(rs.getInt("slot"));
                tour.setTour_Status(rs.getString("tour_Status"));
                tour.setCreated_At(rs.getDate("created_At"));
                //tour.setTour_Img(rs.getString("tour_Img"));
                tour.setCompany_Id(rs.getInt("company_Id"));

                // Thêm đối tượng Tour vào danh sách
                tourList.add(tour);
            }
        } catch (SQLException e) {
            System.out.println("Error while fetching tours: " + e.getMessage());
        } finally {
            try {
                if (con != null) {
                    con.close(); // Đóng kết nối sau khi sử dụng
                }
            } catch (SQLException e) {
                System.out.println("Error closing connection: " + e.getMessage());
            }
        }

        return tourList;
    }
//insert a tour
//delete a tour
//update a tour

    public List<String> splitImages(String concatenatedImages) {
        // Split the string by semicolon
        String[] imagesArray = concatenatedImages.split(";");

        // Convert the array to a List
        List<String> imageList = new ArrayList<>(Arrays.asList(imagesArray));

        return imageList;
    }

    public static void main(String[] args) {
        List<Tour> tours = new TourDB().getToursByProviderID(2);
        for (Tour tour : tours) {
            System.out.println(tour.getPrice());
        }
    }
}
