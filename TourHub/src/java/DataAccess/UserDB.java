package DataAccess;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import model.User;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Company;
import model.Customer;

import model.Tour;
import model.TourOption;

import utils.Encrypt;

public class UserDB implements DatabaseInfo {

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

    public boolean registerUser(User user) {
        if (isEmailExists(user.getEmail())) {
            return false; // Email already exists
        }
        String sql = "INSERT INTO [User] (password, first_Name, last_Name, phone, email, address, created_At, user_Status, role, avatar) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getPassword());
            ps.setString(2, user.getFirst_Name());
            ps.setString(3, user.getLast_Name());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getAddress());
            ps.setTimestamp(7, new java.sql.Timestamp(user.getCreated_At().getTime()));
            ps.setString(8, user.getUser_Status());
            ps.setString(9, user.getRole());
            ps.setString(10, user.getAvatar()); // Set avatar field

            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void verifyUser(String email) {
        String sql = "UPDATE [User] SET user_Status = 'Verified' WHERE email = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public User getUserById(int userId) {
    User user = null;
    String query = "SELECT user_Id, password, user_Status, role, first_Name, last_Name, email, phone, address, created_At, avatar "
                 + "FROM [User] WHERE user_Id = ?";

    try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(query)) {
        stmt.setInt(1, userId);  // Set the user ID parameter

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            // Retrieve user details from the result set
            user = new User(
                rs.getInt("user_Id"),
                rs.getString("password"),
                rs.getString("first_Name"),
                rs.getString("last_Name"),
                rs.getString("phone"),
                rs.getString("email"),
                rs.getString("address"),
                rs.getTimestamp("created_At"),
                rs.getString("user_Status"),
                rs.getString("role"),
                rs.getString("avatar")
            );
        }
    } catch (SQLException e) {
        e.printStackTrace();
        Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, e);
    }

    return user;  // Return the User object or null if not found
}


    public User authenticate(String email, String password) {
        String sql = "SELECT * FROM [User] WHERE email = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("password");

                // If password is null (Google login), bypass password check
                if (password == null || storedPassword.equals(Encrypt.toSHA256(password))) {
                    return new User(
                            rs.getInt("user_Id"),
                            rs.getString("password"),
                            rs.getString("first_Name"),
                            rs.getString("last_Name"),
                            rs.getString("phone"),
                            rs.getString("email"),
                            rs.getString("address"),
                            rs.getTimestamp("created_At"),
                            rs.getString("user_Status"),
                            rs.getString("role"),
                            rs.getString("avatar")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateGoogleAccount(User user) {
        boolean result = false;
        String sql = "UPDATE [User] SET phone = ?, address = ?, password = ?, role = ? WHERE user_Id = ?";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getPhone());
            stmt.setString(2, user.getAddress());
            stmt.setString(3, user.getPassword()); // Update password
            stmt.setString(4, user.getRole());     // Update role
            stmt.setInt(5, user.getUser_Id());

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                result = true; // Update successful
            }
        } catch (SQLException e) {
            System.out.println("Error updating user account: " + e.getMessage());
            e.printStackTrace();
        }

        return result; // Return true if update was successful
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM [User] WHERE email = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; // Email exists
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //Kiem tra email co trong database hay la khong
    public boolean checkEmailExists(String email) {
        String query = "SELECT email FROM [User] WHERE email = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }

    public void updateUser_StatusToVerified(String email) {
        String sql = "UPDATE [User] SET user_Status = 'Verified' WHERE email = ?";

        try (Connection con = getConnect(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void saveCompany(Company company) throws SQLException {
        String query = "INSERT INTO Company (tax_Code, bank_Information, balance, user_Id) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, company.getTaxCode());
            stmt.setString(2, company.getBankInformation());
            stmt.setBigDecimal(3, company.getBalance());
            stmt.setInt(4, company.getUser_Id());
            stmt.executeUpdate();
        }
    }

    public void saveCustomer(Customer customer) throws SQLException {
        String query = "INSERT INTO Customer (cus_Birth, user_Id) VALUES (?, ?)";
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDate(1, customer.getCus_Birth());
            stmt.setInt(2, customer.getUser_Id());
            stmt.executeUpdate();
        }
    }

    public boolean hasCustomerInfo(int userId) {
        // Query the customer table to check if this user has already provided info
        String sql = "SELECT COUNT(*) FROM Customer WHERE user_Id = ?"; // Ensure column name matches your DB schema
        try (Connection conn = getConnect(); // Get the connection here
                 PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Return true if there is customer info
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean hasCompanyInfo(int userId) {
        // Query the company table to check if this user has already provided info
        String sql = "SELECT COUNT(*) FROM Company WHERE user_Id = ?"; // Ensure column name matches your DB schema
        try (Connection conn = getConnect(); // Get the connection here
                 PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Return true if there is company info
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

//-------------------------------------------------
    //Láº¥y all user ra
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM [User]";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sql)) {
            ResultSet resultSet = stmt.executeQuery();
            while (resultSet.next()) {
                User user = new User();
                user.setUser_Id(resultSet.getInt("user_Id"));
                user.setPassword(resultSet.getString("password"));
                user.setFirst_Name(resultSet.getString("first_Name"));
                user.setLast_Name(resultSet.getString("last_Name"));
                user.setPhone(resultSet.getString("phone"));
                user.setEmail(resultSet.getString("email"));
                user.setAddress(resultSet.getString("address"));
                user.setCreated_At(resultSet.getDate("created_At"));
                user.setUser_Status(resultSet.getString("user_Status"));
                user.setRole(resultSet.getString("role"));
                users.add(user);
            }
            System.out.println(users);
            return users;
        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<User> getAllUsersNotAdmin() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM [User] WHERE role = 'Provider' OR role = 'Customer'";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sql)) {
            ResultSet resultSet = stmt.executeQuery();
            while (resultSet.next()) {
                User user = new User();
                user.setUser_Id(resultSet.getInt("user_Id"));
                user.setPassword(resultSet.getString("password"));
                user.setFirst_Name(resultSet.getString("first_Name"));
                user.setLast_Name(resultSet.getString("last_Name"));
                user.setPhone(resultSet.getString("phone"));
                user.setEmail(resultSet.getString("email"));
                user.setAddress(resultSet.getString("address"));
                user.setCreated_At(resultSet.getDate("created_At"));
                user.setUser_Status(resultSet.getString("user_Status"));
                user.setRole(resultSet.getString("role"));
                users.add(user);
            }
            System.out.println(users);
            return users;
        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<User> getAllUsersExceptAdmin() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM [User] WHERE (role='Customer' OR role='Provider')";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sql)) {
            ResultSet resultSet = stmt.executeQuery();
            while (resultSet.next()) {
                User user = new User();
                user.setUser_Id(resultSet.getInt("user_Id"));
                user.setPassword(resultSet.getString("password"));
                user.setFirst_Name(resultSet.getString("first_Name"));
                user.setLast_Name(resultSet.getString("last_Name"));
                user.setPhone(resultSet.getString("phone"));
                user.setEmail(resultSet.getString("email"));
                user.setAddress(resultSet.getString("address"));
                user.setCreated_At(resultSet.getDate("created_At"));
                user.setUser_Status(resultSet.getString("user_Status"));
                user.setRole(resultSet.getString("role"));
                users.add(user);
            }
            System.out.println(users);
            return users;
        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public User getUser(int user_Id) {
        User user = null;
        String query = "SELECT user_Id, password, user_Status, role, first_Name, last_Name, email, phone, address, created_At, avatar "
                + "FROM [User] WHERE user_Id = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, user_Id);
            ResultSet rs = stmt.executeQuery();

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
                Date created_At = rs.getDate(10);
                String avatar = rs.getString(11); // Get avatar

                user = new User(id, password, first_Name, last_Name, phone, email, address, created_At, user_Status, role, avatar);
            }

        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    //ThÃªm user má»›i
    public void insertUser(User user) {
        String sql = "INSERT INTO [User] (password, role, email) VALUES (?, ?, ?)";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, user.getPassword());
            stmt.setString(2, user.getRole());
            stmt.setString(3, user.getEmail());
            stmt.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //Change password
    public boolean updatePassword(int user_Id, String newPassword) {
        String query = "UPDATE [User] SET password=? WHERE user_Id=?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, newPassword);
            stmt.setInt(2, user_Id);
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated == 0) {
                throw new SQLException("Update failed, no rows affected. Email might not exist.");
            }
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean updateEmail(int userId, String newEmail) {
        String query = "UPDATE [User] SET email = ? WHERE user_Id = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            // Set new email and user_Id
            stmt.setString(1, newEmail);
            stmt.setInt(2, userId);

            // Execute the update query
            int rowsUpdated = stmt.executeUpdate();

            // Check if the update was successful
            if (rowsUpdated == 0) {
                throw new SQLException("Update failed, no rows affected.");
            }
            return true;  // Update successful
        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public User getUserFromSession(HttpSession session) {
        return (User) session.getAttribute("currentUser");
    }

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

    //Edit profile function
    public boolean updateUser(User user) {
        boolean result = false;
        String sql = "UPDATE [User] SET "
                + "first_Name =?, last_Name=?, email=?, phone=?, address=?, avatar=? "
                + "WHERE user_Id=?";
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getFirst_Name());
            stmt.setString(2, user.getLast_Name());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getAddress());
            stmt.setString(6, user.getAvatar()); // Set avatar field
            stmt.setInt(7, user.getUser_Id());

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                result = true;
                return result;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public User getUserFromSession(HttpSession session, HttpServletRequest request) {
        User user = (User) session.getAttribute("currentUser");
        return user; // or throw an exception if user not found
    }

}
