package controller;

import DataAccess.UserDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.Company;
import model.User;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

@WebServlet(name = "CompanyInfoServlet", urlPatterns = {"/updateCompanyInfo"})
public class CompanyInfoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null || !user.getRole().equals("Provider")) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get tax code and bank information details from the form
        String taxCode = request.getParameter("taxCode");
        String bankName = request.getParameter("bankInformation");
        String accountNumber = request.getParameter("accountNumber");

        // Combine bank name and account number with a space
        String bankInformation = bankName + " " + accountNumber;

        // Create a new Company object
        Company company = new Company();
        company.setTaxCode(taxCode);
        company.setBankInformation(bankInformation);
        company.setUser_Id(user.getUser_Id());
        company.setBalance(BigDecimal.ZERO); // Initial balance

        // Save company details to the database
        UserDB companyDB = new UserDB();
        try {
            companyDB.saveCompany(company);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("companyInfo.jsp").forward(request, response);
            return;
        }

        // Update user session data
        user.setTax_Code(taxCode);
        user.setBank_Information(bankInformation);
        user.setBalance(BigDecimal.ZERO);
        session.setAttribute("currentUser", user);

        // Redirect to homepage or provider dashboard after successful update
        response.sendRedirect("home");
    }
}
