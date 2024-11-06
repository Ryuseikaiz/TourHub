let fetchInterval;
let latestNotificationId = null; // Holds the latest notification ID
let notificationViewCount = {}; // Tracks view counts for each notification
let firstLoad = true; // Flag to check if it's the first load

// Toggle the notification dropdown visibility
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
        incrementNotificationViewCount(); // Increase view count for displayed notifications
        checkAndMarkNotificationsAsRead(); // Mark as read only if viewed twice
    }
}

// Close dropdown if clicking outside of it
window.onclick = function (event) {
    if (!event.target.closest('.notification') && !event.target.closest('#notificationDropdown')) {
        const dropdown = document.getElementById("notificationDropdown");
        if (dropdown && dropdown.classList.contains("visible")) {
            dropdown.classList.remove("visible");
            dropdown.classList.add("hidden");
        }
    }
};

// Increment the view count for each notification shown in the dropdown
function incrementNotificationViewCount() {
    const notificationItems = document.querySelectorAll('.notification-item');
    notificationItems.forEach(item => {
        const notificationId = item.getAttribute('data-id');
        if (notificationId) {
            // Increment view count only if it hasn’t reached 2 yet
            if (!notificationViewCount[notificationId] || notificationViewCount[notificationId] < 2) {
                notificationViewCount[notificationId] = (notificationViewCount[notificationId] || 0) + 1;
            }
        }
    });
}

// Marks notifications as read if they’ve been viewed exactly twice
function checkAndMarkNotificationsAsRead() {
    // Filter notifications where view count is exactly 2
    const notificationsToMarkRead = Object.keys(notificationViewCount).filter(id => notificationViewCount[id] === 3);

    if (notificationsToMarkRead.length > 0) {
        $.ajax({
            url: '/Project_SWP/markNotificationsAsRead',
            type: 'POST',
            data: JSON.stringify({notificationIds: notificationsToMarkRead}),
            contentType: 'application/json',
            success: function () {
                // Update UI for each notification marked as read
                notificationsToMarkRead.forEach(id => {
                    const notificationItem = document.querySelector(`.notification-item[data-id="${id}"] p`);
                    if (notificationItem) {
                        notificationItem.style.fontWeight = 'normal';
                    }
                });

                // Clear the view count for notifications marked as read to prevent further processing
                notificationsToMarkRead.forEach(id => delete notificationViewCount[id]);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.error('Failed to mark notifications as read:', textStatus, errorThrown);
            }
        });
    }
}

// Fetch notifications from the server
function fetchNotifications() {
    $.ajax({
        url: '/Project_SWP/notifications',
        type: 'POST',
        data: {latestNotificationId: latestNotificationId || 0},
        success: function (response) {
            if (response.hasNewNotifications) {
                displayNotifications(response.newNotifications);
                const latestNotification = response.newNotifications[0];

                // Show a toast notification only on the first load with a new notification
                if (latestNotification && latestNotification.notificationId !== latestNotificationId) {
                    latestNotificationId = latestNotification.notificationId;

                    // Only show Toastify notification on the first load
                    if (firstLoad) {
//                        showToastNotification(latestNotification.message);
                        firstLoad = false; // Set to false after first load
                    } else {
                        showToastNotification(latestNotification.message);
                    }
                }
            }

            // Display all unread notifications
            displayNotifications(response.allUnReadNotifications);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error('AJAX request failed:', textStatus, errorThrown);
        }
    });
}

// Display notifications in the dropdown, tracking views
function displayNotifications(notifications) {
    const dropdownContent = document.querySelector('.dropdown-content');
    dropdownContent.innerHTML = ''; // Clear current notifications

    const latestNotifications = notifications.slice(0, 5); // Show up to 5 notifications

    if (latestNotifications.length === 0) {
        const noResultsMessage = document.createElement('p');
        noResultsMessage.textContent = 'No new notifications';
        noResultsMessage.style.textAlign = 'center';
        dropdownContent.appendChild(noResultsMessage);
    } else {
        latestNotifications.forEach(notification => {
            const notificationId = notification.notificationId;
            // Initialize view count only if it's the first time displaying this notification
            if (!notificationViewCount[notificationId]) {
                notificationViewCount[notificationId] = 1;
            }

            const notificationItem = createNotificationElement(notification);
            dropdownContent.appendChild(notificationItem);
        });
    }
}

// Creates a notification element for display
function createNotificationElement(notification) {
    const notificationId = notification.notificationId;

    const notificationItem = document.createElement('div');
    notificationItem.classList.add('notification-item');
    notificationItem.style.display = 'flex';
    notificationItem.style.alignItems = 'center';
    notificationItem.style.marginBottom = '10px';
    notificationItem.setAttribute('data-id', notificationId);

    const textDiv = document.createElement('div');
    textDiv.classList.add('text');
    textDiv.style.flex = '1';

    const messageP = document.createElement('p');
    messageP.style.fontSize = '15px';
    messageP.style.color = '#333333';
    messageP.style.fontWeight = (notification.isRead == 0 && notificationViewCount[notificationId] < 2) ? 'bold' : 'normal';
    messageP.textContent = notification.message || 'No message available';

    const timestampSpan = document.createElement('span');
    timestampSpan.style.fontSize = '13px';
    timestampSpan.style.color = '#666666';
    timestampSpan.textContent = notification.dateSent || 'Unknown date';

    textDiv.appendChild(messageP);
    textDiv.appendChild(timestampSpan);
    notificationItem.appendChild(textDiv);

    return notificationItem;
}

// Displays a toast notification with the provided message
function showToastNotification(message) {
    Toastify({
        text: message,
        duration: 3000,
        gravity: "bottom",
        position: "right",
        padding: "20px",
        backgroundColor: "linear-gradient(to right, #F39C12, #FFD564)",
        stopOnFocus: true
    }).showToast();
}

// Start fetching notifications every 500ms
if (!fetchInterval) {
    fetchInterval = setInterval(fetchNotifications, 500); // Fetch notifications every 500ms
}
