
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
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Discount;
import model.User;

@WebServlet("/discount")
public class DiscountServlet extends HttpServlet {

    private final DiscountDB DiscountDB = new DiscountDB();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        // Check if the user is Admin or Provider
        if (currentUser != null && ("Provider".equals(currentUser.getRole()))) {
            String action = request.getParameter("action");

            if (action == null) {
                listDiscounts(request, response);
            } else {
                switch (action) {
                    case "new":
                        showNewForm(request, response);
                        break;
                    case "edit":
                        showEditForm(request, response);
                        break;
                    default:
                        listDiscounts(request, response);
                        break;
                }
            }
        } else {
            // Redirect unauthorized users to an error page
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        // Check if the user is Admin or Provider
        if (currentUser != null && ("Admin".equals(currentUser.getRole()) || "Provider".equals(currentUser.getRole()))) {
            String action = request.getParameter("action");

            switch (action) {
                case "insert":
                    insertDiscount(request, response);
                    break;
                case "update":
                    updateDiscount(request, response);
                    break;
                case "delete":
                    deleteDiscount(request, response);
                    break;
                default:
                    listDiscounts(request, response);
                    break;
            }
        } else {
            // Redirect unauthorized users to an error page
            response.sendRedirect("login.jsp");
        }
    }

    // Common method to list all discounts
    private void listDiscounts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser != null && "Provider".equals(currentUser.getRole())) {
            int companyId = 0;
            try {
                companyId = new hoang_UserDB().getProviderIdFromUserId(currentUser.getUser_Id());
            } catch (SQLException ex) {
                Logger.getLogger(ProviderTourServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            // Get discounts with tour_name
            List<Discount> listDiscount = DiscountDB.getDiscountsByCompanyId(companyId);
            request.setAttribute("listDiscount", listDiscount);
            request.getRequestDispatcher("manage-discounts.jsp").forward(request, response);
        }
    }

    // Shows the form to create a new discount
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("create-discount.jsp").forward(request, response);
    }

    // Shows the form to edit an existing discount
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int discountId = getRequestParameterAsInt(request, "id", response);
        if (discountId == -1) {
            return;
        }
        Discount existingDiscount = DiscountDB.getDiscountById(discountId);
        if (existingDiscount == null) {
            request.setAttribute("error", "Discount not found.");
            listDiscounts(request, response);
        } else {
            request.setAttribute("discount", existingDiscount);
            request.getRequestDispatcher("edit-discount.jsp").forward(request, response);
        }
    }

    // Inserts a new discount into the database
    private void insertDiscount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            Discount discount = getDiscountFromRequest(request);

            // Kiểm tra xem startDate không được trễ hơn endDate
            if (discount.getStart_Day().after(discount.getEnd_Day())) {
                throw new IllegalArgumentException("Start date cannot be after end date.");
            }

            // Kiểm tra mã giảm giá đã tồn tại
            if (DiscountDB.isDiscountCodeExists(discount.getCode())) {
                throw new IllegalArgumentException("Discount code already exists!");
            }

            // Kiểm tra tour ID có tồn tại không
            if (!DiscountDB.isTourIdExists(discount.getTour_Id())) {
                throw new IllegalArgumentException("Tour ID does not exist!");
            }

            // Chèn discount vào cơ sở dữ liệu
            DiscountDB.insertDiscount(discount);

            // Đặt thông báo thành công vào session
            request.getSession().setAttribute("message", "Discount created successfully!");

            // Chuyển hướng đến trang quản lý discount
            response.sendRedirect("discount");
        } catch (IllegalArgumentException e) {
            // Đặt thông báo lỗi vào session
            request.getSession().setAttribute("error", e.getMessage());

            // Chuyển hướng đến trang tạo mã giảm giá
            response.sendRedirect("create-discount");
        }
    }

    // Updates an existing discount in the database
    private void updateDiscount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            int discountId = getRequestParameterAsInt(request, "id", response);
            if (discountId == -1) {
                return;
            }

            // Lấy thông tin mã giảm giá từ request
            Discount discount = getDiscountFromRequest(request);
            discount.setDiscount_Id(discountId);

            // Lấy mã giảm giá hiện tại từ cơ sở dữ liệu
            String currentCode = DiscountDB.getDiscountById(discountId).getCode();

            // Kiểm tra nếu mã mới khác với mã hiện tại và mã đó đã tồn tại
            if (!currentCode.equals(discount.getCode()) && DiscountDB.isDiscountCodeExists(discount.getCode())) {
                throw new IllegalArgumentException("Discount code already exists!");
            }

            // Kiểm tra tour ID có tồn tại không
            if (!DiscountDB.isTourIdExists(discount.getTour_Id())) {
                throw new IllegalArgumentException("Tour ID does not exist!");
            }

            // Kiểm tra xem startDate không được trễ hơn endDate
            if (discount.getStart_Day().after(discount.getEnd_Day())) {
                throw new IllegalArgumentException("Start date cannot be after end date.");
            }

            // Cập nhật discount vào cơ sở dữ liệu
            DiscountDB.updateDiscount(discount);

            // Đặt thông báo thành công vào session
            request.getSession().setAttribute("message", "Discount updated successfully!");

            // Chuyển hướng đến trang quản lý discount
            response.sendRedirect("discount");

        } catch (IllegalArgumentException e) {
            // Đặt thông báo lỗi vào session
            request.getSession().setAttribute("error", e.getMessage());

            // Chuyển hướng đến trang chỉnh sửa mã giảm giá
            response.sendRedirect("edit-discount?id=" + request.getParameter("id"));
        }
    }

    // Deletes a discount from the database
    private void deleteDiscount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int discountId = getRequestParameterAsInt(request, "id", response);
        if (discountId == -1) {
            return;
        }
        DiscountDB.deleteDiscount(discountId);
        request.setAttribute("message", "Discount deleted successfully!");
        listDiscounts(request, response);
    }

    // Helper method to parse and validate date
    private Date parseDate(String dateStr) {
        try {
            return Date.valueOf(dateStr);
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("Invalid date format. Please use YYYY-MM-DD.");
        }
    }

    // Helper method to parse and validate integers
    private int getRequestParameterAsInt(HttpServletRequest request, String param, HttpServletResponse response) throws IOException {
        try {
            return Integer.parseInt(request.getParameter(param));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format for parameter: " + param);
            return -1;
        }
    }

    // Helper method to parse and validate double
    private double getRequestParameterAsDouble(HttpServletRequest request, String param) {
        try {
            return Double.parseDouble(request.getParameter(param));
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid number format for parameter: " + param);
        }
    }

    // Extract Discount object from request parameters
    private Discount getDiscountFromRequest(HttpServletRequest request) throws IOException {
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            throw new IllegalArgumentException("Discount code cannot be empty.");
        }

        int quantity = getRequestParameterAsInt(request, "quantity", null);
        if (quantity < 0) {
            throw new IllegalArgumentException("Quantity cannot be negative.");
        }

        double percentDiscount = getRequestParameterAsDouble(request, "percentDiscount");
        if (percentDiscount < 0) {
            throw new IllegalArgumentException("Discount percentage cannot be negative.");
        }
        String require = request.getParameter("require");
        if (require == null || require.isEmpty()) {
            throw new IllegalArgumentException("You must select the required number of order slots.");
        }
        String tourId = request.getParameter("tourId");
        String description = request.getParameter("description");
        Date startDate = parseDate(request.getParameter("startDate"));
        Date endDate = parseDate(request.getParameter("endDate"));

        return new Discount(0, code, quantity, percentDiscount, startDate, endDate, require, tourId, description);
    }

}
