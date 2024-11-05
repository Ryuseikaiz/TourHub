let fetchInterval; // Declare a global variable to store the interval ID

// Toggle the visibility of the notification dropdown
function toggleDropdown(event) {
    console.log("toggleDropdown function triggered"); // Debugging statement
    event.preventDefault(); // Prevent default anchor behavior
    const dropdown = document.getElementById("notificationDropdown");

    if (!dropdown) {
        console.error('Dropdown element not found');
        return;
    }

    // Toggle visibility class
    const isVisible = dropdown.classList.toggle("visible");
    dropdown.classList.toggle("hidden", !isVisible);

    // Fetch notifications and start interval if dropdown is visible
    if (isVisible) {
        fetchNotifications();

        // Set up real-time fetching every 10 seconds, only if not already set
        if (!fetchInterval) {
            fetchInterval = setInterval(fetchNotifications, 100); // Adjust interval as needed (e.g., 10000 for 10 seconds)
        }
    } else {
        // Clear the interval if the dropdown is hidden
        clearInterval(fetchInterval);
        fetchInterval = null; // Reset interval ID
    }
}

// Close the dropdown when clicking outside of it
window.onclick = function (event) {
    if (!event.target.closest('.notification') && !event.target.closest('#notificationDropdown')) {
        const dropdown = document.getElementById("notificationDropdown");
        if (dropdown && dropdown.classList.contains("visible")) {
            dropdown.classList.remove("visible");
            dropdown.classList.add("hidden");

            // Stop fetching notifications if dropdown is closed
            clearInterval(fetchInterval);
            fetchInterval = null; // Reset interval ID
        }
    }
};

// Fetch notifications from the server
function fetchNotifications() {
    $.ajax({
        url: '/Project_SWP/notifications', // Update with your actual servlet URL
        type: 'POST',
        success: function (data) {
            console.log('AJAX response:', data); // Check the response structure
            showNotifications(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error('AJAX request failed:', textStatus, errorThrown);
            const notificationDropdown = document.getElementById('notificationDropdown');
            const dropdownContent = notificationDropdown.querySelector('.dropdown-content');
            dropdownContent.innerHTML = '<p>Failed to load notifications. Please try again later.</p>';
            notificationDropdown.classList.remove('hidden');
            notificationDropdown.classList.add('visible');
        }
    });
}

// Display notifications in the dropdown
function showNotifications(notifications) {
    const notificationDropdown = document.getElementById('notificationDropdown');
    const dropdownContent = notificationDropdown.querySelector('.dropdown-content');
    dropdownContent.innerHTML = ''; // Clear previous notifications

    // Limit to the 5 newest notifications
    const latestNotifications = notifications.slice(0, 5);

    // If no notifications are found, show "No new notifications" message
    if (latestNotifications.length === 0) {
        const noResultsMessage = document.createElement('p');
        noResultsMessage.textContent = 'No new notifications';
        noResultsMessage.style.textAlign = 'center';
        noResultsMessage.style.fontSize = '18px';
        noResultsMessage.style.color = 'gray';
        dropdownContent.appendChild(noResultsMessage);
    } else {
        // Loop through the 5 newest notifications and create list items
        latestNotifications.forEach(notification => {
            const notificationItem = document.createElement('div');
            notificationItem.classList.add('notification-item');
            notificationItem.style.display = 'flex';
            notificationItem.style.alignItems = 'center';
            notificationItem.style.marginBottom = '10px';
            notificationItem.setAttribute('data-id', notification.notificationId);

            // Notification text and timestamp
            const textDiv = document.createElement('div');
            textDiv.classList.add('text');
            textDiv.style.flex = '1';

            const messageP = document.createElement('p');
            messageP.style.fontSize = '15px';
            messageP.style.color = '#333333';

            // Check if the notification is unread (isRead = 0), then bold the text
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

    // Make sure the dropdown is visible
    notificationDropdown.classList.remove('hidden');
    notificationDropdown.classList.add('visible');
}
