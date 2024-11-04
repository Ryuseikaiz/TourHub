
import DataAccess.ReviewDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Review;
import model.Tour;
import model.User;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "MyReviewsServlet", urlPatterns = {"/myreviews"})
public class MyReviewsServlet extends HttpServlet {

    private final ReviewDB reviewDB = new ReviewDB();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve cus_Id based on user_Id
        Integer cusId = reviewDB.getCusIdByUserId(currentUser.getUser_Id());
        if (cusId == null) {
            session.setAttribute("reviewError", "Customer information not found.");
            response.sendRedirect("myreviews");
            return;
        }

        // Fetch reviews using cus_Id
        List<Review> userReviews = reviewDB.getUserReviews(cusId);
        Map<Integer, String> tourNames = new HashMap<>();
        Map<Integer, String> tourImages = new HashMap<>();

        for (Review review : userReviews) {
            Tour tour = reviewDB.getTourById(review.getTour_Id());
            if (tour != null) {
                tourNames.put(review.getReview_Id(), tour.getTour_Name());
                tourImages.put(review.getReview_Id(), reviewDB.getTourImageUrl(review.getTour_Id()));
            }
        }

        request.setAttribute("userReviews", userReviews);
        request.setAttribute("tourNames", tourNames);
        request.setAttribute("tourImages", tourImages);

        // Handle success and error messages
        String reviewSuccess = (String) session.getAttribute("reviewSuccess");
        if (reviewSuccess != null) {
            request.setAttribute("reviewSuccess", reviewSuccess);
            session.removeAttribute("reviewSuccess");
        }

        String reviewError = (String) session.getAttribute("reviewError");
        if (reviewError != null) {
            request.setAttribute("reviewError", reviewError);
            session.removeAttribute("reviewError");
        }

        request.getRequestDispatcher("myreview.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            updateReview(request, response);
        } else if ("delete".equals(action)) {
            deleteReview(request, response);
        } else {
            response.sendRedirect("myreviews");
        }
    }

    private void updateReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve cus_Id based on user_Id
        Integer cusId = reviewDB.getCusIdByUserId(currentUser.getUser_Id());
        if (cusId == null) {
            session.setAttribute("reviewError", "Customer information not found.");
            response.sendRedirect("myreviews");
            return;
        }

        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        int ratingStar = Integer.parseInt(request.getParameter("ratingStar"));
        String comment = request.getParameter("comment");

        Review review = new Review();
        review.setReview_Id(reviewId);
        review.setCus_Id(cusId); // Use cus_Id instead of user_Id
        review.setRating_Star(ratingStar);
        review.setComment(comment);

        boolean isUpdated = reviewDB.updateReview(review);

        if (isUpdated) {
            session.setAttribute("reviewSuccess", "Review updated successfully!");
        } else {
            session.setAttribute("reviewError", "Failed to update review.");
        }

        response.sendRedirect("myreviews");
    }

    private void deleteReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String reviewIdParam = request.getParameter("reviewId");
        if (reviewIdParam != null) {
            int reviewId = Integer.parseInt(reviewIdParam);
            boolean isDeleted = reviewDB.deleteReview(reviewId);

            if (isDeleted) {
                session.setAttribute("reviewSuccess", "Review deleted successfully.");
            } else {
                session.setAttribute("reviewError", "Failed to delete the review.");
            }
        } else {
            session.setAttribute("reviewError", "Review ID is required.");
        }

        response.sendRedirect("myreviews");
    }
}
