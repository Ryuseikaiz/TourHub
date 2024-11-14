/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */



function reloadData() {
    var date = document.getElementById("date").value;
    $.ajax({
        url: "/provider-analys",
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
    xhr.open("POST", "/provider-management?action=remove-image", true);
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

document.addEventListener("DOMContentLoaded", function () {
    console.log("DOM fully loaded and parsed");

    // Initialize notification polling
    startNotificationPolling();

    // Get the toast message from a data attribute, if available
    var toastContainer = document.getElementById('toastContainer');
    var toastMessage = toastContainer ? toastContainer.getAttribute('data-message') : null;

    if (toastMessage && toastMessage.trim() !== "") {
        displayToastNotification(toastMessage);
    } else {
        console.log("No valid toast message found.");
    }
    // Recalculate the duration on page load
    calculateDuration();
});

/* Function to start polling notifications */
function startNotificationPolling() {
    setInterval(fetchNotifications, 10000); // Poll every 10 seconds
}

/* Fetch notifications using AJAX */
function fetchNotifications() {
    $.ajax({
        url: '/notifications',
        type: 'POST',
        success: function (data) {
            displayNotifications(data);

            // Check for new notifications
            if (data.length > 0) {
                const latestNotification = data[0];
                if (latestNotification.notificationId !== window.latestNotificationId) {
                    window.latestNotificationId = latestNotification.notificationId;
                    displayToastNotification(latestNotification.message);
                }
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error('Failed to fetch notifications:', textStatus, errorThrown);
            const dropdownContent = document.querySelector('.dropdown-content');
            dropdownContent.innerHTML = '<p>Failed to load notifications. Please try again later.</p>';
            document.getElementById('notificationDropdown').classList.add('visible');
        }
    });
}

/* Display notifications in the dropdown */
function displayNotifications(notifications) {
    const dropdownContent = document.querySelector('.dropdown-content');
    dropdownContent.innerHTML = '';

    const latestNotifications = notifications.slice(0, 5);

    if (latestNotifications.length === 0) {
        const noResultsMessage = document.createElement('p');
        noResultsMessage.textContent = 'No new notifications';
        noResultsMessage.style.textAlign = 'center';
        dropdownContent.appendChild(noResultsMessage);
    } else {
        latestNotifications.forEach(notification => {
            const notificationItem = document.createElement('div');
            notificationItem.classList.add('notification-item');
            notificationItem.setAttribute('data-id', notification.notificationId);

            const textDiv = document.createElement('div');
            textDiv.classList.add('text');
            textDiv.style.flex = '1';

            const messageP = document.createElement('p');
            messageP.textContent = notification.message || 'No message available';

            if (notification.isRead == 0) {
                messageP.style.fontWeight = 'bold';
            }

            const timestampSpan = document.createElement('span');
            timestampSpan.textContent = notification.dateSent || 'Unknown date';

            textDiv.appendChild(messageP);
            textDiv.appendChild(timestampSpan);
            notificationItem.appendChild(textDiv);
            dropdownContent.appendChild(notificationItem);
        });
    }
}

/* Display a toast notification */
function displayToastNotification(message) {
    if (typeof Toastify !== 'undefined') {
        Toastify({
            text: message,
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
        console.error("Toastify is not loaded.");
    }
}