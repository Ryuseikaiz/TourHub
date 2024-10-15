/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DataAccess;

import static DataAccess.UserDB.getConnect;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.Tour;
import model.TourOption;
import model.TourPeople;
import java.sql.Date;
import model.Booking;

/**
 *
 * @author LENOVO
 */
public class KhanhDB {

    public List<Tour> getAllTour(String sortOrder, String location, int minPrice, int maxPrice) {
        List<Tour> list = new ArrayList<>();
        String sql = "SELECT * FROM Tour WHERE 1=1";

        // Add location filter
        if (location != null && !location.equals("All")) {
            sql += " AND location = ?";
        }

        // Add price range filter
        if (minPrice > 0 || maxPrice > 0) {
            sql += " AND price BETWEEN ? AND ?";
        }

        // Sort the results
        switch (sortOrder) {
            case "price-asc":
                sql += " ORDER BY price ASC";
                break;
            case "price-desc":
                sql += " ORDER BY price DESC";
                break;
            case "rating":
                sql += " ORDER BY average_Review_Rating DESC";
                break;
            case "popularity":
            default:
                sql += " ORDER BY purchases_Time DESC";
                break;
        }

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            int index = 1;

            // Set location filter
            if (location != null && !location.equals("All")) {
                stmt.setString(index++, location);
            }

            // Set price range filter
            if (minPrice > 0 || maxPrice > 0) {
                stmt.setInt(index++, minPrice);
                stmt.setInt(index++, maxPrice);
            }

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

    public Tour getTourById(String tourId) {
        Tour tour = null;
        String sql = "SELECT * FROM Tour WHERE tour_Id = ?"; // Corrected column name

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, tourId); // Set the tourId parameter

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // Split the image URL string by ";" to create a list of URLs
                String imageUrlStr = rs.getString("tour_Img");
                List<String> imageUrlList = Arrays.asList(imageUrlStr.split(";"));

                // Create a new Tour object with the extracted data
                tour = new Tour(
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tour; // Return the Tour object or null if not found
    }

    public List<TourOption> getAllTourOptionsByTourId(String tourId) {
        List<TourOption> options = new ArrayList<>();
        String sql = "SELECT tourOpt.option_Id, tourOpt.tour_Id, tourOpt.option_Name, tourOpt.option_Price, tourOpt.option_Description, "
                + "ts.day_Of_Week, ts.available_Slots "
                + "FROM TourOption tourOpt "
                + "LEFT JOIN TourSchedule ts ON tourOpt.option_Id = ts.option_Id "
                + "WHERE tourOpt.tour_Id = ?"; // Use the correct field names

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, tourId); // Set the tourId as a parameter (since it's CHAR(8), treat as String)

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                // Create a new TourOption object using the result set
                TourOption option = new TourOption(
                        rs.getInt("option_Id"), // optionId from TourOption
                        rs.getString("tour_Id"), // tourId from TourOption
                        rs.getString("option_Name"), // optionName from TourOption
                        rs.getBigDecimal("option_Price"), // price from TourOption
                        rs.getString("option_Description"), // description from TourOption
                        rs.getString("day_Of_Week"), // dayOfWeek from TourSchedule
                        rs.getInt("available_Slots") // availableSlots from TourSchedule
                );

                options.add(option); // Add the option to the list
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return options; // Return the list of TourOptions
    }

    public TourOption getTourOptionById(int optionId) {
        TourOption option = null;
        String sql = "SELECT tourOpt.option_Id, tourOpt.tour_Id, tourOpt.option_Name, tourOpt.option_Price, tourOpt.option_Description, "
                + "ts.day_Of_Week, ts.available_Slots "
                + "FROM TourOption tourOpt "
                + "LEFT JOIN TourSchedule ts ON tourOpt.option_Id = ts.option_Id "
                + "WHERE tourOpt.option_Id = ?";  // Use the correct field names

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, optionId);  // Set the optionId as a parameter

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // Create a new TourOption object using the result set
                option = new TourOption(
                        rs.getInt("option_Id"), // optionId from TourOption
                        rs.getString("tour_Id"), // tourId from TourOption
                        rs.getString("option_Name"), // optionName from TourOption
                        rs.getBigDecimal("option_Price"), // price from TourOption
                        rs.getString("option_Description"), // description from TourOption
                        rs.getString("day_Of_Week"), // dayOfWeek from TourSchedule
                        rs.getInt("available_Slots") // availableSlots from TourSchedule
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return option;  // Return the TourOption object
    }

