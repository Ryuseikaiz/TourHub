let fetchInterval;
let latestNotificationId = null; // Initialize to null or set the latest ID you already have

// Toggle the notification dropdown visibility and set up polling if opened
function toggleDropdown(event) {
    event.preventDefault();
    const dropdown = document.getElementById("notificationDropdown");

    if (!dropdown) {
        console.error('Dropdown element not found');
        return;
    }

    const isVisible = dropdown.classList.toggle("visible");
    dropdown.classList.toggle("hidden", !isVisible);

    if (isVisible) {
        fetchNotifications();
        if (!fetchInterval) {
            fetchInterval = setInterval(fetchNotifications, 50); // Check every 5 seconds
        }
    } else {
        clearInterval(fetchInterval);
        fetchInterval = null;
    }
}

// Close dropdown when clicking outside
window.onclick = function (event) {
    if (!event.target.closest('.notification') && !event.target.closest('#notificationDropdown')) {
        const dropdown = document.getElementById("notificationDropdown");
        if (dropdown && dropdown.classList.contains("visible")) {
            dropdown.classList.remove("visible");
            dropdown.classList.add("hidden");
            clearInterval(fetchInterval);
            fetchInterval = null;
        }
    }
};

// Fetch notifications from the server
function fetchNotifications() {
    $.ajax({
        url: '/Project_SWP/notifications',
        type: 'POST',
        data: {latestNotificationId: latestNotificationId || 0}, // Send the latestNotificationId or 0 if null
        success: function (response) {
            if (response.hasNewNotifications) {
                showNotifications(response.notifications);

                // Update latest notification ID and show a toast for each new notification
                if (response.notifications.length > 0) {
                    const latestNotification = response.notifications[0];
                    if (latestNotification.notificationId !== latestNotificationId) {
                        latestNotificationId = latestNotification.notificationId;
                        showToastNotification(latestNotification.message); // Show toast for the newest notification
                    }
                }
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error('AJAX request failed:', textStatus, errorThrown);
            const dropdownContent = document.querySelector('.dropdown-content');
            dropdownContent.innerHTML = '<p>Failed to load notifications. Please try again later.</p>';
            document.getElementById('notificationDropdown').classList.add('visible');
        }
    });
}

// Display notifications in the dropdown
function showNotifications(notifications) {
    const dropdownContent = document.querySelector('.dropdown-content');
    dropdownContent.innerHTML = ''; // Clear existing notifications

    const latestNotifications = notifications.slice(0, 5); // Limit to 5 notifications

    if (latestNotifications.length === 0) {
        const noResultsMessage = document.createElement('p');
        noResultsMessage.textContent = 'No new notifications';
        noResultsMessage.style.textAlign = 'center';
        dropdownContent.appendChild(noResultsMessage);
    } else {
        latestNotifications.forEach(notification => {
            const notificationItem = document.createElement('div');
            notificationItem.classList.add('notification-item');
            notificationItem.style.display = 'flex';
            notificationItem.style.alignItems = 'center';
            notificationItem.style.marginBottom = '10px';
            notificationItem.setAttribute('data-id', notification.notificationId);

            const textDiv = document.createElement('div');
            textDiv.classList.add('text');
            textDiv.style.flex = '1';

            const messageP = document.createElement('p');
            messageP.style.fontSize = '15px';
            messageP.style.color = '#333333';

            if (notification.isRead == 0) {
                messageP.style.fontWeight = 'bold';
            }

            messageP.textContent = notification.message || 'No message available';
            textDiv.appendChild(messageP);

            const timestampSpan = document.createElement('span');
            timestampSpan.style.fontSize = '13px';
            timestampSpan.style.color = '#666666';
            timestampSpan.textContent = notification.dateSent || 'Unknown date';
            textDiv.appendChild(timestampSpan);

            notificationItem.appendChild(textDiv);
            dropdownContent.appendChild(notificationItem);
        });
    }
    dropdownContent.classList.remove('hidden'); // Show dropdown if it was hidden
}

// Display a toast notification with message
function showToastNotification(message, type = 'success') {
    Toastify({
        text: message,
        duration: 3000,
        gravity: "bottom",
        position: "right",
        backgroundColor: type === 'success' ? "green" : "red",
        stopOnFocus: true
    }).showToast();
}

// Initialize continuous polling regardless of dropdown visibility
if (!fetchInterval) {
    fetchInterval = setInterval(fetchNotifications, 50); // Check every 5 seconds
}
