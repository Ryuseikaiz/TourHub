/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DataAccess;

import static DataAccess.DatabaseInfo.DBURL;
import static DataAccess.DatabaseInfo.DRIVERNAME;
import static DataAccess.DatabaseInfo.PASSDB;
import static DataAccess.DatabaseInfo.USERDB;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Discount;

/**
 *
 * @author TRONG DUC
 */
public class DiscountDB implements DatabaseInfo {

    public static java.sql.Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver" + e);
        }
        try {
            java.sql.Connection con = DriverManager.getConnection(DBURL, USERDB, PASSDB);
            return con;
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    // Get all discounts
    public List<Discount> getDiscountsByCompanyId(int companyId) {
        List<Discount> discounts = new ArrayList<>();
        String sql = "SELECT d.*, t.tour_Name FROM [Discount] d "
                + "JOIN [Tour] t ON d.tour_Id = t.tour_Id "
                + "WHERE t.company_Id = ?";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, companyId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int discountId = rs.getInt("discount_Id");
                    String code = rs.getString("code");
                    int quantity = rs.getInt("quantity");
                    double percentDiscount = rs.getDouble("percent_Discount");
                    Date startDay = rs.getDate("start_Day");
                    Date endDay = rs.getDate("end_Day");
                    String require = rs.getString("require");
                    String tourId = rs.getString("tour_Id");
                    String tourName = rs.getString("tour_Name"); // Fetch tour_name
                    String description = rs.getString("description");

                    Discount discount = new Discount(discountId, code, quantity, percentDiscount, startDay, endDay, require, tourId, description);
                    discount.setTour_name(tourName); // Set the tour_name in the Discount object
                    discounts.add(discount);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return discounts;
    }

    public Discount getDiscountById(int discountId) {
        String sql = "SELECT * FROM [Discount] WHERE discount_Id = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, discountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Discount(
                        rs.getInt("discount_Id"),
                        rs.getString("code"),
                        rs.getInt("quantity"),
                        rs.getDouble("percent_Discount"),
                        rs.getDate("start_Day"),
                        rs.getDate("end_Day"),
                        rs.getString("require"),
                        rs.getString("tour_Id"),
                        rs.getString("description")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Insert a new discount
    public boolean insertDiscount(Discount discount) {
        if (isDiscountCodeExists(discount.getCode())) {
            System.out.println("Lỗi: Mã giảm giá đã tồn tại.");
            return false;
        }
        if (!isTourIdExists(discount.getTour_Id())) {
            System.out.println("Lỗi: tourId không tồn tại.");
            return false;
        }

        String sql = "INSERT INTO [Discount] (code, quantity, percent_Discount, start_Day, end_Day, require, tour_Id, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, discount.getCode());
            ps.setInt(2, discount.getQuantity());
            ps.setDouble(3, discount.getPercent_Discount());
            ps.setDate(4, new java.sql.Date(discount.getStart_Day().getTime()));
            ps.setDate(5, new java.sql.Date(discount.getEnd_Day().getTime()));
            ps.setString(6, discount.getRequire());
            ps.setString(7, discount.getTour_Id());
            ps.setString(8, discount.getDescription());

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update a discount
    public boolean updateDiscount(Discount discount) {
        String sql = "UPDATE [Discount] SET code=?, quantity=?, percent_Discount=?, start_Day=?, end_Day=?, require=?, tour_Id=?, description=? WHERE discount_Id=?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, discount.getCode());
            ps.setInt(2, discount.getQuantity());
            ps.setDouble(3, discount.getPercent_Discount());
            ps.setDate(4, new java.sql.Date(discount.getStart_Day().getTime()));
            ps.setDate(5, new java.sql.Date(discount.getEnd_Day().getTime()));
            ps.setString(6, discount.getRequire());
            ps.setString(7, discount.getTour_Id());
            ps.setString(8, discount.getDescription());
            ps.setInt(9, discount.getDiscount_Id());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete a discount
    public boolean deleteDiscount(int discountId) {
        String sql = "DELETE FROM [Discount] WHERE discount_Id=?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, discountId);
            int rowsDeleted = ps.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isDiscountCodeExists(String code) {
        String sql = "SELECT COUNT(*) FROM [Discount] WHERE code = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isTourIdExists(String tourId) {
        String sql = "SELECT COUNT(*) FROM [Tour] WHERE tour_Id = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tourId);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<String> getTourIdsByCompanyId(int companyId) {
        List<String> tourIds = new ArrayList<>();
        String query = "SELECT tour_Id FROM Tour WHERE company_Id = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, companyId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String tourId = rs.getString("tour_Id");
                    tourIds.add(tourId);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DiscountDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println("Danh sách tour IDs: " + tourIds);
        return tourIds;
    }

    public Map<String, String> getTourNamesByCompanyId(int companyId) {
        Map<String, String> tourMap = new HashMap<>();
        String query = "SELECT tour_Id, tour_Name FROM Tour WHERE company_Id = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, companyId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String tourId = rs.getString("tour_Id");
                    String tourName = rs.getString("tour_Name");
                    tourMap.put(tourName, tourId);  // Mapping tour_name to tour_id
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DiscountDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tourMap;
    }

    public static void main(String[] args) {
        int companyId = 2;

        // Tạo đối tượng DiscountDB để gọi phương thức
        DiscountDB discountDB = new DiscountDB();

        // Gọi phương thức getTourIdsByCompanyId với companyId để lấy danh sách tour
        List<String> tourIds = discountDB.getTourIdsByCompanyId(companyId);

        // Kiểm tra và in ra danh sách tour ID
        if (tourIds.isEmpty()) {
            System.out.println("Không có tour nào cho companyId: " + companyId);
        } else {
            System.out.println("Danh sách tour ID cho companyId " + companyId + ":");
            for (String tourId : tourIds) {
                System.out.println(tourId);
            }
        }
    }
}
