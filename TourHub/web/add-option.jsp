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
        <link rel="stylesheet" href="assests/css/bootstrap.css" />
        <link rel="stylesheet" href="assests/css/add-option.css" />

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
                <h3 style="<c:if test='${requestScope.message.contains("Successfully")}'>color: green;</c:if>
                    <c:if test='${requestScope.message.contains("Error")}'>color: red;</c:if>">
                    ${requestScope.message}
                </h3>

                <div class="table-data">
                    <div class="order">
                        <h3 class="head" style="font-weight: 600;">Add Tour Option</h3>
                        <form action="provider-management?action=save-option&tourId=${tour.tour_Id}" method="POST" enctype="multipart/form-data"> <!-- Combined form with file upload -->
                            <div class="form-group required">
                                <label for="option_Name">Option Name: <span style="color: red;">*</span></label>
                                <input type="text" class="form-control" id="option_Name" name="option_Name" maxlength="255" required>
                            </div>

                            <div class="form-group required">
                                <label for="option_Description">Option Description: <span style="color: red;">*</span></label>
                                <textarea class="form-control" id="option_Description" name="option_Description" rows="4" required style="width: 100%; resize: vertical;"></textarea>
                            </div>

                            <h4 style="font-weight: 600;">Make Tour Option Schedule</h4>

                            <div class="form-group required">
                                <label for="dayOfWeek">Select days of week you want tour appear: <span style="color: red;">*</span></label>
                                <div id="dayOfWeek" class="day-checkbox-group">
                                    <label><input type="checkbox" name="dayOfWeek" value="Monday"> Monday</label>
                                    <label><input type="checkbox" name="dayOfWeek" value="Tuesday"> Tuesday</label>
                                    <label><input type="checkbox" name="dayOfWeek" value="Wednesday"> Wednesday</label>
                                    <label><input type="checkbox" name="dayOfWeek" value="Thursday"> Thursday</label>
                                    <label><input type="checkbox" name="dayOfWeek" value="Friday"> Friday</label>
                                    <label><input type="checkbox" name="dayOfWeek" value="Saturday"> Saturday</label>
                                    <label><input type="checkbox" name="dayOfWeek" value="Sunday"> Sunday</label>
                                </div>
                                <span id="dayOfWeekError" style="color: red; display: none;">Please select at least one day.</span>
                            </div>

                            <div class="form-group required">
                                <label for="start_Repeat_Date">Select repeat start date: <span style="color: red;">*</span></label>
                                <input type="date" class="form-control" id="start_Repeat_Date" name="start_Repeat_Date" required onchange="validateDates()">
                                <span id="startDateError" style="color: red; display: none;">Start date cannot be in the past.</span>
                            </div>

                            <div class="form-group required">
                                <label for="end_Repeat_Date">Select repeat end date: <span style="color: red;">*</span></label>
                                <input type="date" class="form-control" id="end_Repeat_Date" name="end_Repeat_Date" required onchange="validateDates()">
                                <span id="endDateError" style="color: red; display: none;">End date cannot be in the past.</span>
                            </div>

                            <div class="form-group required">
                                <label for="option_Slot">Slot: <span style="color: red;">*</span></label>
                                <input type="number" class="form-control" id="option_Slot" name="option_Slot" required>
                            </div>

                            <h4 style="font-weight: 600;">Add People In Your Tour</h4>
                            <div id="people-section">
                                <!-- Original Add People Fields -->
                                <h5 style="font-weight: 600;">People 1</h5>
                                <div class="add-people-form">
                                    <!-- Title will be added dynamically, so remove it here -->
                                    <div class="form-group required">
                                        <label for="people_Type">People Type: <span style="color: red;">*</span></label>
                                        <input type="text" class="form-control" id="people_Type" name="people_Type[]" maxlength="255" required placeholder="e.g., 'Adult', 'Child'">
                                    </div>

                                    <div class="form-group required">
                                        <label for="people_Description">People Description: <span style="color: red;">*</span></label>
                                        <textarea class="form-control" id="people_Description" name="people_Description[]" rows="4" required style="width: 100%; resize: vertical;"></textarea>
                                    </div>

                                    <!-- Row for Minimum and Maximum Quantity Fields -->
                                    <div class="form-row">
                                        <div class="form-group required" style="flex: 1; margin-right: 10px;">
                                            <label for="people_MinQty">Minimum Quantity: <span style="color: red;">*</span></label>
                                            <input type="number" class="form-control" id="people_MinQty" name="people_MinQty[]" required>
                                        </div>

                                        <div class="form-group required" style="flex: 1;">
                                            <label for="people_MaxQty">Maximum Quantity: <span style="color: red;">*</span></label>
                                            <input type="number" class="form-control" id="people_MaxQty" name="people_MaxQty[]" required>
                                        </div>
                                    </div>

                                    <!-- Price Field -->
                                    <div class="form-group required">
                                        <label for="people_Price">Price: <span style="color: red;">*</span></label>
                                        <input type="number" class="form-control" id="people_Price" name="people_Price[]" step="0.01" required placeholder="e.g., 100.00">
                                    </div>
                                </div>
                            </div>

                            <!-- Add More People Button -->
                            <button type="button" class="add-people-btn btn btn-secondary">Add More People</button>

                            <button type="submit" class="btn btn-primary btn-block">Add Option</button>
                        </form>

                        <script>
                            const btnAddPeople = document.querySelector('.add-people-btn');
                            // Counter to keep track of the number of people sections
                            let peopleCount = 1;

                            function addMorePeople() {
                                // Increment the people counter
                                peopleCount++;

                                // Get the people section and the first add-people-form
                                const peopleSection = document.getElementById("people-section");
                                const originalForm = document.querySelector(".add-people-form");

                                // Clone the form and reset the input values
                                const newForm = originalForm.cloneNode(true);
                                newForm.querySelectorAll("input, textarea").forEach((input) => {
                                    input.value = ""; // Clear the value of cloned inputs
                                });

                                // Create a new title for the cloned form
                                const title = document.createElement("h5");
                                title.className = "people-title";
                                title.style.fontWeight = "600";
                                title.textContent = "People " + peopleCount;

                                // Insert the new title at the beginning of the new form
                                newForm.insertBefore(title, newForm.firstChild);

                                // Append the cloned form to the people section
                                peopleSection.appendChild(newForm);
                            }

                            btnAddPeople.addEventListener('click', addMorePeople);
                        </script>

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
                            document.querySelector("form").addEventListener("submit", function (event) {
                                const daysSelected = document.querySelectorAll("input[name='dayOfWeek']:checked");
                                if (daysSelected.length === 0) {
                                    event.preventDefault();
                                    document.getElementById("dayOfWeekError").style.display = "inline";
                                } else {
                                    document.getElementById("dayOfWeekError").style.display = "none";
                                }
                            });
        </script>

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
            function validateDates() {
                const startDateInput = document.getElementById('start_Date');
                const endDateInput = document.getElementById('end_Date');
                const startDateError = document.getElementById('startDateError');
                const endDateError = document.getElementById('endDateError');

                const today = new Date().setHours(0, 0, 0, 0); // Today's date without time

                // Convert input values to date objects
                const startDate = new Date(startDateInput.value);
                const endDate = new Date(endDateInput.value);

                // Validate start date
                if (startDateInput.value && startDate < today) {
                    startDateError.style.display = 'block';
                    startDateInput.value = ''; // Clear invalid date
                } else {
                    startDateError.style.display = 'none';
                }

                // Validate end date
                if (endDateInput.value && endDate < today) {
                    endDateError.style.display = 'block';
                    endDateInput.value = ''; // Clear invalid date
                } else {
                    endDateError.style.display = 'none';
                }
            }
        </script>

        <script src="dist/js/theme.min.js"></script>
    </body>
</html>
