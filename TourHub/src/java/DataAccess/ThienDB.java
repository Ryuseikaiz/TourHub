/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DataAccess;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Message;
import model.Notification;
import model.ReportError;
import model.Tour;
import model.User;
import model.Wishlist;
import java.util.Date;
import model.Booking;

/**
 *
 * @author NOMNOM
 */
public class ThienDB implements DatabaseInfo {

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

    public User getCustomer(int userId) {
        String query = "SELECT u.user_Id, u.password, u.first_Name, u.last_Name, u.phone, u.email, u.address, u.created_At, u.user_Status, u.role, u.avatar, c.cus_Birth "
                + "FROM [User] u "
                + "JOIN Customer c ON u.user_Id = c.user_Id "
                + "WHERE u.user_Id = ?";

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUser_Id(rs.getInt("user_Id"));
                    user.setPassword(rs.getString("password"));
                    user.setFirst_Name(rs.getString("first_Name"));
                    user.setLast_Name(rs.getString("last_Name"));
                    user.setPhone(rs.getString("phone"));
                    user.setEmail(rs.getString("email"));
                    user.setAddress(rs.getString("address"));
                    user.setCreated_At(rs.getDate("created_At"));
                    user.setUser_Status(rs.getString("user_Status"));
                    user.setRole(rs.getString("role"));
                    user.setAvatar(rs.getString("avatar"));
                    user.setCus_Birth(rs.getDate("cus_Birth"));  // Ngày sinh của Customer

                    return user;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching user: " + e);
        }
        return null;
    }

    public boolean updateCustomer(User user) {
        boolean result = false;

        String updateUserSQL = "UPDATE [User] SET first_Name = ?, last_Name = ?, email = ?, phone = ?, address = ?, avatar = ? WHERE user_Id = ?";
        String updateCustomerSQL = "UPDATE Customer SET cus_Birth = ? WHERE user_Id = ?";

        try (Connection conn = getConnect()) {
            conn.setAutoCommit(false);

            try (PreparedStatement stmtUser = conn.prepareStatement(updateUserSQL)) {
                stmtUser.setString(1, user.getFirst_Name());
                stmtUser.setString(2, user.getLast_Name());
                stmtUser.setString(3, user.getEmail());
                stmtUser.setString(4, user.getPhone());
                stmtUser.setString(5, user.getAddress());
                stmtUser.setString(6, user.getAvatar());
                stmtUser.setInt(7, user.getUser_Id());
                stmtUser.executeUpdate();
            }

            try (PreparedStatement stmtCustomer = conn.prepareStatement(updateCustomerSQL)) {
                if (user.getCus_Birth() != null) {
                    stmtCustomer.setDate(1, new java.sql.Date(user.getCus_Birth().getTime())); // Correct conversion
                } else {
                    stmtCustomer.setNull(1, java.sql.Types.DATE);
                }
                stmtCustomer.setInt(2, user.getUser_Id());
                stmtCustomer.executeUpdate();
            }

            conn.commit();
            result = true;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public User getProvider(int userId) {
        String query = "SELECT u.user_Id, u.password, u.first_Name, u.last_Name, u.phone, u.email, u.address, u.created_At, u.user_Status, u.role, u.avatar, "
                + "c.tax_Code, c.balance, c.bank_Information "
                + "FROM [User] u "
                + "JOIN Company c ON u.user_Id = c.user_Id "
                + "WHERE u.user_Id = ?";

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, userId);  // Set giá trị cho tham số user_Id trong query

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUser_Id(rs.getInt("user_Id"));
                    user.setPassword(rs.getString("password"));
                    user.setFirst_Name(rs.getString("first_Name"));
                    user.setLast_Name(rs.getString("last_Name"));
                    user.setPhone(rs.getString("phone"));
                    user.setEmail(rs.getString("email"));
                    user.setAddress(rs.getString("address"));
                    user.setCreated_At(rs.getDate("created_At"));
                    user.setUser_Status(rs.getString("user_Status"));
                    user.setRole(rs.getString("role"));
                    user.setAvatar(rs.getString("avatar"));

                    // Thêm thông tin từ bảng Company
                    user.setTax_Code(rs.getString("tax_Code"));
                    user.setBalance(rs.getBigDecimal("balance"));
                    user.setBank_Information(rs.getString("bank_Information"));

                    return user;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching user with company info: " + e);
        }
        return null;
    }

    public boolean updateProvider(User user) {
        boolean result = false;

        String updateUserSQL = "UPDATE [User] SET first_Name = ?, last_Name = ?, email = ?, phone = ?, address = ?, avatar = ? WHERE user_Id = ?";
        String updateCompanySQL = "UPDATE Company SET tax_Code = ?, balance = ?, bank_Information = ? WHERE user_Id = ?";

        try (Connection conn = getConnect()) {
            conn.setAutoCommit(false);

            try (PreparedStatement stmtUser = conn.prepareStatement(updateUserSQL)) {
                stmtUser.setString(1, user.getFirst_Name());
                stmtUser.setString(2, user.getLast_Name());
                stmtUser.setString(3, user.getEmail());
                stmtUser.setString(4, user.getPhone());
                stmtUser.setString(5, user.getAddress());
                stmtUser.setString(6, user.getAvatar());
                stmtUser.setInt(7, user.getUser_Id());
                stmtUser.executeUpdate();
            }

            try (PreparedStatement stmtCompany = conn.prepareStatement(updateCompanySQL)) {
                // Gán giá trị cho các tham số
                stmtCompany.setString(1, user.getTax_Code());
                stmtCompany.setBigDecimal(2, user.getBalance()); // Đảm bảo rằng bạn có getter cho balance
                stmtCompany.setString(3, user.getBank_Information());
                stmtCompany.setInt(4, user.getUser_Id());
                stmtCompany.executeUpdate();
            }

            conn.commit();
            result = true;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public List<Booking> getBookingDetails() {
        List<Booking> bookingDetailsList = new ArrayList<>();
        String sql = "SELECT B.book_Id, CONCAT(U.first_Name, ' ', U.last_Name) AS CustomerName, "
                + "T.tour_Name, B.book_Date, B.book_Status, B.total_Cost, B.created_At, "
                + "B.cancel_Date, B.slot_Order, B.refund_Amount, B.booking_Detail "
                + "FROM Booking B "
                + "JOIN Customer C ON B.cus_Id = C.cus_Id "
                + "JOIN [User] U ON C.user_Id = U.user_Id "
                + "JOIN Tour T ON B.tour_Id = T.tour_Id ORDER BY B.book_Date DESC";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                int bookingId = rs.getInt("book_Id");
                String customerName = rs.getString("CustomerName");
                String tourName = rs.getString("tour_Name");
                Date bookingDate = rs.getDate("created_At");
                String bookingStatus = rs.getString("book_Status"); // New field
                BigDecimal totalCost = rs.getBigDecimal("total_Cost"); // New field
                Date tourDate = rs.getDate("tour_Date"); // New field
                Date cancelDate = rs.getDate("cancel_Date"); // New field
                int slotOrder = rs.getInt("slot_Order"); // New field
                BigDecimal refundAmount = rs.getBigDecimal("refund_Amount"); // New field
                String bookingDetail = rs.getString("booking_Detail"); // New field

                bookingDetailsList.add(new Booking(bookingId, bookingDate, slotOrder, totalCost, bookingStatus,
                        tourName, tourDate, cancelDate, bookingDetail, customerName, refundAmount));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching booking details: " + e.getMessage());
        }
        return bookingDetailsList;
    }

    public List<Booking> getUserBookingDetails(int userId) {
        List<Booking> bookingDetailsList = new ArrayList<>();
        String sql = "SELECT B.book_Id, CONCAT(U.first_Name, ' ', U.last_Name) AS CustomerName, "
                + "T.tour_Name, B.book_Date, B.book_Status, B.total_Cost, B.tour_Date, "
                + "B.cancel_Date, B.slot_Order, B.refund_Amount, B.booking_Detail, B.created_At "
                + "FROM Booking B "
                + "JOIN Customer C ON B.cus_Id = C.cus_Id "
                + "JOIN [User] U ON C.user_Id = U.user_Id "
                + "JOIN Tour T ON B.tour_Id = T.tour_Id "
                + "WHERE U.user_Id = ? "
                + "ORDER BY B.book_Date DESC"; // Moved ORDER BY after WHERE

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Set parameters
            pstmt.setInt(1, userId); // Assuming userId is of type int

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int bookingId = rs.getInt("book_Id");
                    Date created_At = rs.getDate("created_At");
                    String customerName = rs.getString("CustomerName");
                    String tourName = rs.getString("tour_Name");
                    String status = rs.getString("book_Status"); // Changed variable name to avoid confusion
                    BigDecimal totalCost = rs.getBigDecimal("total_Cost");
                    Date tourDate = rs.getDate("tour_Date");
                    Date cancelDate = rs.getDate("cancel_Date");
                    int slotOrder = rs.getInt("slot_Order");
                    BigDecimal refundAmount = rs.getBigDecimal("refund_Amount");
                    String bookingDetail = rs.getString("booking_Detail");

                    // Correct the constructor call (removed duplicate bookingStatus)
                    bookingDetailsList.add(new Booking(bookingId, created_At, slotOrder, totalCost, status,
                            tourName, tourDate, cancelDate, bookingDetail, customerName, refundAmount));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching booking details: " + e.getMessage());
        }
        return bookingDetailsList;
    }

    public List<Booking> getUserStatusBookingDetails(int userId, String Bookstatus) {
        List<Booking> bookingDetailsList = new ArrayList<>();
        String sql = "SELECT B.book_Id, CONCAT(U.first_Name, ' ', U.last_Name) AS CustomerName, "
                + "T.tour_Name, B.book_Date, B.book_Status, B.total_Cost, B.tour_Date, "
                + "B.cancel_Date, B.slot_Order, B.refund_Amount, B.booking_Detail, B.created_At "
                + "FROM Booking B "
                + "JOIN Customer C ON B.cus_Id = C.cus_Id "
                + "JOIN [User] U ON C.user_Id = U.user_Id "
                + "JOIN Tour T ON B.tour_Id = T.tour_Id "
                + "WHERE U.user_Id = ? AND B.book_Status = ? "
                + "ORDER BY B.book_Date DESC"; // Moved ORDER BY after WHERE

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Set parameters
            pstmt.setInt(1, userId); // Assuming userId is of type int
            pstmt.setString(2, Bookstatus);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int bookingId = rs.getInt("book_Id");
                    Date created_At = rs.getDate("created_At");
                    String customerName = rs.getString("CustomerName");
                    String tourName = rs.getString("tour_Name");
                    String status = rs.getString("book_Status"); // Changed variable name to avoid confusion
                    BigDecimal totalCost = rs.getBigDecimal("total_Cost");
                    Date tourDate = rs.getDate("tour_Date");
                    Date cancelDate = rs.getDate("cancel_Date");
                    int slotOrder = rs.getInt("slot_Order");
                    BigDecimal refundAmount = rs.getBigDecimal("refund_Amount");
                    String bookingDetail = rs.getString("booking_Detail");

                    // Correct the constructor call (removed duplicate bookingStatus)
                    bookingDetailsList.add(new Booking(bookingId, created_At, slotOrder, totalCost, status,
                            tourName, tourDate, cancelDate, bookingDetail, customerName, refundAmount));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching booking details: " + e.getMessage());
        }
        return bookingDetailsList;
    }

    // Method to get Tour ID by Tour Name
    public String getTourIdByName(String tourName) {
        String tourId = null;
        String query = "SELECT tour_Id FROM Tour WHERE tour_Name = ?";

        try (Connection conn = getConnect(); // Make sure you have a method to get the connection
                 PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, tourName);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                tourId = rs.getString("tour_Id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tourId;
    }

    public boolean updateBookingStatus(int cus_Id, String book_Id, String status) {
        String updateQuery = "UPDATE Booking SET book_Status = ? WHERE book_Status = 'Pending' AND cus_Id = ? AND book_Id = ?";

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(updateQuery)) {

            // Set the cus_Id and tour_Id in the query
            ps.setString(1, status);
            ps.setInt(2, cus_Id);
            ps.setString(3, book_Id);

            // Execute the update query
            int rowsUpdated = ps.executeUpdate();

            // Print how many rows were updated
            System.out.println(rowsUpdated + " bookings were updated from 'Pending' to 'Cancelled' for customer ID: " + cus_Id + " and tour ID: " + book_Id);
            return true;
        } catch (SQLException e) {
            System.out.println("SQL error occurred: " + e.getMessage());
            return false;
        }
    }

    public void banAccount(int userId) throws Exception {
        String sql = "UPDATE [User] SET user_Status = 'Banned' WHERE user_Id = ?";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();
        }
    }

    public void unbanAccount(int userId) throws Exception {
        String sql = "UPDATE [User] SET user_Status = 'Verified' WHERE user_Id = ?";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();
        }
    }

    public List<Tour> getStatusTours(String status) {
        List<Tour> tourList = new ArrayList<>();
        String sql = "SELECT * FROM Tour WHERE tour_Status = ?";

        // Get the connection from your getConnect() method
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sql)) {

            if (con == null) {
                System.out.println("Unable to establish a database connection.");
                return tourList; // Return an empty list if connection failed
            }

            // Set the status parameter for the prepared statement
            stmt.setString(1, status);

            // Execute the query
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Create a Tour object from the result set
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
                    tour.setCompany_Id(rs.getInt("company_Id"));
                    // Add the Tour object to the list
                    tourList.add(tour);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error while fetching tours: " + e.getMessage());
        }

        return tourList;
    }

    public void cancelTour(String tourId) throws SQLException {
        String sql = "UPDATE Tour SET tour_Status = 'Cancelled' WHERE tour_Id = ?";
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, tourId);
            stmt.executeUpdate();
        }
    }

    public void approveTour(String tourId) throws Exception {
        String sql = "UPDATE Tour SET tour_Status = 'Active' WHERE tour_Id = ?";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, tourId);
            pstmt.executeUpdate();
        }
    }

    public void banTour(String tourId) throws Exception {
        String sql = "UPDATE Tour SET tour_Status = 'Banned' WHERE tour_Id = ?";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, tourId);
            pstmt.executeUpdate();
        }
    }

    public void deleteReport(int reportId) throws SQLException {
        String sql = "DELETE FROM ReportError WHERE report_Id = ?";
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reportId);
            stmt.executeUpdate();
        }
    }

    public User getUserById(int userId) throws Exception {
        User user = null;
        String sql = "SELECT * FROM [User] WHERE user_Id = ?";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);

                String password = rs.getString(2);
                String user_Status = rs.getString(3);
                String role = rs.getString(4);
                String first_Name = rs.getString(5);
                String last_Name = rs.getString(6);
                String email = rs.getString(7);
                String phone = rs.getString(8);
                String address = rs.getString(9);
                java.util.Date created_At = rs.getDate(10);
                String avatar = rs.getString(11); // Get avatar

                user = new User(id, password, first_Name, last_Name, phone, email, address, created_At, user_Status, role, avatar);
            }
        }
        return user;
    }

    public ArrayList<ReportError> getAllReports() throws Exception {
        ArrayList<ReportError> reports = new ArrayList<>();
        String sql = "SELECT * FROM ReportError";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                reports.add(new ReportError(rs.getInt("report_Id"), rs.getDate("report_Date"), rs.getString("report_Details"), rs.getString("report_Type"), rs.getInt("user_Id")));
            }
        }
        return reports;
    }

    public void cancelBooking(int bookingId) throws Exception {
        String sql = "UPDATE Booking SET book_Status = 'Cancelled', cancel_Date = GETDATE() WHERE book_Id = ? AND book_Status = 'Pending' ";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, bookingId);
            pstmt.executeUpdate();
        }
    }

    // Phương thức để lấy danh sách người dùng đang nhắn tin với người dùng hiện tại
    public static List<User> getActiveChatUsers(int userId) {
        List<User> activeUsers = new ArrayList<>();
        String query = "SELECT DISTINCT u.user_Id, u.first_Name, u.last_Name "
                + "FROM [User] u "
                + "JOIN Messages m ON (m.sender_id = u.user_Id OR m.receiver_id = u.user_Id) "
                + "WHERE (m.sender_id = ? OR m.receiver_id = ?) AND u.user_Id != ?";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, userId);
            stmt.setInt(3, userId);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("user_id");
                String first_Name = rs.getString("first_Name");
                String last_Name = rs.getString("last_Name");

                // Tạo đối tượng User và thêm vào danh sách
                User activeUser = new User(id, first_Name, last_Name);
                activeUsers.add(activeUser);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return activeUsers;
    }

    // Phương thức để lấy kênh chat với admin
    public static List<User> getAdminChat() {
        List<User> activeUsers = new ArrayList<>();
        String query = "SELECT user_Id, first_Name, last_Name FROM [User] WHERE role = 'Admin'";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("user_id");
                String first_Name = rs.getString("first_Name");
                String last_Name = rs.getString("last_Name");

                // Tạo đối tượng User và thêm vào danh sách
                User activeUser = new User(id, first_Name, last_Name);
                activeUsers.add(activeUser);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return activeUsers;
    }

    // Method to insert a message into the database
    public boolean insertMessage(Message message) {
        boolean isInserted = false;
        String sql = "INSERT INTO Messages (sender_id, receiver_id, message_text, message_time) VALUES (?, ?, ?, GETDATE())";

        try (Connection connection = getConnect(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, message.getSenderId());
            statement.setInt(2, message.getReceiverId()); // Include receiverId
            statement.setString(3, message.getMessageText());
            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                isInserted = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isInserted;
    }

    // Phương thức để lấy các tin nhắn giữa hai người dùng
    public static List<Message> getChatMessages(int userId1, int userId2) {
        List<Message> messages = new ArrayList<>();
        String query = "SELECT m.message_id, m.sender_id, m.receiver_id, m.message_text, m.message_time "
                + "FROM Messages m "
                + "WHERE (m.sender_id = ? AND m.receiver_id = ?) OR (m.sender_id = ? AND m.receiver_id = ?) "
                + "ORDER BY m.message_time ASC";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId1);
            stmt.setInt(2, userId2);
            stmt.setInt(3, userId2);
            stmt.setInt(4, userId1);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int messageId = rs.getInt("message_id");
                int senderId = rs.getInt("sender_id");
                int receiverId = rs.getInt("receiver_id");
                String messageText = rs.getString("message_text");
                Timestamp messageTime = rs.getTimestamp("message_time");

                // Tạo đối tượng Message và thêm vào danh sách
                Message message = new Message(messageId, senderId, receiverId, messageText, messageTime);
                messages.add(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return messages;
    }

    public static boolean updateUserAvatar(int userId, String avatarPath) {
        String sql = "UPDATE [User] SET avatar = ? WHERE user_Id = ?";
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, avatarPath);
            stmt.setInt(2, userId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.err.println("Error updating avatar: " + e.getMessage());
            return false;
        }
    }

    public int getCusIdFromUserId(int user_Id) {
        int cus_Id = -1;
        String query = "SELECT cus_Id FROM Customer WHERE user_Id = ?";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, user_Id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                cus_Id = rs.getInt("cus_Id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cus_Id;
    }

    // Function to fetch wishlist items from the database
    public List<Wishlist> getWishlistFromDB(int cus_Id) {
        List<Wishlist> wishlistItems = new ArrayList<>();
        String sql = "SELECT w.wish_Id, w.cus_Id, w.tour_Id, t.tour_Name FROM Wishlist w "
                + "INNER JOIN Tour t ON w.tour_Id = t.tour_Id WHERE w.cus_Id = ?"; // Fixed table alias

        try (Connection con = getConnect(); // Assuming you have this utility
                 PreparedStatement stmt = con.prepareStatement(sql)) {

            // Set the parameter before executing the query
            stmt.setInt(1, cus_Id);

            // Now execute the query
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Wishlist wishlist = new Wishlist();
                    wishlist.setWish_Id(rs.getInt("wish_Id"));
                    wishlist.setCus_Id(rs.getInt("cus_Id"));
                    wishlist.setTour_Id(rs.getString("tour_Id"));
                    wishlist.setTour_Name(rs.getString("tour_Name"));

                    wishlistItems.add(wishlist);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return wishlistItems;
    }

    public Wishlist getWishlistItem(int cus_Id, String tour_Id) {
        Wishlist wishlist = new Wishlist();
        String query = "SELECT * FROM Wishlist WHERE cus_Id= ? AND tour_Id = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, cus_Id);
            ps.setString(12, tour_Id);
            try (ResultSet rs = ps.executeQuery()) {
                wishlist.setWish_Id(rs.getInt("wish_Id"));
                wishlist.setCus_Id(rs.getInt("cus_Id"));
                wishlist.setTour_Id(rs.getString("tour_Id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return wishlist;
    }

    public boolean deleteWishlistItem(int wishId) {
        String query = "DELETE FROM Wishlist WHERE wish_Id = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, wishId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0; // return true if deletion was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // return false in case of any error
        }
    }

    public List<Wishlist> getWishlistItemsForUser(int userId) {
        List<Wishlist> wishlistItems = new ArrayList<>();
        String query = "SELECT w.cus_Id, w.wish_Id, w.tour_Id, t.tour_Name FROM Wishlist w "
                + "               JOIN Tour t ON w.tour_Id = t.tour_Id "
                + "			   JOIN Customer c ON w.cus_Id = c.cus_Id"
                + "                WHERE c.user_Id = ?"; // Adjust the query based on your actual database schema

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int wishId = rs.getInt("wish_Id");
                int cus_Id = rs.getInt("cus_Id");
                String tourId = rs.getString("tour_Id");
                String tourName = rs.getString("tour_Name");

                Wishlist item = new Wishlist(wishId, cus_Id, tourId, tourName);
                wishlistItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception or handle it accordingly
        }

        return wishlistItems;
    }

    public boolean checkIfWishlistItemExists(int cusId, String tourId) {
        String sql = "SELECT COUNT(*) FROM Wishlist WHERE cus_Id = ? AND tour_Id = ?";
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, cusId);
            stmt.setString(2, tourId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Return true if count > 0, indicating it exists
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return false; // Return false if not found or an error occurred
    }

    public static boolean addToWishlist(int userId, String tourId) {
        System.out.println("day la addToWishlist");
        boolean added = false;

        // Using try-with-resources for automatic resource management
        try (Connection conn = getConnect(); // Get a connection to your database
                 PreparedStatement pstmt = conn.prepareStatement("INSERT INTO Wishlist (cus_Id, tour_Id) VALUES (?, ?)")) {

            pstmt.setInt(1, userId);
            pstmt.setString(2, tourId);
            int rowsAffected = pstmt.executeUpdate();

            added = (rowsAffected > 0); // Successfully added to wishlist if rowsAffected > 0

        } catch (SQLException e) {
            System.out.println("Error adding to wishlist: " + e.getMessage()); // Improved error handling
        }

        return added;
    }

    public List<Notification> getNotificationsByUserId(int userId) throws SQLException {
        List<Notification> notifications = new ArrayList<>();

        String sql = "SELECT notification_Id, message, date_sent, is_read FROM Notifications WHERE user_Id = ?";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
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

// Method to add a new notification and return its ID
    public int addNotification(int userId, String message) {
        String sql = "INSERT INTO Notifications (user_Id, message, date_sent, is_read) VALUES (?, ?, GETDATE(), 0)";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, userId);
            stmt.setString(2, message);

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1); // Return the newly created notification ID
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if failed
    }

    public List<Notification> getUnreadNotifications(int userId) throws SQLException {
        List<Notification> notifications = new ArrayList<>();

        String sql = "SELECT notification_Id, message, date_sent, is_read FROM Notifications WHERE user_Id = ? AND is_read = 0";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
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

    public static Integer getAdminUserId() {
        String sql = "SELECT TOP 1 user_Id FROM [User] WHERE role = 'Admin'";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("user_Id"); // Lấy user_Id đầu tiên với vai trò Admin
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving admin user ID: " + e.getMessage());
        }

        return null; // Trả về null nếu không tìm thấy
    }

    public void AdminPreMessage(int receiverId) {
        int senderId = getAdminUserId();

        String sql = "INSERT INTO Messages (sender_id, receiver_id, message_text, message_time) VALUES (?, ?, 'Hello! What is your problem ?', GETDATE())";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, senderId);
            pstmt.setInt(2, receiverId);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Message inserted successfully.");
            } else {
                System.out.println("Message insertion failed.");
            }

        } catch (SQLException e) {
            System.out.println("Error inserting message: " + e.getMessage());
        }
    }
}
