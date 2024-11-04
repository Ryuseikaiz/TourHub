/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DataAccess;

import static DataAccess.DatabaseInfo.DBURL;
import static DataAccess.DatabaseInfo.DRIVERNAME;
import static DataAccess.DatabaseInfo.PASSDB;
import static DataAccess.DatabaseInfo.USERDB;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Withdrawals;
import java.sql.ResultSet;
import model.Booking;

/**
 *
 * @author hoang
 */
public class WithdrawalsDB implements DatabaseInfo {

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

    public boolean saveWithdrawal(int provider_Id, BigDecimal amount) {
        String sql = "INSERT INTO Withdrawals (provider_Id, withdraw_money, request_Date, Status) "
                + "VALUES (?, ?, GETDATE(), ?)"; // Use a placeholder for Status

        // Load the JDBC driver for SQL Server
        // Establish the database connection
        try (Connection connection = getConnect(); PreparedStatement pstmt = connection.prepareStatement(sql)) {
            // Set parameters for the prepared statement
            pstmt.setInt(1, provider_Id);
            pstmt.setBigDecimal(2, amount); // Ensure correct type
            pstmt.setString(3, "Pending"); // Set status as "Pending"

            // Execute the insert
            pstmt.executeUpdate();
            return true; // Indicate success
        } catch (SQLException e) { // Catch the exception and print the error message
            e.printStackTrace(); // Logging the exception
            return false; // Indicate failure
        }
    }

    // Method to retrieve all withdrawal requests for a specific provider_id
    public List<Withdrawals> getWithdrawalsByProviderId(int providerId) throws SQLException {
        List<Withdrawals> withdrawals = new ArrayList<>();
        String query = "SELECT * FROM Withdrawals WHERE provider_Id = ?";

        try (Connection connection = getConnect(); // Assumes a Database class for connection
                 PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, providerId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                // Assuming you have a WithdrawalRequest class to represent a withdrawal request
                Withdrawals withdrawal = new Withdrawals();
                withdrawal.setId(resultSet.getInt("withdrawals_Id")); // Adjust based on your column names
                withdrawal.setProviderId(resultSet.getInt("provider_Id"));
                withdrawal.setWithdrawMoney(resultSet.getBigDecimal("withdraw_money"));
                withdrawal.setStatus(resultSet.getString("status")); // Adjust as necessary
                withdrawal.setRequestDate(resultSet.getDate("request_Date")); // Adjust as necessary
                withdrawal.setRespondDate(resultSet.getDate("respond_Date")); // Take the respond date

                withdrawals.add(withdrawal);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions as needed
            throw e; // Re-throw for further handling
        }

        return withdrawals;
    }

    
    
    public static void main(String[] args) throws SQLException {
        List<Withdrawals> tours = new WithdrawalsDB().getWithdrawalsByProviderId(2);
        for (Withdrawals book : tours) {
            System.out.println(book.toString());
        }
    }
}
