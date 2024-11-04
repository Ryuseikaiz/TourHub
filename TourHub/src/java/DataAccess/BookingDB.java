/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DataAccess;

import static DataAccess.DatabaseInfo.DBURL;
import static DataAccess.DatabaseInfo.DRIVERNAME;
import static DataAccess.DatabaseInfo.PASSDB;
import static DataAccess.DatabaseInfo.USERDB;
import static DataAccess.TourDB.getConnect;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.BookingDetails;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.math.BigDecimal;
import model.Booking;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author NOMNOM
 */
public class BookingDB implements DatabaseInfo {

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

    public List<Booking> getUser2Booking(int customer_Id) {
        List<Booking> list = new ArrayList<>();

        String query = "SELECT b.book_Id, b.created_At, b.slot_Order, b.total_Cost, b.book_Status, "
                + "b.cus_Id, t.tour_Id, t.tour_Name, b.tour_Date, b.cancel_Date "
                + "FROM Booking b "
                + "INNER JOIN Tour t ON b.tour_Id = t.tour_Id "
                + "WHERE b.cus_Id = ? ORDER BY b.created_At ASC";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, customer_Id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getInt("book_Id"),
                        rs.getDate("created_At"),
                        rs.getInt("slot_Order"),
                        rs.getBigDecimal("total_Cost"),
                        rs.getString("book_Status"),
                        rs.getInt("cus_Id"),
                        rs.getString("tour_Id"),
                        rs.getString("tour_Name"),
                        rs.getDate("tour_Date"),
                        rs.getDate("cancel_Date")
                );
                list.add(booking);
            }
        } catch (Exception ex) {
            Logger.getLogger(BookingDB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();

        String query = "SELECT b.book_Id, b.created_At, b.slot_Order, b.total_Cost, b.book_Status, "
                + "b.cus_Id, t.tour_Id, t.tour_Name, b.tour_Date, b.cancel_Date "
                + "FROM Booking b "
                + "INNER JOIN Tour t ON b.tour_Id = t.tour_Id";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getInt("book_Id"),
                        rs.getDate("created_At"),
                        rs.getInt("slot_Order"),
                        rs.getBigDecimal("total_Cost"),
                        rs.getString("book_Status"),
                        rs.getInt("cus_Id"),
                        rs.getString("tour_Id"),
                        rs.getString("tour_Name"),
                        rs.getDate("tour_Date"),
                        rs.getDate("cancel_Date")
                );
                list.add(booking);
            }
        } catch (Exception ex) {
            Logger.getLogger(BookingDB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    //----------------------------------------------------------
    //Số lượng đặt tour: Tổng số tour đã được đặt -- có thể thêm trong một khoảng thời gian cụ thể (ngày, tháng, năm).
    public int getTotalBookings() throws SQLException {
        try (Connection con = getConnect()) {
            String sql = "SELECT COUNT(*) FROM Booking";
            try (PreparedStatement stmt = con.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
            return 0;
        } catch (Exception ex) {
            Logger.getLogger(BookingDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;

    }

    //Doanh thu: Tổng doanh thu từ các tour đã đặt.
    public BigDecimal getTotalRevenue() throws SQLException {
        try (Connection con = getConnect()) {
            String sql = "SELECT SUM(total_Cost) FROM Booking WHERE book_Status = 'Booked'";
            try (PreparedStatement stmt = con.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getBigDecimal(1) != null ? rs.getBigDecimal(1) : BigDecimal.ZERO;
                }
            }
            return BigDecimal.ZERO;
        } catch (Exception ex) {
            Logger.getLogger(BookingDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    //Tỷ lệ hủy tour: Tỷ lệ phần trăm các tour bị hủy so với tổng số tour đã đặt.
    public double getCancellationRate() throws SQLException {
        try (Connection con = getConnect()) {
            String sql = "SELECT COUNT(*) FROM Booking WHERE book_Status = 'Cancelled'";
            String sqlTotal = "SELECT COUNT(*) FROM Booking";
            int cancelledCount = 0;
            int totalCount = 0;

            try (PreparedStatement stmt = con.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    cancelledCount = rs.getInt(1);
                }
            }

            try (PreparedStatement stmtTotal = con.prepareStatement(sqlTotal); ResultSet rsTotal = stmtTotal.executeQuery()) {
                if (rsTotal.next()) {
                    totalCount = rsTotal.getInt(1);
                }
            }

            return totalCount > 0 ? (double) cancelledCount / totalCount * 100 : 0;
        } catch (Exception ex) {
            Logger.getLogger(BookingDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public Map<String, Integer> getBookingsByCompany() throws SQLException {
        try (Connection con = getConnect()) {
            String sql = "SELECT \n"
                    + "    CONCAT(u.first_Name, ' ', u.last_Name) AS Company_Name, \n"
                    + "    COUNT(b.book_Id) AS Booking_Count\n"
                    + "FROM \n"
                    + "    Booking b \n"
                    + "INNER JOIN \n"
                    + "    Tour t ON b.tour_Id = t.tour_Id \n"
                    + "INNER JOIN \n"
                    + "    Company c ON t.company_Id = c.company_Id \n"
                    + "INNER JOIN \n"
                    + "    [User] u ON c.user_Id = u.user_Id \n"
                    + "GROUP BY \n"
                    + "    u.first_Name, u.last_Name";
            Map<String, Integer> bookingsByCompany = new HashMap<>();

            try (PreparedStatement stmt = con.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    bookingsByCompany.put(rs.getString("Company_Name"), rs.getInt(2));
                }
            }
            return bookingsByCompany;
        } catch (Exception ex) {
            Logger.getLogger(BookingDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    //Thống kê theo vùng miền: Số lượng đặt tour theo từng thành phố hoặc vùng miền.
    public Map<String, Integer> getBookingsByLocation() throws SQLException {
        try (Connection con = getConnect()) {
            String sql = "SELECT location, COUNT(*) FROM Tour t INNER JOIN Booking b ON t.tour_Id = b.tour_Id GROUP BY location";
            Map<String, Integer> bookingsByLocation = new HashMap<>();

            try (PreparedStatement stmt = con.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    bookingsByLocation.put(rs.getString("location"), rs.getInt(2));
                }
            }
            return bookingsByLocation;
        } catch (Exception ex) {
            Logger.getLogger(BookingDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    //Liệt kê số lượng đặt tour theo từng tháng
    public Map<String, Integer> getMonthlyBookingsCount(int year) throws SQLException {
        try (Connection con = getConnect()) {
            String sql = "SELECT MONTH(book_Date) AS month, COUNT(*) AS booking_count "
                    + "FROM Booking "
                    + "WHERE YEAR(book_Date) = ? "
                    + "GROUP BY MONTH(book_Date)";
            Map<String, Integer> bookingsByMonth = new HashMap<>();

            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setInt(1, year); // Set giá trị năm vào câu truy vấn
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    String month = String.valueOf(rs.getInt("month"));
                    int bookingCount = rs.getInt("booking_count");
                    bookingsByMonth.put(month, bookingCount);
                }
            }
            return bookingsByMonth;
        } catch (Exception ex) {
            Logger.getLogger(BookingDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    //Liệt kê các user vừa đăng ký gần đây nhất
    public List<User> getRecentUsers() throws SQLException {
        try (Connection con = getConnect()) {
            String sql = "SELECT TOP 10 user_Id, first_Name, last_Name, email, created_At, role "
                    + "FROM [User] WHERE role = 'customer' OR role = 'company' "
                    + "ORDER BY created_At DESC "; // Giới hạn lấy 10 user gần đây nhất
            List<User> recentUsers = new ArrayList<>();

            try (PreparedStatement stmt = con.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUser_Id(rs.getInt("user_Id"));
                    user.setFirst_Name(rs.getString("first_Name"));
                    user.setLast_Name(rs.getString("last_Name"));
                    user.setEmail(rs.getString("email"));
                    user.setCreated_At(rs.getDate("created_At"));
                    user.setRole(rs.getString("role"));
                    recentUsers.add(user);
                }
            }
            return recentUsers;
        } catch (Exception ex) {
            Logger.getLogger(BookingDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
