<%-- 
    Document   : provider-analysis
    Created on : Sep 24, 2024, 9:35:52 PM
    Author     : hoang
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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

        <title>Analytic</title>
        <style>
            body {
                background-color: #f4f4f4;
            }
            .form-container {
                margin-top: 50px;
                background: #fff;
                padding: 30px;
                border-radius: 5px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body>

        <%@include file="includes/user-sidebar.jsp" %>

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
                        <form action="SearchTourByIdServlet" method="POST">
                            <div class="form-input-custom">
                                <input type="search" name="tour-edit" class="search-field-custom tour-edit" placeholder="Enter tourID to find tour want to edit" required>
                                <button type="submit" class="search-btn"><i class='bx bx-search'></i></button>
                            </div>
                        </form>
                        <div class="table-data">
                            <div class="order">              
                                <div class="row row-50">                           
                                    <c:set value="${requestScope.tourEdit}" var="tour" />
                                    <c:if test="${not empty tour}">
                                        <div class="col-md-6 col-xl-4">
                                            <article class="event-default-wrap">
                                                <div class="event-default">
                                                    <figure class="event-default-image" style="max-width: 250px; margin: auto;">
                                                        <img src="./assests/images/tour-images/${tour.tour_Img[0]}" alt="Tour Name" style="width: 100%; height: auto;">
                                                        <div class="event-default-caption">
                                                            <a href="edit-tour-page.jsp" class="button button-xs button-secondary button-nina tour-visit-count" data-id="${tour.tour_Id}" style="font-size: 12px; padding: 2px 5px; line-height: 1; width: 50px; display: inline-block; text-align: center;">
                                                                Edit
                                                            </a>
                                                        </div>
                                                    </figure>
                                                </div>
                                                <div class="event-default-inner">
                                                    <div>
                                                        <h5>
                                                            <a href="edit-tour-page.jsp" class="event-default-title">${tour.tour_Name}</a>
                                                        </h5>
                                                    </div>
                                                </div>
                                            </article>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty sessionScope.errorMessage}">
                                        <div class="error-message">${sessionScope.errorMessage}</div>
                                    </c:if>                            
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

            </main>          
            <!-- MAIN -->
        </section>
        <!-- CONTENT -->
        <script src="assests/js/script_profile.js"></script>  
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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
            function calculateDuration() {
                // Get the values of the start and end dates
                var startDate = document.getElementById("start_Date").value;
                var endDate = document.getElementById("end_Date").value;

                if (startDate && endDate) {
                    // Parse the dates into Date objects
                    var start = new Date(startDate);
                    var end = new Date(endDate);

                    // Calculate the difference in time (milliseconds)
                    var diffTime = end - start;

                    // Convert the time difference to days (1 day = 24*60*60*1000 milliseconds)
                    var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

                    if (diffDays > 0) {
                        // Set the day value
                        document.getElementById("day").value = diffDays;

                        // Set the night value (days - 1)
                        document.getElementById("night").value = diffDays - 1;
                    } else {
                        // If the end date is before the start date, reset the fields
                        document.getElementById("day").value = 0;
                        document.getElementById("night").value = 0;
                    }
                } else {
                    // Reset the fields if either date is missing
                    document.getElementById("day").value = 0;
                    document.getElementById("night").value = 0;
                }
            }
        </script>

        <script src="dist/js/theme.min.js"></script>
        <script src="assests/js/core.min.js"></script>
        <script src="assests/js/script.js"></script>


    </body>
</html>
