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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Province;

/**
 *
 * @author hoang
 */
public class ProvinceDB {

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

    public List<Province> getProvinceByVisitCount() {
        List<Province> provinces = new ArrayList<>();
        String query = "SELECT TOP 15 * from Provinces ORDER BY visit_count DESC";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int province_id = rs.getInt("province_id");
                String province_name = rs.getString("province_name");
                int visit_count = rs.getInt("visit_count");
                String image_url = rs.getString("image_url");

                Province province = new Province(province_id, province_name, visit_count, image_url);
                provinces.add(province);
            }

        } catch (SQLException ex) {
            Logger.getLogger(TourDB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return provinces;
    }

    public int updateVisitProvinceCount(int province_id) {
        try (Connection connection = DriverManager.getConnection(DBURL, USERDB, PASSDB)) {
            String sql = "UPDATE Provinces SET visit_count = visit_count + 1 WHERE province_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, province_id);
                int rowsUpdated = statement.executeUpdate();
                return rowsUpdated;
            }
        } catch (Exception e) {
            e.printStackTrace();  // Ideally, replace with proper logging
            return 0; // Return 0 in case of failure
        }
    }

    public List<Province> getProvinceByQuery(String query) {
        List<Province> provinces = new ArrayList<>();
        String sql = "SELECT province_id, province_name, visit_count, image_url FROM Provinces WHERE province_name COLLATE Latin1_General_CI_AI LIKE ?";

        try (Connection connection = getConnect(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            // Use wildcard % for partial matches
            preparedStatement.setString(1, "%" + query + "%");

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Province province = new Province();
                    province.setProvince_id(resultSet.getInt("province_id"));
                    province.setProvince_name(resultSet.getString("province_name"));
                    province.setVisit_count(resultSet.getInt("visit_count"));
                    province.setImage_url(resultSet.getString("image_url"));

                    provinces.add(province);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return provinces;
    }

    public List<Province> getAllProvince() {
        List<Province> provinces = new ArrayList<>();
        String sql = "SELECT province_id, province_name, visit_count, image_url FROM Provinces";

        try (Connection connection = getConnect(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Province province = new Province();
                    province.setProvince_id(resultSet.getInt("province_id"));
                    province.setProvince_name(resultSet.getString("province_name"));
                    province.setVisit_count(resultSet.getInt("visit_count"));
                    province.setImage_url(resultSet.getString("image_url"));

                    provinces.add(province);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return provinces;
    }

    public static void main(String[] args) {
        List<Province> provinces = new ProvinceDB().getProvinceByVisitCount();
        for (Province pro : provinces) {
            System.out.println(pro.toString());
        }
    }
}
