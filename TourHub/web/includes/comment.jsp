<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Comment" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Tour Comments</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

        <style>
            .comment-section {
                width: 100%;
                max-width: 700px;
                margin: 20px auto;
                padding: 15px;
            }
            .comment-item {
                background-color: #f0f2f5;
                padding: 10px;
                border-radius: 10px;
                margin-bottom: 15px;
                border: 1px solid #ddd;
                position: relative;
            }
            .reply-item {
                margin-left: 50px;
                background-color: #ffffff;
                padding: 10px;
                border-radius: 8px;
                margin-bottom: 10px;
                border: 1px solid #ddd;
                position: relative;
            }
            .reply-item::before {
                content: '';
                position: absolute;
                left: -30px;
                top: 0;
                bottom: 0;
                width: 2px;
                background-color: #ddd;
            }
            .comment-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: #ddd;
                margin-right: 10px;
            }
            .comment-body {
                flex: 1;
            }
            .comment-header {
                font-weight: bold;
                margin-bottom: 5px;
                font-size: 14px;
                text-align: left;
            }
            .comment-text {
                font-size: 14px;
                margin-bottom: 10px;
                text-align: left;
            }
            .reply-btn, .edit-btn, .delete-btn {
                font-size: 12px;
                color: #007bff;
                cursor: pointer;
                display: inline-block;
                margin-top: 5px;
                margin-right: 10px;
            }
            .reply-input, .edit-input {
                margin-top: 10px;
                display: none;
            }
            .reply-input textarea, .edit-input textarea {
                width: 100%;
                height: 60px;
                margin-bottom: 10px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }
            .submit-btn {
                background-color: #1877f2;
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 5px;
                font-size: 14px;
                cursor: pointer;
            }
            .submit-btn:hover {
                background-color: #145dbf;
            }
            .no-comment {
                text-align: center;
                margin-bottom: 20px;
                font-size: 14px;
                color: #888;
            }
            .comment-divider {
                height: 1px;
                background-color: #ccc;
                margin: 10px 0;
            }
            .comment-header {
                position: relative;
                font-weight: bold;
                margin-bottom: 5px;
                font-size: 14px;
                text-align: left;
            }

            .icon-actions {
                position: absolute;
                top: 0;
                right: 0;
            }

            .edit-icon, .delete-icon {
                color: #007bff;
                cursor: pointer;
                margin-left: 10px;
            }

            .edit-icon:hover, .delete-icon:hover {
                color: #0056b3;
            }

        </style>
    </head>
    <body>
        <div class="comment-section">
            <c:choose>
                <c:when test="${empty comments}">
                    <div class="no-comment">No comments yet. Be the first to comment!</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="comment" items="${comments}">
                        <c:if test="${comment.parentCommentId == null}">
                            <div class="comment-item" id="comment-${comment.commentId}">
                                <div class="d-flex">
                                    <div class="comment-avatar">
                                        <img src="${comment.avatar}" alt="Avatar" style="width: 40px; height: 40px; border-radius: 50%;">
                                    </div>
                                    <div class="comment-body">
                                        <div class="comment-header">
                                            ${comment.firstName} ${comment.lastName}
                                            <span class="text-muted" style="font-size: 12px;">
                                                - <fmt:formatDate value="${comment.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                            </span>
                                            <!-- Nút Edit và Delete icon ở góc phải -->
                                            <div class="icon-actions">
                                                <c:if test="${currentUserId != -1 && comment.userId == currentUserId}">
                                                    <i class="fas fa-edit edit-icon" onclick="showEditForm(${comment.commentId})"></i>
                                                    <i class="fas fa-trash delete-icon" onclick="deleteComment(${comment.commentId})"></i>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div id="commentText-${comment.commentId}" class="comment-text">${comment.commentText}</div>

                                        <!-- Nút Reply và form trả lời -->
                                        <c:if test="${currentUserId != -1}">
                                            <div class="reply-btn" onclick="showReplyForm(${comment.commentId})">Reply</div>
                                        </c:if>
                                        <div id="replyForm-${comment.commentId}" class="reply-input" style="display:none;">
                                            <textarea id="replyText-${comment.commentId}" placeholder="Write your reply..."></textarea>
                                            <button class="submit-btn" onclick="submitReply('${tourId}', ${comment.commentId})">Submit Reply</button>
                                        </div>
                                        <div id="editForm-${comment.commentId}" class="edit-input" style="display:none;">
                                            <textarea id="editText-${comment.commentId}">${comment.commentText}</textarea>
                                            <button class="submit-btn" onclick="submitEdit(${comment.commentId})">Save</button>
                                            <button class="submit-btn" onclick="cancelEdit(${comment.commentId})">Cancel</button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Hiển thị reply cho comment này -->
                                <c:forEach var="reply" items="${comments}">
                                    <c:if test="${reply.parentCommentId == comment.commentId}">
                                        <div class="reply-item d-flex" id="comment-${reply.commentId}">
                                            <div class="comment-avatar">
                                                <img src="${reply.avatar}" alt="Avatar" style="width: 40px; height: 40px; border-radius: 50%;">
                                            </div>
                                            <div class="comment-body">
                                                <div class="comment-header">
                                                    ${reply.firstName} ${reply.lastName}
                                                    <span class="text-muted" style="font-size: 12px;">
                                                        - <fmt:formatDate value="${reply.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                                    </span>
                                                    <!-- Nút Edit và Delete icon cho reply ở góc phải -->
                                                    <div class="icon-actions">
                                                        <c:if test="${currentUserId != -1 && reply.userId == currentUserId}">
                                                            <i class="fas fa-edit edit-icon" onclick="showEditForm(${reply.commentId})"></i>
                                                            <i class="fas fa-trash delete-icon" onclick="deleteComment(${reply.commentId})"></i>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div id="commentText-${reply.commentId}" class="comment-text">${reply.commentText}</div>

                                                <!-- Form chỉnh sửa cho reply -->
                                                <div id="editForm-${reply.commentId}" class="edit-input" style="display:none;">
                                                    <textarea id="editText-${reply.commentId}">${reply.commentText}</textarea>
                                                    <button class="submit-btn" onclick="submitEdit(${reply.commentId})">Save</button>
                                                    <button class="submit-btn" onclick="cancelEdit(${reply.commentId})">Cancel</button>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <div class="comment-divider"></div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

            <!-- Form nhập bình luận mới, chỉ hiển thị khi người dùng đã đăng nhập -->
            <c:if test="${not empty sessionScope.currentUser}">
                <div class="comment-item">
                    <div class="d-flex">
                        <div class="comment-avatar">
                            <!-- Lấy avatar của người dùng hiện tại từ session -->
                            <img src="${sessionScope.currentUser.avatar}" alt="Avatar" style="width: 40px; height: 40px; border-radius: 50%;">
                        </div>
                        <div class="comment-body">
                            <textarea id="newCommentText" placeholder="Write your comment..." rows="3" class="form-control"></textarea>
                            <button class="submit-btn mt-2" onclick="submitComment('${tourId}')">Submit Comment</button>
                        </div>
                    </div>
                </div>
            </c:if>

        </div>

        <script>
            function showReplyForm(commentId) {
                document.getElementById('replyForm-' + commentId).style.display = 'block';
            }

            function showEditForm(commentId) {
                document.getElementById('editForm-' + commentId).style.display = 'block';
            }

            function cancelEdit(commentId) {
                document.getElementById('editForm-' + commentId).style.display = 'none';
            }

            function submitEdit(commentId) {
                // Lấy nội dung mới từ ô nhập liệu và loại bỏ khoảng trắng thừa
                var newText = document.getElementById('editText-' + commentId).value.trim();

                // Kiểm tra xem nội dung mới không rỗng
                if (newText !== '') {
                    fetch('CommentServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: 'action=edit&commentId=' + encodeURIComponent(commentId) + '&commentText=' + encodeURIComponent(newText)
                    })
                            .then(response => response.text())
                            .then(result => {
                                if (result.trim() === "Success") {
                                    // Reload lại trang sau khi chỉnh sửa thành công
                                    location.reload();
                                } else {
                                    alert('Error editing comment.'); // Thông báo lỗi nếu không thành công
                                }
                            })
                            .catch(error => {
                                console.error('Error editing comment:', error); // Ghi log lỗi nếu có sự cố với request
                            });
                } else {
                    alert('Please enter text for the comment.'); // Thông báo nếu người dùng để trống nội dung
                }
            }



            function deleteComment(commentId) {
                if (confirm('Are you sure you want to delete this comment?')) {
                    fetch('CommentServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: 'action=delete&commentId=' + encodeURIComponent(commentId)
                    }).then(response => response.text())
                            .then(result => {
                                if (result.trim() === "Success") {
                                    document.getElementById('comment-' + commentId).remove();
                                } else {
                                    alert('Error deleting comment.');
                                }
                            }).catch(error => {
                        console.error('Error deleting comment:', error);
                    });
                }
            }

            function submitReply(tourId, parentCommentId) {
                var replyText = document.getElementById('replyText-' + parentCommentId).value;

                if (replyText.trim() !== '') {
                    fetch('CommentServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: 'action=add&commentText=' + encodeURIComponent(replyText) +
                                '&tourId=' + encodeURIComponent(tourId) +
                                '&parentCommentId=' + encodeURIComponent(parentCommentId)
                    }).then(response => response.text())
                            .then(result => {
                                if (result.trim() === "Success") {
                                    location.reload();  // Tải lại trang để hiển thị trả lời mới
                                } else {
                                    alert('Error submitting reply.');
                                }
                            }).catch(error => {
                        console.error('Error submitting reply:', error);
                    });
                } else {
                    alert('Please enter a reply');
                }
            }

            function submitComment(tourId) {
                var commentText = document.getElementById('newCommentText').value;

                if (commentText.trim() !== '') {
                    fetch('CommentServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: 'action=add&commentText=' + encodeURIComponent(commentText) + '&tourId=' + encodeURIComponent(tourId)
                    }).then(response => response.text())
                            .then(result => {
                                if (result.trim() === "Success") {
                                    location.reload();  // Tải lại trang để hiển thị bình luận mới
                                } else {
                                    alert('Error submitting comment.');
                                }
                            }).catch(error => {
                        console.error('Error submitting comment:', error);
                    });
                } else {
                    alert('Please enter a comment');
                }
            }

        </script>
    </body>
</html>
