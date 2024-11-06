/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

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
});

/* Function to start polling notifications */
function startNotificationPolling() {
    setInterval(fetchNotifications, 10000); // Poll every 10 seconds
}

/* Fetch notifications using AJAX */
function fetchNotifications() {
    $.ajax({
        url: '/Project_SWP/notifications',
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
