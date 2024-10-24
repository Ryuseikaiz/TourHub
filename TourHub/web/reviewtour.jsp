<%@ page import="java.util.List" %>
<%@ page import="model.Tour" %>
<%@ page import="model.Booking" %>
<%@ page import="model.User" %>
<%@ page import="DataAccess.ReviewDB" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="assests/css/review.css">
        <link rel="stylesheet" href="assests/css/style_profile.css">
        <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="assests/css/review.css">
        <link rel="stylesheet" href="assests/css/style_profile.css">      

        <title>Tour Reviews</title>
    </head>
    <body>
        <!-- SIDEBAR -->
        <%@include file="includes/user-sidebar.jsp" %>
        <!-- SIDEBAR -->

        <!-- CONTENT -->
        <section id="content">
            <nav>
                <i class='bx bx-menu' ></i>
                <form action="#">
                    <div class="form-input">
                        <input type="search" placeholder="Searching for tour...">
                        <button type="submit" class="search-btn"><i class='bx bx-search' ></i></button>
                    </div>
                </form>
                <a href="#" class="notification">
                    <i class='bx bxs-bell' ></i>
                    <span class="num">8</span>
                </a>
                <a href="#" class="profile">
                    <img src="img/people.png">
                </a>              
            </nav>

            <!-- Success Message -->
            <c:if test="${not empty reviewSuccess}">
                <div class="alert alert-success" role="alert">${reviewSuccess}</div>
            </c:if>

            <div class="container mt-3">
                <ul class="nav nav-pills">
                    <li class="nav-item">
                        <a class="nav-link active" href="reviewtour.jsp">Review Tours</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="myreview.jsp">My Reviews</a>
                    </li>
                </ul>
            </div>

            <main class="container mt-5">
                <h2>Review your booked tours</h2>

                <!-- If there are no tours to review -->
                <c:if test="${empty bookedTours}">
                    <p class="alert alert-info">You have no tours to review.</p>
                </c:if>

                <!-- If there are tours to review -->
                <c:if test="${not empty bookedTours}">
                    <div class="row">
                        <c:forEach var="booking" items="${bookedTours}">
                            <div class="col-md-4">
                                <div class="tour-card">
                                    <img src="${booking.tour_Img}" class="tour-image" alt="Tour Image">
                                    <div class="tour-details">
                                        <h3 class="tour-title">${booking.tour_Name}</h3>
                                        <p class="tour-info">
                                            <strong>Booking Date:</strong> ${booking.created_At} <br>
                                            <strong>Quantity:</strong> ${booking.slot_Order} <br>
                                            <strong>Total Cost:</strong> $${booking.total_Cost}
                                        </p>
                                        <a href="javascript:void(0)" class="review-button" onclick="openReviewPopup('${booking.tour_Id}')">Review</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <!-- Review Popup -->
                <div id="reviewPopup" class="modal">
                    <div class="modal-content">
                        <span class="close" onclick="closeReviewPopup()">&times;</span>
                        <h2>Submit Review</h2>
                        <form action="SubmitReview" method="post">
                            <input type="hidden" name="tourId" id="tourIdInput">

                            <!-- Rating Star Section -->
                            <div class="form-group">
                                <label for="ratingStar">Rating:</label>
                                <div class="star-rating">
                                    <span class="star" data-value="1">&#9733;</span>
                                    <span class="star" data-value="2">&#9733;</span>
                                    <span class="star" data-value="3">&#9733;</span>
                                    <span class="star" data-value="4">&#9733;</span>
                                    <span class="star" data-value="5">&#9733;</span>
                                </div>
                                <input type="hidden" id="ratingStar" name="ratingStar" value="0" required>
                            </div>

                            <!-- Comment Section -->
                            <div class="form-group">
                                <label for="comment">Comment:</label>
                                <textarea id="comment" name="comment" class="form-control" rows="3" required></textarea>
                            </div>

                            <!-- Submit Button -->
                            <button type="submit" class="btn btn-primary btn-block">Submit Review</button>
                        </form>
                    </div>
                </div>
            </main>
        </section>
        <!-- CONTENT -->

        <!-- Scripts -->
        <script>
            function openReviewPopup(tourId) {
                const modal = document.getElementById('reviewPopup');
                document.getElementById('tourIdInput').value = tourId;
                modal.classList.add('show');
            }

            function closeReviewPopup() {
                const modal = document.getElementById('reviewPopup');
                modal.classList.remove('show');
            }

            const stars = document.querySelectorAll('.star');
            const ratingInput = document.getElementById('ratingStar');

            stars.forEach(star => {
                star.addEventListener('click', () => {
                    const ratingValue = star.getAttribute('data-value');
                    ratingInput.value = ratingValue;

                    stars.forEach(s => {
                        if (s.getAttribute('data-value') <= ratingValue) {
                            s.classList.add('selected');
                        } else {
                            s.classList.remove('selected');
                        }
                    });
                });

                star.addEventListener('mouseover', () => {
                    const hoverValue = star.getAttribute('data-value');
                    stars.forEach(s => {
                        if (s.getAttribute('data-value') <= hoverValue) {
                            s.classList.add('selected');
                        } else {
                            s.classList.remove('selected');
                        }
                    });
                });

                star.addEventListener('mouseout', () => {
                    const ratingValue = ratingInput.value;
                    stars.forEach(s => {
                        if (s.getAttribute('data-value') <= ratingValue) {
                            s.classList.add('selected');
                        } else {
                            s.classList.remove('selected');
                        }
                    });
                });
            });
        </script>
    </body>
</html>
