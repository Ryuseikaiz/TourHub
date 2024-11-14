var user1, user2;
var receiverId = user1;

function fetchActiveChatUsers() {
    $.ajax({
        url: 'ChatController',
        method: 'GET',
        data: {
            action: 'getChatRooms'
        },
        success: function (data) {
            var userList = $('#activeUserList');
            userList.empty();
            $.each(data, function (index, user) {
                userList.append('<div class="user" onclick="openChat(' + user.user_Id + ')">' + user.first_Name + ' ' + user.last_Name + ' (ID: ' + user.user_Id + ')</div>');
            });
        },
        error: function (xhr, status, error) {
            console.error('Lỗi khi lấy dữ liệu:', error);
        }
    });
}

function fetchAdminChat() {
    $.ajax({
        url: 'ChatController?action=getAdminRoom',
        method: 'GET',
        success: function (data) {
            var userList = $('#activeAdmin');
            userList.empty();
            $.each(data, function (index, user) {
                userList.append('<div class="user" onclick="openChat(' + user.user_Id + ')">' + user.first_Name + ' ' + user.last_Name + '</div>');
            });
        },
        error: function (xhr, status, error) {
            console.error('Lỗi khi lấy dữ liệu:', error);
        }
    });
}

function openChat(userId) {
    currentUserId = userId;
    receiverId = userId;
    user1 = currentUserId; // Gán user1 là currentUserId
    user2 = receiverId; // Gán user2 là receiverId
    fetchChatMessages(userId);
}

function fetchChatMessages(userId) {
    console.log("Đang lấy tin nhắn cho userId:", userId);
    $.ajax({
        url: 'ChatController',
        method: 'GET',
        data: {
            userId: userId,
            action: 'getChatMessages'
        },
        success: function (messages) {
            var messageContainer = $('#messageContainer');
            messageContainer.empty(); // Xóa nội dung cũ

            // Thêm tin nhắn vào container
            $.each(messages, function (index, message) {
                user1 = message.senderId;
                user2 = message.receiverId;

                // Kiểm tra người gửi
                var messageClass = message.senderId === currentUserId ? 'message mine' : 'message theirs';
                messageContainer.append('<div class="' + messageClass + '">' + message.messageText + '</div>');
            });

            // Tự động cuộn xuống cuối mỗi lần có tin nhắn mới
            messageContainer.scrollTop(messageContainer[0].scrollHeight);
        },

        error: function (xhr, status, error) {
            console.error('Lỗi khi lấy tin nhắn:', error);
        }
    });
}


$(document).ready(function() {
    // Sự kiện nhấn Enter để gửi tin nhắn
    $('#messageInput').on('keypress', function(event) {
        if (event.which === 13) { // Kiểm tra nếu phím nhấn là Enter (keyCode 13)
            event.preventDefault(); // Ngăn không cho gửi form nếu người dùng nhấn Enter
            sendMessage(); // Gọi hàm gửi tin nhắn
        }
    });
});

function sendMessage() {
    var messageText = $('#messageInput').val(); // Lấy nội dung tin nhắn
    if (messageText.trim() === '') {
        alert('Vui lòng nhập tin nhắn.');
        return;
    }

    $.ajax({
        url: 'ChatController', // Điều chỉnh URL tới servlet mới
        method: 'GET',
        data: {
            senderId: user1,
            receiverId: user2,
            messageText: messageText,
            action: 'sendMessage'
        },
        success: function (response) {
            $('#messageInput').val(''); // Xóa ô nhập liệu
            fetchChatMessages(currentUserId); // Tải lại tin nhắn
        },
        error: function (xhr, status, error) {
            console.error('Lỗi khi gửi tin nhắn:', error);
            alert('Đã có lỗi khi gửi tin nhắn. Vui lòng thử lại.');
        }
    });
}

// Gọi hàm fetchActiveChatUsers mỗi 5 giây
setInterval(function () {
    fetchActiveChatUsers();
}, 2000);

setInterval(function () {
    fetchAdminChat();
}, 2000);

setInterval(function () {
    fetchChatMessages(receiverId);
}, 3000);
