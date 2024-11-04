/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
document.addEventListener("DOMContentLoaded", function () {
    calculateDuration();
    console.log("DOM fully loaded and parsed");

    // Get the message from the data attribute
    var toastContainer = document.getElementById('toastContainer');
    var toastMessage = toastContainer.getAttribute('data-message');

    // Debugging message value
    console.log("Toast message:", toastMessage);

    // Toastify message handling
    if (toastMessage && toastMessage.trim() !== "") {
        Toastify({
            text: toastMessage,
            duration: 3000,
            gravity: "top",
            position: "right",
            backgroundColor: "linear-gradient(to right, #00b09b, #96c93d)",
            close: true,
            style: {
                fontSize: "18px",
                padding: "20px",
                borderRadius: "8px"
            }
        }).showToast();
    } else {
        console.log("No valid toast message found.");
    }
});


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
    if (endDateInput.value && endDate < startDate) {
        endDateError.style.display = 'block';
        endDateInput.value = ''; // Clear invalid date
    } else {
        endDateError.style.display = 'none';
    }
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
        var diffTime = end.getTime() - start.getTime();

        // Convert the time difference to days (1 day = 24*60*60*1000 milliseconds)
        var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

        if (diffDays > 0) {
            // Set the day value
            document.getElementById("day").value = diffDays;

            // Set the night value (days - 1)
            document.getElementById("night").value = diffDays - 1;
        } else {
            // Reset the fields if the date difference is invalid (e.g., end date is before start date)
            document.getElementById("day").value = 0;
            document.getElementById("night").value = 0;
        }
    } else {
        // Reset the fields if either date is missing
        document.getElementById("day").value = 0;
        document.getElementById("night").value = 0;
    }
}

function removeImage(tourId, imageToRemove) {
    const xhr = new XMLHttpRequest();
    xhr.open("POST", "/Project_SWP/provider-management?action=remove-image", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                // Successfully removed the image, remove the element from the DOM
                const imageContainer = document.getElementById(`image-${imageToRemove}`);
                if (imageContainer) {
                    imageContainer.remove();
                }
            } else if (xhr.status === 404) {
                alert("Image not found or already removed.");
            } else if (xhr.status === 500) {
                alert("An error occurred while trying to remove the image.");
            }
        }
    };

    // Send AJAX request with tourId and imageToRemove parameters
    xhr.send(`tourId=${encodeURIComponent(tourId)}&imageToRemove=${encodeURIComponent(imageToRemove)}`);
}
document.addEventListener("DOMContentLoaded", function () {
    const slotInput = document.getElementById("slot");
    const errorElement = document.getElementById("slotError");

    slotInput.addEventListener("input", function () {
        const slotValue = parseFloat(this.value);

        if (isNaN(slotValue) || slotValue < 0) {
            errorElement.style.display = "block";
            this.setCustomValidity("Slot must be a non-negative number.");
        } else {
            errorElement.style.display = "none";
            this.setCustomValidity("");
        }
    });
});
