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
import model.Company;

/**
 *
 * @author hoang
 */
public class CompanyDB {

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

    public int getCompanyIdFromUserId(int userId) throws SQLException {
        String query = "SELECT company_Id FROM Company WHERE user_Id = ?";
        try (Connection con = getConnect(); PreparedStatement statement = con.prepareStatement(query)) {
            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt("company_Id");
                } else {
                    throw new SQLException("No company found for userId: " + userId);
                }
            }
        }
    }

    public Company getProviderByProviderId(int providerId) {
        Company company = null;
        String query = "SELECT * FROM Company WHERE company_Id = ?";

        try (PreparedStatement preparedStatement = getConnect().prepareStatement(query)) {
            preparedStatement.setInt(1, providerId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    company = new Company();
                    company.setCompanyId(resultSet.getInt("company_Id"));
                    company.setTaxCode(resultSet.getString("tax_Code"));
                    company.setBalance(resultSet.getBigDecimal("balance"));
                    company.setBankInformation(resultSet.getString("bank_Information"));
                    company.setUser_Id(resultSet.getInt("user_Id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return company;
    }

    public void updateCompanyBalance(Company company) {
        String query = "UPDATE Company SET balance = ? WHERE company_Id = ?";

        try (PreparedStatement preparedStatement = getConnect().prepareStatement(query)) {
            preparedStatement.setBigDecimal(1, company.getBalance()); // Set the new balance
            preparedStatement.setInt(2, company.getCompanyId());      // Set the company ID

            int rowsAffected = preparedStatement.executeUpdate(); // Execute the update
            if (rowsAffected > 0) {
                System.out.println("Company balance updated successfully.");
            } else {
                System.out.println("No company found with the given ID.");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }
    }

    public Company getProviderByTourId(String tourId) {
        Company company = null;
        String query = "SELECT c.company_id, c.tax_code, c.balance, c.bank_information, c.user_id "
                + "FROM Company c "
                + "JOIN Tour t ON c.company_id = t.company_id "
                + "WHERE t.tour_id = ?";

        try (PreparedStatement preparedStatement = getConnect().prepareStatement(query)) {
            preparedStatement.setString(1, tourId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    company = new Company();
                    company.setCompanyId(resultSet.getInt("company_id"));
                    company.setTaxCode(resultSet.getString("tax_code"));
                    company.setBalance(resultSet.getBigDecimal("balance"));
                    company.setBankInformation(resultSet.getString("bank_information"));
                    company.setUser_Id(resultSet.getInt("user_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return company;
    }

}
