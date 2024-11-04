
import DataAccess.DiscountDB;
import DataAccess.UserDB;
import DataAccess.hoang_UserDB;
import controller.ProviderTourServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

@WebServlet("/create-discount")
public class CreateDiscountServlet extends HttpServlet {

    private final DiscountDB tourDB = new DiscountDB();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser != null && "Provider".equals(currentUser.getRole())) {
            int companyId = 0;
            try {
                companyId = new hoang_UserDB().getProviderIdFromUserId(currentUser.getUser_Id());
            } catch (SQLException ex) {
                Logger.getLogger(ProviderTourServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            Map<String, String> providerTourNames = tourDB.getTourNamesByCompanyId(companyId);
            if (providerTourNames.isEmpty()) {
                session.setAttribute("error", "No tours available for this provider.");
                response.sendRedirect("manage-discounts.jsp");
            } else {
                request.setAttribute("providerTourNames", providerTourNames);
                request.getRequestDispatcher("create-discount.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }

}