    public List<TourPeople> getTourPeopleByOptionId(int optionId) {
        List<TourPeople> peopleList = new ArrayList<>();
        String sql = "SELECT people_Id, option_Id, people_Type, min_Count, max_Count, price, description "
                + "FROM TourOptionPeople WHERE option_Id = ?";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, optionId);  // Set the optionId as a parameter

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                // Create a new TourPeople object for each row in the result set
                TourPeople people = new TourPeople(
                        rs.getInt("people_Id"), // peopleId from TourOptionPeople
                        rs.getInt("option_Id"), // optionId from TourOptionPeople
                        rs.getString("people_Type"), // peopleType from TourOptionPeople
                        rs.getInt("min_Count"), // minCount from TourOptionPeople
                        rs.getInt("max_Count"), // maxCount from TourOptionPeople
                        rs.getBigDecimal("price"), // price from TourOptionPeople
                        rs.getString("description") // description from TourOptionPeople
                );
                peopleList.add(people);  // Add the TourPeople object to the list
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return peopleList;  // Return the list of TourPeople objects
    }

    public int getLatestBookingId() throws SQLException {
        String getId = "SELECT TOP 1 book_Id FROM [Booking] ORDER BY book_Id DESC";

        try (Connection conn = UserDB.getConnect(); 
             PreparedStatement ps = conn.prepareStatement(getId);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) { // Kiểm tra nếu có kết quả trả về
                return rs.getInt(1); // Trả về book_Id
            }
        }

        // Trả về -1 nếu không có kết quả nào
        return -1;
    }

    public void importBooking(String tourId, String selectedDate, String totalCost, String bookingDetail, String bookStatus,
            String optionId, int scheduleId, int cusId, int slotOrder,
            String tourDate, String cancelDate, String bookDate, BigDecimal refundAmount) throws SQLException {

        // Ensure totalCost is not null or empty
        if (totalCost == null || totalCost.isEmpty()) {
            throw new IllegalArgumentException("Total cost cannot be null or empty");
        }

        BigDecimal totalCostDecimal;
        try {
            totalCostDecimal = new BigDecimal(totalCost);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid format for total cost: " + totalCost);
        }

        // Convert date strings to java.sql.Date
        Date tourDateSql = convertStringToDate(tourDate);
        Date cancelDateSql = convertStringToDate(cancelDate);
        Date bookDateSql = convertStringToDate(bookDate);

        String sql = "INSERT INTO Booking (tour_Id, tour_Date, total_Cost, book_Status, option_Id, schedule_Id, "
                + "cus_Id, slot_Order, cancel_Date, book_Date, refund_Amount, booking_Detail) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = UserDB.getConnect(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, tourId);
            ps.setDate(2, tourDateSql);
            ps.setBigDecimal(3, totalCostDecimal);
            ps.setString(4, bookStatus);
            ps.setString(5, optionId);
            ps.setInt(6, scheduleId);
            ps.setInt(7, cusId);
            ps.setInt(8, slotOrder);
            ps.setDate(9, cancelDateSql);
            ps.setDate(10, bookDateSql);
            ps.setBigDecimal(11, refundAmount);
            ps.setString(12, bookingDetail);

            // Execute the insert
            ps.executeUpdate();
        }
    }

    // Helper method to convert string to java.sql.Date
    private Date convertStringToDate(String dateString) {
        if (dateString == null || dateString.isEmpty()) {
            return null; // Return null if the date string is empty
        }

        // Adjust the date format based on the expected input format
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy"); // Change this if your input format differs
        try {
            java.util.Date parsedDate = sdf.parse(dateString);
            return new Date(parsedDate.getTime()); // Create a java.sql.Date from java.util.Date
        } catch (ParseException e) {
            throw new IllegalArgumentException("Invalid date format: " + dateString, e);
        }
    }

    public Booking getBookingById(int bookId) throws SQLException {
    String sql = "SELECT b.book_Id, b.created_At, b.slot_Order, b.total_Cost, b.book_Status, " +
                 "b.cus_Id, b.tour_Id, b.tour_Date, b.cancel_Date, b.booking_Detail, " +
                 "toOption.option_Name, t.tour_Name, t.tour_Img " + // Include tour_Name in the select
                 "FROM Booking b " +
                 "JOIN TourOption toOption ON b.option_Id = toOption.option_Id " +
                 "JOIN Tour t ON b.tour_Id = t.tour_Id " +
                 "WHERE b.book_Id = ?";

    Booking booking = null;

    try (Connection conn = UserDB.getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, bookId);  // Set the booking ID parameter

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                // Create a new Booking object using the constructor
                String tourImgString = rs.getString("tour_Img");
                List<String> tourImgList = (tourImgString != null) ? Arrays.asList(tourImgString.split(",")) : new ArrayList<>();
                
                booking = new Booking(
                    rs.getInt("book_Id"),
                    rs.getDate("created_At"),
                    rs.getInt("slot_Order"),
                    rs.getBigDecimal("total_Cost"),
                    rs.getString("book_Status"),
                    rs.getInt("cus_Id"),
                    rs.getString("tour_Id"),
                    rs.getString("tour_Name"), // Now retrieving tour_Name
                    rs.getDate("tour_Date"),
                    rs.getDate("cancel_Date"),
                    rs.getString("booking_Detail"),
                    tourImgList,
                    rs.getString("option_Name")
                );
            }
        }
    }

    return booking;
}


    public Integer getCusIdFromUserId(int userId) throws SQLException {
        String sql = "SELECT cus_Id FROM Customer WHERE user_Id = ?";

        try (Connection conn = UserDB.getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("cus_Id"); // Return the cus_Id if found
            }
        }
        return null; // Return null if not found
    }

    public String getTourIdByOptionId(String optionId) throws SQLException {
        String sql = "SELECT tour_Id FROM TourOption WHERE option_Id = ?"; // SQL query to fetch the tour_Id

        try (Connection conn = UserDB.getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            // Convert the string optionId to an integer if necessary
            ps.setInt(1, Integer.parseInt(optionId)); // Set the optionId as an integer in the query

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("tour_Id"); // Return the retrieved tour_Id
                }
            }
        } catch (NumberFormatException e) {
            System.err.println("Error: optionId must be a valid integer string.");
        } catch (SQLException e) {
            e.printStackTrace(); // Handle SQL exceptions
        }
        return null; // Return null if no tour_Id is found or if the input is invalid
    }

    public static void main(String[] args) {
        KhanhDB userDB = new KhanhDB();

// Initial tourId (you can remove this if you only want to fetch the tourId dynamically)
        String tourId = "T0000001";  // Example of a default tourId (use a real one from your database)

// Specify the booking details
        String selectedDate = "10/10/2024"; // Example of a selected date
        String totalCost = "500000"; // Example total cost
        String bookingDetail = "Nguoi lon x2"; // Example booking detail
        String bookStatus = "pending"; // Example booking status
        String optionId = "1"; // Example option ID
        int scheduleId = 1; // Example schedule ID
        int cusId = 1; // Example customer ID
        int slotOrder = 1; // Example slot order
        String tourDate = "10/10/2024"; // Example tour date
        String cancelDate = ""; // Example cancel date (empty since booking is pending)
        String bookDate = "10/10/2024"; // Example booking date
        BigDecimal refundAmount = BigDecimal.ZERO; // Example refund amount (zero since no cancellation yet)

        try {
            // Fetch the tourId by optionId (as a string)
            String fetchedTourId = userDB.getTourIdByOptionId(optionId);  // Renamed to fetchedTourId to avoid conflict
            if (fetchedTourId != null) {
                tourId = fetchedTourId; // Update the tourId with the fetched one
                System.out.println("Tour ID for Option ID " + optionId + ": " + tourId);
            } else {
                System.out.println("No Tour found for Option ID " + optionId);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving tour ID: " + e.getMessage());
        }

        // Now, you can use tourId in your booking process or elsewhere.
        try {
            // Import the booking using the updated tourId
            userDB.importBooking(tourId, selectedDate, totalCost, bookingDetail, bookStatus, optionId, scheduleId, cusId, slotOrder, tourDate, cancelDate, bookDate, refundAmount);
            System.out.println("Booking successfully imported.");
        } catch (SQLException e) {
            System.err.println("Error importing booking: " + e.getMessage());
        }

        // Fetch the tour using the getTourById method
        Tour tour = userDB.getTourById(tourId);

        if (tour != null) {
            // Print the tour details
            System.out.println(tour.getTour_Name());

            // Fetch and print tour options for the tour
            List<TourOption> options = userDB.getAllTourOptionsByTourId(tourId);
            for (TourOption option : options) {
                System.out.println(option.getOption_Name());
            }
        } else {
            System.out.println("Tour not found for ID: " + tourId);
        }
    }
}