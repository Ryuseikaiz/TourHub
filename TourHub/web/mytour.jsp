<%-- 
    Document   : provider-analysis
    Created on : Sep 24, 2024, 9:35:52 PM
    Author     : hoang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Boxicons -->
        <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
        <!-- My CSS -->
        <link rel="stylesheet" href="assests/css/style_profile.css">       
        <link href="assests/css/customer.css" rel="stylesheet" >      
        <link href="assests/css/provider_analysis.css" rel="stylesheet"/>        
        <link href="assests/css/edit-tour.css" rel="stylesheet"/>           
        <link rel="stylesheet" href="assests/css/bootstrap.css" />
        <link rel="stylesheet" href="assests/css/style.css" />


        <link rel="stylesheet" href="assests/css/style_profile.css" media="print" onload="this.media = 'all'">
        <link rel="stylesheet" href="assests/css/customer.css" media="print" onload="this.media = 'all'">
        <link rel="stylesheet" href="assests/css/provider_analysis.css" media="print" onload="this.media = 'all'">
        <link rel="stylesheet" href="assests/css/edit-tour.css" media="print" onload="this.media = 'all'">
        <link rel="stylesheet" href="assests/css/bootstrap.css" media="print" onload="this.media = 'all'">
        <link rel="stylesheet" href="assests/css/style.css" media="print" onload="this.media = 'all'">
        <link rel="stylesheet" href="assests/css/mytour.css" media="print" onload="this.media = 'all'">
        <!-- Toasify JavaScript -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.js"></script>
        <title>Analytic</title>
        <style>
        </style>
    </head>
    <body>


        <!-- SIDEBAR -->
        <section id="sidebar">
            <a href="home" class="brand">
                <i class='bx bxs-smile'></i>
                <span class="text">TourHub</span>
            </a>
            <ul class="side-menu top">
                <li>
                    <a href="user-profile.jsp">
                        <i class='bx bxs-dashboard' ></i>
                        <span class="text">User Information</span>
                    </a>
                </li>
                <c:if test="${sessionScope.currentUser.role == 'Provider'}">
                    <li>
                        <a href="pending-bookings">
                            <i class='bx bxs-shopping-bag-alt' ></i>
                            <span class="text">Manage Booking</span>
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.currentUser.role == 'Customer'}">
                    <li>
                        <a href="user-booking.jsp">
                            <i class='bx bxs-shopping-bag-alt' ></i>
                            <span class="text">My Booking</span>
                        </a>
                    </li>
                </c:if>      
                <li>
                    <a href="#">
                        <i class='bx bxs-message-dots' ></i>
                        <span class="text">Message</span>
                    </a>
                </li>


                <c:if test="${sessionScope.currentUser.role == 'Provider' || sessionScope.currentUser.role == 'Admin'}">
                    <li class="">
                        <a href="${sessionScope.currentUser.role == 'Provider' ? '/Project_SWP/provider-analys' : 'admin-analysis.jsp'}">
                            <i class='bx bxs-dashboard' ></i>
                            <span class="text">Dashboard</span>
                        </a>
                    </li>   
                    <li class="active dropdown-btn">                        
                        <a href="my-tour">
                            <i class='bx bxs-briefcase-alt' ></i>
                            <span class="text">My Tour</span>
                        </a>
                    </li>                       
                    <li>
                        <a href="provider-management?action=show-withdraw-page">
                            <i class='bx bxs-credit-card'></i>
                            <span class="text">Widthdraw</span>
                        </a>
                    </li> 
                    <li>
                        <a href="discount">
                            <i class='bx bxs-discount'></i>
                            <span class="text">Manage Discounts</span>
                        </a>
                    </li>
                </c:if>

            </ul>
            <ul class="side-menu">
                <li>
                    <a href="#">
                        <i class='bx bxs-cog' ></i>
                        <span class="text">Settings</span>
                    </a>
                </li>
                <li>
                    <a href="logout" class="logout">
                        <i class='bx bxs-log-out-circle' ></i>
                        <span class="text">Logout</span>
                    </a>
                </li>
            </ul>
        </section>
        <!-- SIDEBAR -->



        <!-- CONTENT -->
        <section id="content">
            <!-- NAVBAR -->
            <nav>
                <i class='bx bx-menu' ></i>
                <a href="#" class="nav-link"></a>
                <form action="#">
                    <div class="form-input">
                        <input type="search" placeholder="Searching for tour...">
                        <button type="submit" class="search-btn"><i class='bx bx-search' ></i></button>
                    </div>
                </form>
                <input type="checkbox" id="switch-mode" hidden>
                <label for="switch-mode" class="switch-mode"></label>
                <a href="#" class="notification">
                    <i class='bx bxs-bell' ></i>
                    <!-- <span class="num">8</span> -->
                </a>
                <div class="image-container">
                    <img src="assests/images/avatar.jpg" alt="User Avatar" class="avatar">
                </div>

            </nav>
            <!-- NAVBAR -->

            <!-- MAIN -->
            <main>
                <c:choose>
                    <c:when test="${sessionScope.currentUser == null}">
                        <c:redirect url="home" />
                    </c:when>
                    <c:otherwise>
                        <!-- Search Form -->
                        <form action="provider-management?action=search" method="POST">
                            <div class="form-input-custom">
                                <input type="search" name="tour-edit" class="search-field-custom tour-edit" 
                                       placeholder="Enter tourID or tour name to find tour you want to edit">
                                <button type="submit" class="search-btn"><i class='bx bx-search'></i></button>
                            </div>
                        </form>
                        <!-- Add New Tour Button -->
                        <div style="display: flex; justify-content: space-between; align-items: center">
                            <div style="margin-top: 10px; display: flex; width: 100%">
                                <form action="provider-management?action=show-add-tour" method="POST">
                                    <button type="submit" class="button button-primary">Add New Tour</button>
                                </form>
                                <form method="post" action="import-tour?action=save-import" enctype="multipart/form-data" style="margin-left: auto;" accept-charset="UTF-8">
                                    <label for="file-upload" class="button-primary">
                                        Import Tour
                                    </label>
                                    <input type="file" id="file-upload" name="file" style="display: none;" onchange="this.form.submit()" />
                                </form>

                            </div>




                        </div>
                        <div style="display: flex; margin-top: 20px">
                            <div>Or you can add tours by downloading and filling out this <a href="./assests/tour-import-template/addtour.csv" download="addtour.csv">form</a></div>
                            <div class="sort-options" style="margin-left: auto;">
                                <label for="sortOrder">Sort by:</label>
                                <select id="sortOrder" name="sortOrder" onchange="sortTours()">
                                    <option value="most-booking" ${param.sortOrder == 'most-booking' ? 'selected="selected"' : ''}>Most Booking</option>
                                    <option value="price-asc" ${param.sortOrder == 'price-asc' ? 'selected="selected"' : ''}>Lowest Price</option>
                                    <option value="price-desc" ${param.sortOrder == 'price-desc' ? 'selected="selected"' : ''}>Highest Price</option>
