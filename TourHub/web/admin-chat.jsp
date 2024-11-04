<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="model.Message"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard Admin</title>
        <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
        <!-- My CSS -->
        <link rel="stylesheet" href="assests/css/style_profile.css"> 
        <link rel="stylesheet" href="assests/css/chat.css"> 
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <%@include file="includes/admin-sidebar.jsp" %>
        <!-- SIDEBAR -->
        <!-- CONTENT -->
        <section id="content">
            <!-- NAVBAR -->
            <%@include file="includes/admin-navbar.jsp" %>
            <main>
                <div class="table-data">
                    <div class="order">
                        <c:choose>
                            <c:when test="${currentUser == null || (currentUser != null && currentUser.role != 'Admin')}">
                                <c:redirect url="home" />
                            </c:when>
                            <c:otherwise>
                                <div class="messenger-container">
                                    <div class="chat-section">
                                        <div id="messageContainer" class="chat-messages">
                                            <!-- Tin nhắn sẽ được hiển thị ở đây -->
                                        </div>
                                        <div id="messageInputContainer" class="chat-input">
                                            <input type="text" id="messageInput" placeholder="Nhập tin nhắn...">
                                            <button id="sendButton" onclick="sendMessage()">Gửi</button>
                                        </div>
                                    </div>

                                    <div class="sidebar">
                                        <div class="chat-list">
                                            <div id="activeUserList">
                                                <!-- Danh sách người dùng đang nhắn tin sẽ được thêm vào đây -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </main>
        </section>
        <script src="assests/js/script_profile.js"></script>
        <script src="assests/js/admin-chat.js"></script>

    </body>
</html>





