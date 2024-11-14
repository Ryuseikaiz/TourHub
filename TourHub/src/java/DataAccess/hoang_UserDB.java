/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DataAccess;

import static DataAccess.BookingDB.getConnect;
import static DataAccess.TourDB.getConnect;
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import model.Booking;
import model.BookingDetails;
import model.Discount;
import model.Notification;
import model.Review;
import model.Tour;
import utils.CSVReader;
import utils.RemoveDiacritics;

/**
 *
 * @author hoang
 */
public class hoang_UserDB implements DatabaseInfo {

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
//USERDB

    public Integer getProviderIdFromUserId(int userId) throws SQLException {
        String query = "SELECT c.company_Id FROM [User] u JOIN Company c ON u.user_Id = c.user_Id WHERE u.user_Id = ?";
        Integer providerId = null;

        try (Connection connection = getConnect(); PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    providerId = rs.getInt("company_Id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // or handle exception as needed
        }

        return providerId; // This will return null if no providerId is found
    }

    public Integer getUserIdFromProviderId(int companyId) {
        String query = "SELECT u.user_Id FROM [User] u JOIN Company c ON u.user_Id = c.user_Id WHERE c.company_Id= ?";
        Integer providerId = null;

        try (Connection connection = getConnect(); PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, companyId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    providerId = rs.getInt("company_Id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                throw e; // or handle exception as needed
            } catch (SQLException ex) {
                Logger.getLogger(hoang_UserDB.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return providerId; // This will return null if no providerId is found
    }
//BOOKINGDB

    public int getTotalBookingThisMonth(int companyId) {
        int bookingCount = 0;
        String query = "SELECT COUNT(*) AS booking_count "
                + "FROM Booking b "
                + "JOIN Customer c ON b.cus_Id = c.cus_Id "
                + "JOIN [User] u ON c.user_Id = u.user_Id "
                + "JOIN Tour t ON b.tour_Id = t.tour_Id "
                + "WHERE t.company_Id = ? "
                + "AND MONTH(b.book_Date) = MONTH(GETDATE()) "
                + "AND YEAR(b.book_Date) = YEAR(GETDATE())"
                + "AND book_Status = 'Booked'";

        try (Connection connection = getConnect(); PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, companyId); // Set the company ID parameter

            // Execute the query and retrieve the result
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    bookingCount = rs.getInt("booking_count");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider using a logging framework for production
        }

        return bookingCount;
    }

    public List<BookingDetails> getBookingDetails(int companyId) {
        String query
                = "SELECT b.book_Id, t.tour_Name, "
                + "CONCAT(u.first_Name, ' ', u.last_Name) AS cus_Name, "
                + "b.slot_Order, b.book_Status, b.total_Cost, "
                + "b.book_Date " // Ensure this is the correct column name for the booking date
                + "FROM Booking b "
                + "JOIN Customer c ON b.cus_Id = c.cus_Id "
                + "JOIN [User] u ON c.user_Id = u.user_Id "
                + "JOIN Tour t ON b.tour_Id = t.tour_Id "
                + "WHERE company_Id = ?";

        // Initialize an empty list to hold the booking details
        List<BookingDetails> bookingDetailsList = new ArrayList<>();

        try {
            // Try-with-resources to manage the connection and statement
            try (Connection con = getConnect(); PreparedStatement statement = con.prepareStatement(query)) {
                statement.setInt(1, companyId);
                // Execute the query and get the result set
                try (ResultSet resultSet = statement.executeQuery()) {
                    // Iterate through the result set
                    while (resultSet.next()) {
                        // Extract data from the current row
                        int bookId = resultSet.getInt("book_Id");
                        String tourName = resultSet.getString("tour_Name");
                        String customerName = resultSet.getString("cus_Name");
                        int slotOrder = resultSet.getInt("slot_Order");
                        String bookStatus = resultSet.getString("book_Status");
                        double totalCost = resultSet.getDouble("total_Cost");
                        Date bookedDay = resultSet.getDate("book_Date");  // Ensure you're using the correct column

                        // Create a new BookingDetail object and add it to the list                        
                        BookingDetails bookingDetail = new BookingDetails(bookId, tourName, customerName, slotOrder, bookStatus, totalCost, bookedDay);
                        bookingDetailsList.add(bookingDetail);
                    }
                }
            }
        } catch (SQLException e) {
            // Handle the exception: log it and optionally rethrow it or return an empty list
            System.err.println("An error occurred while fetching booking details: " + e.getMessage());
            e.printStackTrace();
            // Optionally, rethrow the exception if you need the calling method to handle it
            // throw new RuntimeException("Database error occurred", e);
        }
        return bookingDetailsList;
    }

    //With day 
    public int getTotalBookingAMonthByDate(int companyId, java.util.Date date) {
        int bookingCount = 0;
        String query = "SELECT COUNT(*) AS booking_count "
                + "FROM Booking b "
                + "JOIN Customer c ON b.cus_Id = c.cus_Id "
                + "JOIN [User] u ON c.user_Id = u.user_Id "
                + "JOIN Tour t ON b.tour_Id = t.tour_Id "
                + "WHERE t.company_Id = ? "
                + "AND book_Status = 'Booked'"
                + "AND MONTH(b.book_Date) = MONTH(?) "
                + "AND YEAR(b.book_Date) = YEAR(?)";

        try (Connection connection = getConnect(); PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, companyId); // Set the company ID parameter
            pstmt.setDate(2, new java.sql.Date(date.getTime())); // Set the date parameter for month and year comparison
            pstmt.setDate(3, new java.sql.Date(date.getTime())); // Set the date parameter for year comparison

            // Execute the query and retrieve the result
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    bookingCount = rs.getInt("booking_count");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider using a logging framework for production
        }

        return bookingCount;
    }

    public int[] getTotalBookingMonthly(int companyId, int year) {
        int[] bookingCounts = new int[12]; // Array to hold the total bookings for each month
        String query = "SELECT COUNT(*) AS booking_count "
                + "FROM Booking b "
                + "JOIN Customer c ON b.cus_Id = c.cus_Id "
                + "JOIN [User] u ON c.user_Id = u.user_Id "
                + "JOIN Tour t ON b.tour_Id = t.tour_Id "
                + "WHERE t.company_Id = ? "
                + "AND MONTH(b.book_Date) = ? "
                + "AND YEAR(b.book_Date) = ?";

        try (Connection connection = getConnect()) {
            for (int month = 1; month <= 12; month++) {
                try (PreparedStatement pstmt = connection.prepareStatement(query)) {
                    pstmt.setInt(1, companyId); // Set the company ID parameter
                    pstmt.setInt(2, month);     // Set the month parameter
                    pstmt.setInt(3, year);      // Set the year parameter

                    // Execute the query and retrieve the result
                    try (ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next()) {
                            bookingCounts[month - 1] = rs.getInt("booking_count");
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace(); // Handle exceptions appropriately in production code
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle connection issues appropriately in production code
        }

        return bookingCounts; // Returns an array containing total bookings for each month
    }

    public int getTotalBookingCurrentYear(int companyId) {
        // Get the current year dynamically
        int currentYear = LocalDate.now().getYear();

        // Get the monthly booking counts for the current year
        int[] monthlyBookings = getTotalBookingMonthly(companyId, currentYear);

        // Calculate the total number of bookings for the current year
        int totalBookings = 0;
        for (int bookings : monthlyBookings) {
            totalBookings += bookings; // Sum up the bookings for each month
        }

        return totalBookings; // Return the total bookings for the current year
    }

    public void acceptABooking(int bookId) {
        String sql = "UPDATE Booking SET book_Status = 'Booked' WHERE book_Status = 'Pending' AND book_Id = ?";

        try (Connection con = getConnect(); PreparedStatement statement = con.prepareStatement(sql)) {
            // Bind the bookId to the prepared statement
            statement.setInt(1, bookId); // Set the bookId in the prepared statement
            // Execute the update
            int rowEffect = statement.executeUpdate();
            System.out.println("Booking ID: " + bookId + " | Row Effect: " + rowEffect);
        } catch (SQLException e) {
            e.printStackTrace(); // Print exception details
        }
    }

    public Map<Integer, Integer> getBookingMonthly(int companyId, int year) {
        Map<Integer, Integer> monthlyBookings = new HashMap<>();
        String query = "SELECT MONTH(b.book_Date) AS month, COUNT(*) AS totalBookings "
                + "FROM Booking b "
                + "JOIN Tour t ON b.tour_Id = t.tour_Id "
                + "WHERE t.company_Id = ? "
                + "AND b.book_Status = 'Booked' " // Filter for only booked status
                + "AND YEAR(book_Date) = ?"
                + "GROUP BY MONTH(b.book_Date)"
                + "ORDER BY MONTH(b.book_Date)";

        try (Connection connection = getConnect(); PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, companyId); // Set the company ID parameter
            pstmt.setInt(2, year);
            // Execute the query and retrieve the result
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int month = rs.getInt("month");
                    int totalBookings = rs.getInt("totalBookings");
                    monthlyBookings.put(month, totalBookings); // Store the month and count in the map
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider using a logging framework for production
        }

        return monthlyBookings; // Return the map containing month and total bookings
    }

    public double[] getMonthlyProfitByYear(int companyId, int year) {
        // Array to hold profit for each month (12 months)
        double[] monthlyProfits = new double[12];
        double totalRevenue;
        double totalRefunds;

        for (int month = 1; month <= 12; month++) {
            totalRevenue = 0.0;
            totalRefunds = 0.0;

            String revenueQuery = "SELECT SUM(b.total_Cost * 0.9) AS TotalRevenue "
                    + "FROM Company c "
                    + "INNER JOIN Tour t ON c.company_Id = t.company_Id "
                    + "INNER JOIN Booking b ON b.tour_Id = t.tour_Id "
                    + "WHERE c.company_Id = ? "
                    + "AND MONTH(b.book_Date) = ? "
                    + "AND YEAR(b.book_Date) = ? "
                    + "AND b.book_Status = 'Booked'";

            try (Connection connection = getConnect()) {
                // Calculate total revenue for the month
                try (PreparedStatement revenueStmt = connection.prepareStatement(revenueQuery)) {
                    revenueStmt.setInt(1, companyId);
                    revenueStmt.setInt(2, month);
                    revenueStmt.setInt(3, year);
                    ResultSet revenueResult = revenueStmt.executeQuery();
                    if (revenueResult.next()) {
                        totalRevenue = revenueResult.getDouble("TotalRevenue");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Handle exceptions appropriately in production code
            }

            // Calculate profit for the month and store it in the array
            monthlyProfits[month - 1] = totalRevenue;
        }

        return monthlyProfits; // Returns an array containing monthly profits
    }

    public BigDecimal getTotalProfitCurrentYear(int companyId) {
        // Get the current year dynamically
        int currentYear = LocalDate.now().getYear();

        // Get the monthly profits for the current year
        double[] monthlyProfits = getMonthlyProfitByYear(companyId, currentYear);

        // Calculate the total profit by summing up the monthly profits
        BigDecimal totalProfit = BigDecimal.ZERO;
        for (double profit : monthlyProfits) {
            totalProfit = totalProfit.add(BigDecimal.valueOf(profit));
        }

        return totalProfit; // Return the total profit as a BigDecimal
    }

    public List<Map<String, Object>> getHotDestination(int companyId, int year) {
        List<Map<String, Object>> hotDestinations = new ArrayList<>();
        String query = "SELECT t.location, COUNT(b.tour_Id) AS bookingCount "
                + "FROM Company c "
                + "INNER JOIN Tour t ON c.company_Id = t.company_Id "
                + "INNER JOIN Booking b ON b.tour_Id = t.tour_Id "
                + "WHERE c.company_Id = ? AND YEAR(b.book_Date) = ?"
                + "GROUP BY t.location"; // Group by location to get booking counts

        try (Connection connection = getConnect(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            // Set the company ID in the prepared statement
            preparedStatement.setInt(1, companyId);
            preparedStatement.setInt(2, year);
            // Execute the query
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                // Process the results
                while (resultSet.next()) {
                    String location = resultSet.getString("location");
                    int bookingCount = resultSet.getInt("bookingCount");

                    // Create a map for the current destination
                    Map<String, Object> destination = new HashMap<>();
                    destination.put("location", location);
                    destination.put("count", bookingCount);

                    // Add the map to the list
                    hotDestinations.add(destination);
                }
            }
        } catch (SQLException e) {
            // Log the exception and ensure it's handled properly in your system         
        }

        // Return the list of hot destinations
        return hotDestinations;
    }

    public void updateBookingStatus(int bookingId, String newStatus) throws SQLException {
        // Ensure the new status is valid
        if (!newStatus.equals("Booked") && !newStatus.equals("Cancelled")) {
            throw new IllegalArgumentException("Invalid status. Status must be either 'Booked' or 'Cancelled'.");
        }

        String sql = "UPDATE booking SET book_Status = ? WHERE book_Id = ?"; // Adjust the table name as needed

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newStatus);
            stmt.setInt(2, bookingId);

            // Execute the update statement
            int rowsAffected = stmt.executeUpdate();

            // Optionally, check if the update was successful
            if (rowsAffected == 0) {
                throw new SQLException("No booking found with the specified ID.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;  // Rethrow or handle the exception as needed
        }
    }

    public void updateTour(Tour updatedTour) throws SQLException {
        String sql = "UPDATE Tour SET tour_Name = ?, tour_Description = ?, start_Date = ?, end_Date = ?, location = ?, "
                + "total_Time = ?, price = ?, slot = ?, tour_Status = ?, tour_Img = ? WHERE tour_Id = ?";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Set the parameters for the prepared statement
            stmt.setString(1, updatedTour.getTour_Name());
            stmt.setString(2, updatedTour.getTour_Description());

            // Assuming start_Date and end_Date are java.util.Date, convert them to java.sql.Date
            stmt.setDate(3, new java.sql.Date(updatedTour.getStart_Date().getTime()));
            stmt.setDate(4, new java.sql.Date(updatedTour.getEnd_Date().getTime()));

            stmt.setString(5, new RemoveDiacritics().removeAccent(updatedTour.getLocation()));
            stmt.setString(6, updatedTour.getTotal_Time());

            // Assuming price is BigDecimal
            stmt.setBigDecimal(7, updatedTour.getPrice());

            stmt.setInt(8, updatedTour.getSlot());
            stmt.setString(9, "Pending");
            // Assuming tour_Img is a List<String>, join them into a single string separated by semicolons
            List<String> images = updatedTour.getTour_Img();
            String imageFilenames = String.join(";", images);
            stmt.setString(10, imageFilenames);

            stmt.setString(11, updatedTour.getTour_Id()); // Assuming tour_Id is String

            // Execute the update statement
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error updating tour: " + e.getMessage());
        }
    }

    public List<Tour> getTourFromQuery(String query, int currentCompanyId) {
        List<Tour> tours = new ArrayList<>();
        String sql = "SELECT * "
                + "FROM Tour "
                + "WHERE tour_Id = ? "
                + "OR tour_Name COLLATE Vietnamese_CI_AI LIKE '%' + ? + '%'"
                + " OR location COLLATE Vietnamese_CI_AI LIKE '%' + ? + '%'"
                + "AND company_Id = ?;";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sql)) {
            // Set the parameters for the prepared statement
            stmt.setString(1, query);
            stmt.setString(2, query);
            stmt.setString(3, query);
            stmt.setInt(4, currentCompanyId);

            // Execute the query
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
                    int companyId = rs.getInt("company_Id");
                    Date createdAt = rs.getDate("created_At");
                    String tourImg = rs.getString("tour_Img");

                    List<String> tourImgList = splitImages(tourImg);
                    // Create a new Tour object with the retrieved data
                    Tour tour = new Tour(tourId, tourName, description, startDate, endDate, location,
                            numOfReview, avgRating, numOfReview, totalTime, price,
                            slot, tourStatus, createdAt, tourImgList, companyId);
                    // Add the Tour to the list
                    tours.add(tour);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(TourDB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return tours; // Return the list of Tour objects
    }

    public List<String> splitImages(String concatenatedImages) {
        // Split the string by semicolon
        String[] imagesArray = concatenatedImages.split(";");

        // Convert the array to a List
        List<String> imageList = new ArrayList<>(Arrays.asList(imagesArray));

        return imageList;
    }
    // Method to retrieve all tours based on sort order, location, and price range

    public List<Tour> SortProviderTour(String sortOrder, int companyId) {
        List<Tour> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Tour WHERE 1=1 AND company_Id = ?");

        // Determine sorting order based on dropdown options
        switch (sortOrder) {
            case "price-asc":
                sql.append(" ORDER BY price ASC");
                break;
            case "price-desc":
                sql.append(" ORDER BY price DESC");
                break;
            case "most-booking":
                sql.append(" ORDER BY purchases_Time DESC"); // Default to purchases for most booking
                break;
            case "pending-only":
                sql.append(" AND tour_Status = 'Pending'");
                break;
            case "active-only":
                sql.append(" AND tour_Status = 'Active'");
                break;
            case "hidden-tour":
                sql.append(" AND tour_Status = 'Hidden'");
                break;
            default:
                sql.append(" ORDER BY purchases_Time DESC"); // Fallback to purchases if no valid sortOrder is provided
                break;
        }

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            stmt.setInt(1, companyId);
            // Execute the query and process results
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                // Split the image URLs by ";"
                String imageUrlStr = rs.getString("tour_Img");
                List<String> imageUrlList = Arrays.asList(imageUrlStr.split(";"));

                // Create a new Tour object using the data from the result set
                Tour t = new Tour(
                        rs.getString("tour_Id"), // tourId
                        rs.getString("tour_Name"), // tourName
                        rs.getString("tour_Description"), // tourDescription
                        rs.getDate("start_Date"), // startDate
                        rs.getDate("end_Date"), // endDate
                        rs.getString("location"), // location
                        rs.getInt("purchases_Time"), // purchasesTime
                        rs.getDouble("average_Review_Rating"), // averageReviewRating
                        rs.getInt("number_Of_Review"), // numberOfReview
                        rs.getString("total_Time"), // totalTime
                        rs.getBigDecimal("price"), // price
                        rs.getInt("slot"), // slot
                        rs.getString("tour_Status"), // tourStatus
                        rs.getDate("created_At"), // createdAt
                        imageUrlList, // tourImg
                        rs.getInt("company_Id") // companyId
                );
                list.add(t);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Tour> searchTours(String searchTerm) {
        List<Tour> tours = new ArrayList<>();
        String query = "SELECT * FROM Tour WHERE tour_Name LIKE ?";

        try (Connection connection = getConnect(); PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, "%" + searchTerm + "%"); // Set the LIKE parameter

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
                    int companyId = rs.getInt("company_Id");
                    Date createdAt = rs.getDate("created_At");
                    String tourImg = rs.getString("tour_Img");

                    List<String> tourImgList = splitImages(tourImg); // Assuming this method exists

                    // Create a new Tour object with the retrieved data
                    Tour tour = new Tour(tourId, tourName, description, startDate, endDate, location,
                            numOfReview, avgRating, numOfReview, totalTime, price,
                            slot, tourStatus, createdAt, tourImgList, companyId);
                    // Add the Tour to the list
                    tours.add(tour);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions properly
        }
        return tours;
    }

    public void updateTourImages(String tourId, List<String> updatedImages) throws SQLException {
        // Convert the list of images into a comma-separated string
        String updatedImageString = String.join(";", updatedImages);

        // SQL update query
        String sql = "UPDATE Tour SET tour_Img = ? WHERE tour_Id = ?";

        try (PreparedStatement stmt = getConnect().prepareStatement(sql)) {
            // Set the parameters
            stmt.setString(1, updatedImageString); // Set the updated image string
            stmt.setString(2, tourId); // Set the tour ID

            // Execute the update
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Optionally rethrow the exception
        }
    }

    //DISCOUNT
    public List<Discount> getAllDiscounts() {
        List<Discount> discounts = new ArrayList<>();

        // SQL query to select all records from the Discount table
        String sql = "SELECT * FROM [Discount]";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            // Process the result set
            while (rs.next()) {
                // Fetch data from the result set
                int discountId = rs.getInt("discount_Id");
                String code = rs.getString("code");
                int quantity = rs.getInt("quantity");
                double percentDiscount = rs.getDouble("percent_Discount");
                Date startDay = rs.getDate("start_Day");
                Date endDay = rs.getDate("end_Day");
                String require = rs.getString("require");
                String tourId = rs.getString("tour_Id");
                String description = rs.getString("description");

                // Create a Discount object and add it to the list
                Discount discount = new Discount(discountId, code, quantity, percentDiscount, startDay, endDay, require, tourId, description);
                discounts.add(discount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return discounts;
    }

    //REVIEW
    public List<Review> getTop5ReviewsByLikes() {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT TOP 5 r.review_Id, r.comment, r.rating_Star, r.cus_Id, r.tour_Id, u.first_Name, u.last_Name "
                + "FROM Review r "
                + "JOIN Customer c ON c.cus_Id = r.cus_Id "
                + "JOIN [User] u ON c.user_Id = u.user_Id "
                + "ORDER BY r.rating_Star DESC";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setReview_Id(rs.getInt("review_Id"));
                    review.setComment(rs.getString("comment"));
                    review.setRating_Star(rs.getInt("rating_Star"));
                    review.setCus_Id(rs.getInt("cus_Id"));
                    review.setTour_Id(rs.getString("tour_Id"));
                    review.setFirst_Name(rs.getString("first_Name"));
                    review.setLast_Name(rs.getString("last_Name"));
                    reviews.add(review);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    //COMPANY
    public BigDecimal getBalanceByCompanyId(int companyId) {
        String sql = "SELECT balance FROM Company WHERE company_Id = ?";
        BigDecimal balance = BigDecimal.ZERO;
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, companyId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    balance = rs.getBigDecimal("balance");
                    System.out.println("Balance for Company ID " + companyId + ": " + balance);
                } else {
                    System.out.println("No company found with ID: " + companyId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return balance;
    }

    public boolean markNotificationsAsRead(int userId, List<Integer> notificationIds) throws SQLException {
        if (notificationIds == null || notificationIds.isEmpty()) {
            return false;
        }

        String sql = "UPDATE Notifications SET is_read = 1 WHERE user_Id = ? AND notification_Id IN ("
                + notificationIds.stream().map(id -> "?").collect(Collectors.joining(", ")) + ")";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);

            // Set each notification ID in the prepared statement
            for (int i = 0; i < notificationIds.size(); i++) {
                stmt.setInt(i + 2, notificationIds.get(i));
            }

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        }
    }

    public List<Notification> getNotificationsAfterId(int userId, int afterNotificationId) throws SQLException {
        List<Notification> notifications = new ArrayList<>();

        String sql = "SELECT notification_Id, message, date_sent, is_read FROM Notifications WHERE user_Id = ? AND notification_Id > ? ORDER BY date_sent DESC";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, afterNotificationId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Notification notification = new Notification();
                notification.setNotificationId(rs.getInt("notification_Id"));
                notification.setMessage(rs.getString("message"));
                notification.setDateSent(rs.getTimestamp("date_sent"));
                notification.setRead(rs.getBoolean("is_read"));
                notifications.add(notification);
            }
        }

        return notifications;
    }

    public static void main(String[] args) {
        List<Discount> tours = new hoang_UserDB().getAllDiscounts();
        for (Discount book : tours) {
            System.out.println(book.toString());
        }
    }
}