<!--                                    <option value="pending-only" ${param.sortOrder == 'pending-only' ? 'selected="selected"' : ''}>Pending Tour</option>
                                    <option value="active-only" ${param.sortOrder == 'active-only' ? 'selected="selected"' : ''}>Active Tour</option>
                                    <option value="hidden-tour" ${param.sortOrder == 'hidden-tour' ? 'selected="selected"' : ''}>Hidden Tour</option>-->
                                </select>
                            </div>
                        </div>
                        <div id="filterStatus" class="filter-status">
                            <label>Tour Status:</label>
                            <div class="radio-group">
                                <input type="radio" id="cancelled" name="status" value="Cancelled" onchange="sendStatus()" ${param.filterStatus == 'Cancelled' ? 'checked' : ''}>
                                <label for="cancelled">Cancelled</label>

                                <input type="radio" id="banned" name="status" value="Banned" onchange="sendStatus()" ${param.filterStatus == 'Banned' ? 'checked' : ''}>
                                <label for="banned">Banned</label> 

                                <input type="radio" id="hidden" name="status" value="Hidden" onchange="sendStatus()" ${param.filterStatus == 'Hidden' ? 'checked' : ''}>
                                <label for="hidden">Hidden</label>

                                <input type="radio" id="active" name="status" value="Active" onchange="sendStatus()" ${param.filterStatus == 'Active' ? 'checked' : ''}>
                                <label for="active">Active</label>

                                <input type="radio" id="pending" name="status" value="Pending" onchange="sendStatus()" ${param.filterStatus == 'Pending' ? 'checked' : ''}>
                                <label for="pending">Pending</label>

                                <input type="radio" id="all" name="status" value="" onchange="sendStatus()" ${param.filterStatus == '' ? 'checked' : ''}>
                                <label for="all">All</label>
                            </div>
                        </div>


                        <!-- Error Message Display -->                      
                        <!-- Display a Single Tour to Edit if tourEdit is available -->
                        <c:if test="${not empty tours}">                            
                            <div class="table-data">
                                <div class="order">
                                    <div class="row row-50">
                                        <c:forEach var="tour" items="${tours}">
                                            <div class="col-md-6 col-xl-4 lazy">
                                                <article class="event-default-wrap" style="background: rgba(0, 0, 0, 0.1); border-radius: 10px">
                                                    <c:choose>
                                                        <c:when test="${tour.tour_Status == 'Hidden' || tour.tour_Status == 'Banned'}">
                                                            <div class="event-default darken-effect">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="event-default  no-blur-effect">
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <figure class="event-default-image" style="position: relative; max-width: 250px; margin: auto;">
                                                                <figure class="event-default-image skeleton" style="max-width: 300px; margin: auto; margin-top: 15px">
                                                                    <img data-src="${tour.tour_Img[0]}" alt="${tour.tour_Name}" style="min-height: 250px; max-height: 450px; object-fit: cover; width: 100%;" class="lazy fade-in">
                                                                </figure>
                                                                <c:if test="${tour.tour_Status ne 'Banned'}">
                                                                    <div class="event-default-caption" style="position: absolute; top: 25%; left: 50%; transform: translate(-50%, -50%); display: grid; grid-template-columns: repeat(2, 1fr); gap: 5px; width: 0px; height: 0px">
                                                                        <a href="provider-management?action=edit-tour&tourId=${tour.tour_Id}" 
                                                                           class="button button-xs button-secondary button-nina tour-visit-count" 
                                                                           style="font-size: 12px; padding: 2px 5px; line-height: 1; display: inline-block; text-align: center;">
                                                                            Edit
                                                                        </a>
                                                                        <a href="provider-management?action=add-option&tourId=${tour.tour_Id}" 
                                                                           class="button button-xs button-secondary button-nina tour-visit-count" 
                                                                           style="font-size: 12px; font-weight: bold; padding: 2px 5px; line-height: 1; display: inline-block; text-align: center;">
                                                                            Add Option
                                                                        </a>
                                                                        <c:if test="${tour.tour_Status == 'Active'}">
                                                                            <a href="javascript:void(0);" 
                                                                               class="button button-xs button-secondary button-nina tour-visit-count action-link approve" 
                                                                               style="font-size: 12px; padding: 2px 5px; line-height: 1; display: inline-block; text-align: center;"
                                                                               onclick="showModal('${tour.tour_Id}', 'Hidden')">
                                                                                Hidden
                                                                            </a>
                                                                        </c:if>
                                                                        <c:if test="${tour.tour_Status == 'Hidden'}">
                                                                            <a href="javascript:void(0);" 
                                                                               class="button button-xs button-secondary button-nina tour-visit-count" 
                                                                               style="font-size: 12px; padding: 2px 5px; line-height: 1; display: inline-block; text-align: center;"
                                                                               onclick="showModal('${tour.tour_Id}', 'Active')">
                                                                                Active
                                                                            </a>
                                                                        </c:if>

                                                                    </div>
                                                                </c:if>
                                                            </figure>

                                                        </div>
                                                        <div class="event-default-inner"  style="justify-content: center !important; width: 100%";>
                                                            <div>
                                                                <h5>
                                                                    <a href="provider-management?action=edit-tour&tourId=${tour.tour_Id}" class="event-default-title">${tour.tour_Name}</a>
                                                                </h5>
                                                            </div>
                                                        </div>
                                                </article>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>

                        </c:if>
                        <!-- Display All Tours if providerTours is available -->   
                        <c:if test="${empty tours}">
                            <h4 style="margin-top: 30px; display: flex; text-align: center; width: 100%">No Tour Available</h4>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                </div>
                </div>

            </main> 
            <!-- MAIN -->
        </section>
        <!-- CONTENT -->
        <!-- Modal HTML Structure -->
        <div id="confirmModal" class="custom-modal">
            <div class="custom-modal-content">
                <span class="custom-close">&times;</span>
                <h4 id="modalTitle">Confirm Action</h4>
                <p id="modalMessage">Are you sure you want to proceed?</p>
                <p id="modalDetails" class="custom-modal-details">This action may affect the visibility and availability of your tour.</p>
                <div class="custom-modal-buttons">
                    <button id="confirmBtn" class="custom-button-primary">Confirm</button>
                    <button id="cancelBtn" class="custom-button-secondary">Cancel</button>
                </div>
            </div>
        </div>

        <script src="assests/js/script_profile.js"></script>     
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                                                                                   document.addEventListener('DOMContentLoaded', function () {
                                                                                       const burger = document.querySelector('.burger');
                                                                                       const navigation = document.querySelector('.navigation-admin');
                                                                                       const main = document.querySelector('.main-admin');
                                                                                       const profileCard = document.querySelector('.profile-card'); // Select the profile card

                                                                                       burger.addEventListener('click', function () {
                                                                                           navigation.classList.toggle('active');
                                                                                           main.classList.toggle('active');
                                                                                           profileCard.classList.toggle('active'); // Toggle the active class on the profile card
                                                                                       });
                                                                                   });
        </script>
        <script>
            function reloadData() {
                var date = document.getElementById("date").value;
                $.ajax({
                    url: "/Project_SWP/provider-analys",
                    type: "POST",
                    data: {
                        date: date
                    },
                    success: function (data) {
                        // Assuming 'data' is a JSON object
                        document.querySelector("#totalVisitValue").innerHTML = data.totalVisitATour || 0;
                        document.querySelector("#visitTodayValue").innerHTML = data.visitToday || 0;
                        document.querySelector("#bookingThisMonthValue").innerHTML = data.bookingThisMonth || 0;
                    }
                });
            }

            // Sorting function
            function sortTours() {
                const sortOrder = document.getElementById('sortOrder').value;
                // Redirect to the sorted page with the selected order
                window.location.href = 'sort?sortOrder=' + sortOrder;
            }
            function sendStatus() {
                const selectedStatus = document.querySelector('input[name="status"]:checked').value;
                console.log("Selected Status:", selectedStatus); // Debugging log
                // Save the selected status in localStorage
                localStorage.setItem('selectedStatus', selectedStatus);
                // Redirect to the sorted page with the selected status
                window.location.href = 'my-tour?filterStatus=' + selectedStatus;
            }

        </script>
        <script>
            window.onload = function () {
                const message = '<c:out value="${message}" />';
                if (message) {
                    Toastify({
                        text: message,
                        duration: 3000,
                        gravity: "top",
                        position: "right",
                        backgroundColor: "linear-gradient(to right, #00b09b, #96c93d)",
                        close: true, // Enables the close button
                        style: {
                            fontSize: "18px", // Makes the text larger
                            padding: "20px", // Increases padding for a bigger appearance
                            borderRadius: "8px" // Optional: makes the corners more rounded
                        }
                    }).showToast();
                }
            };
        </script>

        <c:remove var="message" />
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const lazyDivs = document.querySelectorAll(".col-md-6.col-xl-4.lazy");
                if ("IntersectionObserver" in window) {
                    const lazyDivObserver = new IntersectionObserver((entries, observer) => {
                        entries.forEach(entry => {
                            if (entry.isIntersecting) {
                                entry.target.classList.add("fade-in"); // Add fade-in class to make the element visible
                                lazyDivObserver.unobserve(entry.target);
                            }
                        });
                    });
                    lazyDivs.forEach(lazyDiv => {
                        lazyDivObserver.observe(lazyDiv);
                    });
                } else {
                    // Fallback for older browsers
                    lazyDivs.forEach(div => {
                        div.classList.add("fade-in");
                    });
                }
            });
            document.addEventListener("DOMContentLoaded", function () {
                const lazyImages = document.querySelectorAll("img.lazy");
                if ("IntersectionObserver" in window) {
                    const lazyImageObserver = new IntersectionObserver((entries, observer) => {
                        entries.forEach(entry => {
                            if (entry.isIntersecting) {
                                const lazyImage = entry.target;
                                lazyImage.src = lazyImage.dataset.src;
                                lazyImage.classList.add("fade-in"); // Add fade-in class to fade in the image
                                lazyImage.onload = () => {
                                    lazyImage.classList.add("loaded"); // Mark as loaded for additional styling
                                    lazyImage.parentElement.classList.remove("skeleton"); // Remove skeleton effect
                                };
                                lazyImageObserver.unobserve(lazyImage);
                            }
                        });
                    });
                    lazyImages.forEach(lazyImage => {
                        lazyImageObserver.observe(lazyImage);
                    });
                } else {
                    // Fallback for older browsers
                    lazyImages.forEach(img => {
                        img.src = img.dataset.src;
                        img.classList.add("fade-in");
                        img.onload = () => img.classList.add("loaded");
                    });
                }
            });
            function showModal(tourId, action) {
                const modal = document.getElementById("confirmModal");
                const closeBtn = document.querySelector(".custom-close");
                const confirmBtn = document.getElementById("confirmBtn");
                const cancelBtn = document.getElementById("cancelBtn");
                const modalTitle = document.getElementById("modalTitle");
                const modalMessage = document.getElementById("modalMessage");
                const modalDetails = document.getElementById("modalDetails");

                // Set the modal message and title based on the action
                if (action === 'Hidden') {
                    modalTitle.textContent = "Confirm Hide Action";
                    modalMessage.textContent = "Are you sure you want to hide this tour?";
                    modalDetails.textContent = "Hiding this tour will make it unavailable for booking and it won't be visible to customers. You can make it active again at any time.";
                } else if (action === 'Active') {
                    modalTitle.textContent = "Confirm Activate Action";
                    modalMessage.textContent = "Are you sure you want to activate this tour?";
                    modalDetails.textContent = "Activating this tour will make it visible to customers and available for booking.";
                }

                // Show the modal
                modal.style.display = "block";

                // Close the modal when the close button or cancel button is clicked
                const closeModal = () => {
                    modal.style.display = "none";
                };
                closeBtn.onclick = closeModal;
                cancelBtn.onclick = closeModal;

                // Handle the confirmation action
                confirmBtn.onclick = () => {
                    // Redirect to the respective action URL based on the given action
                    window.location.href = 'provider-management?action=set-tour-status&tourId=' + tourId + '&status=' + action;
                };

                // Close the modal if user clicks outside of it
                window.onclick = (event) => {
                    if (event.target === modal) {
                        closeModal();
                    }
                };
            }
        </script>
        <script defer src="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.min.js"></script>

        <script src="dist/js/theme.min.js"></script>
    </body>
</html>
