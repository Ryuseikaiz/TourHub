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


        <title>Tour Reviews</title>
    </head>
    <body>
        <!-- SIDEBAR -->
        <section id="sidebar">
            <a href="index.jsp" class="brand">
                <i class='bx bxs-smile'></i>
                <span class="text">TourHub</span>
            </a>
            <ul class="side-menu top">
                <li>
                    <a href="user-profile.jsp">
                        <i class='bx bxs-dashboard'></i>
                        <span class="text">User Information</span>
                    </a>
                </li>
                <li>
                    <a href="user-booking.jsp">
                        <i class='bx bxs-shopping-bag-alt'></i>
                        <span class="text">My Booking</span>
                    </a>
                </li>
                <li>
                    <a href="user-chat.jsp">
                        <i class='bx bxs-message-dots'></i>
                        <span class="text">Message</span>
                    </a>
                </li>
                <c:if test="${sessionScope.currentUser.role == 'Provider'}">
                    <li>
                        <a href="discount">
                            <i class='bx bxs-discount'></i>
                            <span class="text">Manage Discounts</span>
                        </a>
                    </li>
                </c:if>

                <li class="active">
                    <a href="SubmitReview">
                        <i class='bx bxs-star'></i>
                        <span class="text">Review Tours</span>
                    </a>
                </li>
            </ul>
            <ul class="side-menu">
                <li>
                    <a href="#">
                        <i class='bx bxs-cog'></i>
                        <span class="text">Settings</span>
                    </a>
                </li>
                <li>
                    <a href="logout" class="logout">
                        <i class='bx bxs-log-out-circle'></i>
                        <span class="text">Logout</span>
                    </a>
                </li>
            </ul>
        </section>
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
                        <a class="nav-link active" href="SubmitReview">Review Tours</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="myreviews">My Reviews</a>
                    </li>
                </ul>
            </div>

            <main class="container mt-5">
                <h2>Review your booked tours</h2>

                <!-- If there are no tours to review -->
                <c:if test="${empty bookedTours}">
                    <p class="alert alert-info">You have no tours to review.</p>
                </c:if>

                <c:if test="${not empty bookedTours}">
                    <div class="row">
                        <c:forEach var="booking" items="${bookedTours}">
                            <div class="col-md-4">
                                <div class="tour-card">
                                    <!-- Access the tour image from tourImages map using the tour_Id -->
                                    <img src="${tourImages[booking.tour_Id]}" class="tour-image" alt="Tour Image">
                                    <div class="tour-details">
                                        <h3 class="tour-title">${booking.tour_Name}</h3>
                                        <p class="tour-info">
                                            <strong>Booking Date:</strong> ${booking.created_At} <br>
                                            <strong>Tour Date:</strong> ${booking.tour_Date} <br>
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
