<section id="sidebar">
    <a href="home" class="brand">
        <i class='bx bxs-smile'></i>
        <span class="text">TourHub</span>
    </a>
    <ul class="side-menu top">
        <li>
            <a href="user">
                <i class='bx bxs-dashboard' ></i>
                <span class="text">User Information</span>
            </a>
        </li>
        <c:if test="${sessionScope.currentUser.role == 'Customer'}">
            <li>
                <a href="booking">
                    <i class='bx bxs-shopping-bag-alt' ></i>
                    <span class="text">My Booking</span>
                </a>
            </li>
            <li>

                <a href="wishlist">
                    <i class='bx bxs-dashboard' ></i>
                    <span class="text">My wishlist tour</span>
                </a>
            </li>

            <li>
                <a href="SubmitReview">
                    <i class='bx bxs-star'></i>
                    <span class="text">Review Tours</span>
                </a>
            </li>
        </c:if>   
        <c:if test="${sessionScope.currentUser.role == 'Provider'}">
            <li>
                <a href="pending-bookings">
                    <i class='bx bxs-shopping-bag-alt' ></i>
                    <span class="text">Manage Booking</span>
                </a>
            </li>
            <li class="">
                <a href="${sessionScope.currentUser.role == 'Provider' ? 'provider-analys' : 'admin-analysis.jsp'}">
                    <i class='bx bxs-dashboard' ></i>
                    <span class="text">Dashboard</span>
                </a>
            </li>   
            <li class="dropdown-btn">
                <a href="my-tour">
                    <i class='bx bxs-briefcase-alt' ></i>
                    <span class="text">My Tour</span>
                </a>
            </li>   
            <li>
                <a href="provider-management?action=show-withdraw-page">
                    <i class='bx bxs-credit-card'></i>
                    <span class="text">Widthdraw</span>
                </a>
            </li> 
            <li>
                <a href="discount">
                    <i class='bx bxs-discount'></i>
                    <span class="text">Manage Discounts</span>
                </a>
            </li>
        </c:if>
        <li>
            <a href="notifications">
                <i class='bx bxs-dashboard' ></i>
                <span class="text">Notification</span>
            </a>
        </li>
        <li>
            <a href="user-chat.jsp">
                <i class='bx bxs-message-dots' ></i>
                <span class="text">Message</span>
            </a>
        </li> 
    </ul>
    <ul class="side-menu">
        <li>
            <a href="#">
                <i class='bx bxs-cog' ></i>
                <span class="text">Settings</span>
            </a>
        </li>
        <li>
            <a href="logout" class="logout">
                <i class='bx bxs-log-out-circle' ></i>
                <span class="text">Logout</span>
            </a>
        </li>
    </ul>
</section>