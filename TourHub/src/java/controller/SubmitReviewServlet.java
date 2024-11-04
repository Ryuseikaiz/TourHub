
import DataAccess.ReviewDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Booking;
import model.Review;
import model.Tour;
import model.User;

@WebServlet(name = "SubmitReviewServlet", urlPatterns = {"/SubmitReview"})
public class SubmitReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tourId = request.getParameter("tourId");
        int ratingStar = Integer.parseInt(request.getParameter("ratingStar"));
        String comment = request.getParameter("comment");

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve cus_Id based on the current user's user_Id
        ReviewDB reviewDB = new ReviewDB();
        Integer cusId = reviewDB.getCusIdByUserId(currentUser.getUser_Id()); // Assuming this method exists

        if (cusId == null) {
            request.setAttribute("error", "Could not find customer information. Please contact support.");
            request.getRequestDispatcher("reviewtour.jsp").forward(request, response);
            return;
        }

        Review review = new Review();
        review.setCus_Id(cusId);  // Set cus_Id instead of user_Id
        review.setTour_Id(tourId);
        review.setRating_Star(ratingStar);
        review.setComment(comment);

        boolean isReviewSubmitted = reviewDB.submitReview(review);

        if (isReviewSubmitted) {
            session.setAttribute("reviewSuccess", "Thank you for reviewing our tour!");
        } else {
            request.setAttribute("error", "There was an error submitting your review. Please try again.");
        }

        response.sendRedirect("SubmitReview");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve cus_Id based on the current user's user_Id
        ReviewDB reviewDB = new ReviewDB();
        Integer cusId = reviewDB.getCusIdByUserId(currentUser.getUser_Id()); // Assuming this method exists

        if (cusId == null) {
            request.setAttribute("error", "Could not find customer information. Please contact support.");
            request.getRequestDispatcher("reviewtour.jsp").forward(request, response);
            return;
        }

        List<Booking> bookedTours = reviewDB.getBookedToursWithoutReview(cusId);

        Map<String, String> tourImages = new HashMap<>();
        for (Booking booking : bookedTours) {
            String tourImageUrl = reviewDB.getTourImageUrl(booking.getTour_Id());
            tourImages.put(booking.getTour_Id(), tourImageUrl); // Store image URL in Map
        }

        request.setAttribute("bookedTours", bookedTours);
        request.setAttribute("tourImages", tourImages); // Pass the Map to JSP

        String reviewSuccess = (String) session.getAttribute("reviewSuccess");
        if (reviewSuccess != null) {
            request.setAttribute("reviewSuccess", reviewSuccess);
            session.removeAttribute("reviewSuccess");
        }

        request.getRequestDispatcher("reviewtour.jsp").forward(request, response);
    }
}
