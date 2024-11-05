<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html class="wide wow-animation" lang="en">
    <head>
        <!-- Site Title-->
        <title>Home</title>
        <meta name="format-detection" content="telephone=no" />
        <meta
            name="viewport"
            content="width=device-width, height=device-height, initial-scale=1.0"
            />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta charset="utf-8" />
        <link
            rel="icon"
            href="assests/images/logo-favicon/logo.png"
            type="image/x-icon"
            />
        <!-- Stylesheets -->
        <link
            rel="stylesheet"
            type="text/css"
            href="//fonts.googleapis.com/css?family=Oswald:200,400%7CLato:300,400,300italic,700%7CMontserrat:900"
            />
        <link rel="stylesheet" href="assests/css/bootstrap.css" />
        <link rel="stylesheet" href="assests/css/style.css" />
        <link rel="stylesheet" href="assests/css/fonts.css" />
        <link rel="stylesheet" href="assests/css/index.css" />
        <link rel="stylesheet" href="assests/css/tour-pay.css" />

        <!-- Owl Carousel CSS -->
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css"
            />

        <!-- jQuery (required for Owl Carousel) -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

        <!-- Owl Carousel JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>

        <!-- Font Awesome -->
        <script
            src="https://kit.fontawesome.com/d14313468c.js"
            crossorigin="anonymous"
        ></script>

        <!-- Bootstrap CSS -->
        <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.2/css/bootstrap.min.css'>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js'></script> 
        <script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.2.0/js/bootstrap.min.js'></script>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
            />

        <!-- Flatpickr CSS -->
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css"
            />

    </head>
</html>


<body class="search-page">
    <!-- Page-->
    <div class="page-loader"> 
        <div class="page-loader-body"> 
            <div class="preloader-wrapper big active"> 
                <div class="spinner-layer spinner-blue"> 
                    <div class="circle-clipper left">
                        <div class="circle"> </div>
                    </div>
                    <div class="gap-patch">
                        <div class="circle"> </div>
                    </div>
                    <div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                </div>
                <div class="spinner-layer spinner-red">
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div>
                    <div class="gap-patch">
                        <div class="circle"> </div>
                    </div>
                    <div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                </div>
                <div class="spinner-layer spinner-yellow"> 
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div>
                    <div class="gap-patch">
                        <div class="circle"></div>
                    </div>
                    <div class="circle-clipper right">
                        <div class="circle"> </div>
                    </div>
                </div>
                <div class="spinner-layer spinner-green"> 
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div>
                    <div class="gap-patch">
                        <div class="circle"></div>
                    </div>
                    <div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="page">
        <!-- Page Header-->
        <header class="section page-header">
            <!-- RD Navbar-->
            <div class="rd-navbar-wrap rd-navbar-corporate">
                <nav class="rd-navbar" data-layout="rd-navbar-fixed" data-sm-layout="rd-navbar-fixed" data-md-layout="rd-navbar-fixed" data-md-device-layout="rd-navbar-fixed" data-lg-layout="rd-navbar-fullwidth" data-xl-layout="rd-navbar-static" data-lg-device-layout="rd-navbar-fixed" data-xl-device-layout="rd-navbar-static" data-md-stick-up-offset="130px" data-lg-stick-up-offset="100px" data-stick-up="true" data-sm-stick-up="true" data-md-stick-up="true" data-lg-stick-up="true" data-xl-stick-up="true">
                    <div class="rd-navbar-collapse-toggle" data-rd-navbar-toggle=".rd-navbar-collapse"><span></span></div>
                    <div class="rd-navbar-top-panel rd-navbar-collapse novi-background">
                        <div class="rd-navbar-top-panel-inner">
                            <ul class="list-inline">
                                <li class="box-inline list-inline-item"><span class="icon novi-icon icon-md-smaller icon-secondary mdi mdi-phone"></span>
                                    <ul class="list-comma">
                                        <li><a href="tel:#">1-800-1234-567</a></li>
                                        <li><a href="tel:#">1-800-6780-345</a></li>
                                    </ul>
                                </li>
                                <li class="box-inline list-inline-item"><span class="icon novi-icon icon-md-smaller icon-secondary mdi mdi-map-marker"></span><a href="#">2130 Fulton Street, San Diego, CA 94117-1080 USA</a></li>
                                <li class="box-inline list-inline-item"><span class="icon novi-icon icon-md-smaller icon-secondary mdi mdi-email"></span><a href="mailto:#">mail@demolink.org</a></li>
                            </ul>
                            <ul class="list-inline">
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-facebook" href="#"></a></li>
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-twitter" href="#"></a></li>
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-instagram" href="#"></a></li>
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-google-plus" href="#"></a></li>
                                <li class="list-inline-item"><a class="icon novi-icon icon-sm-bigger icon-gray-1 mdi mdi-linkedin" href="#"></a></li>
                            </ul>
                        </div>
                        <div class="rd-navbar-top-panel-inner"></div>
                    </div>
                    <div class="rd-navbar-inner">
                        <!-- RD Navbar Panel-->
                        <div class="rd-navbar-panel">
                            <!-- RD Navbar Toggle-->
                            <button class="rd-navbar-toggle" data-rd-navbar-toggle=".rd-navbar-nav-wrap"><span></span></button>
                            <!-- RD Navbar Brand-->
                            <div class="rd-navbar-brand"><a class="brand-name" href="home"><img class="logo-default" src="assests/images/logo-favicon/logo.png" alt="" width="208" height="46"/><img class="logo-inverse" src="assests/images/logo-inverse-208x46.png" alt="" width="208" height="46"/></a></div>
                        </div>
                        <div class="rd-navbar-aside-center">
                            <div class="rd-navbar-nav-wrap">
                                <!-- RD Navbar Nav-->
                                <ul class="rd-navbar-nav">
                                    <li><a href="home">Home</a>
                                    </li>
                                    <li><a href="about-us.jsp">About Us</a>
                                    </li>
                                    <li><a href="contacts.jsp">Contacts</a>
                                    </li>
                                    <li><a href="typography.jsp">Typography</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="rd-navbar-aside-right"><a class="button button-sm button-secondary button-nina" href="#">Book a tour now</a></div>
                    </div>
                </nav>
            </div>
        </header>
        <!--Page content-->
        <div class="main-container-wrapper">
            <div class="main-container">
                <div class="display-qr">
                    <div class="display-qr-heading">
                        <div class="display-qr-title">
                            Scan QR
                        </div>

                        <div class="display-qr-container">
                            <a class="btn btn-primary" data-bs-toggle="collapse" href="#collapseQR" role="button"
                               aria-expanded="true" aria-controls="collapseQR"
                               style="color: black; background-color: transparent; border: none;">
                                <i class="fa-solid fa-chevron-down"></i>
                            </a>
                        </div>
                    </div>

                    <!-- Add the 'show' class to make it open by default -->
                    <div class="collapse show" id="collapseQR" style="border-top: solid 1px rgba(197, 197, 197, 0.726);">
                        <div class="card card-body" style="border: none; padding: 15px 0px;">
                            <div class="tour-qr-container">
                                <div class="tour-qr">
                                    <img class="tour-qr-img" src="" alt="">
                                    <span class="paid-content-container">
                                        Transfer content:
                                        <span id="paid-content"></span>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="display-banking">
                    <div class="display-banking-heading">
                        <div class="display-banking-title">
                            Online banking MBBank
                        </div>

                        <div class="display-banking-container">
                            <a class="btn btn-primary" data-bs-toggle="collapse" href="#collapseBK" role="button"
                               aria-expanded="false" aria-controls="collapseBK"
                               style="color: black; background-color: transparent; border: none;">
                                <img class="logo-mb" src="assests/images/logo-favicon/Logo MB Bank - MBB.png" alt="">
                                <i class="fa-solid fa-chevron-down"></i>
                            </a>
                        </div>
                    </div>

                    <!-- Removed 'show' class to keep it collapsed by default -->
                    <div class="collapse" id="collapseBK" style="border-top: solid 1px rgba(197, 197, 197, 0.726);">
                        <div class="card card-body" style="border: none; padding: 15px 0px;">
                            <div class="banking-details">
                                <div class="detail-item">
                                    <span>Bank account number:</span>
                                    <span class="value">0000871278620</span>
                                </div>
                                <div class="detail-item">
                                    <span>Bank account name:</span>
                                    <span class="value">NGUYEN DOAN TRONG DUC</span>
                                </div>
                                <div class="detail-item">
                                    <span>Total cost:</span>
                                    <span class="value amount">${book.total_Cost}</span>
                                </div>
                                <div class="detail-item">
                                    <span>Transfer content:</span>
                                    <span class="value amount1"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="total-cost-overview">
                    <div class="total-cost-heading">
                        <div class="pay-title">
                            Total cost
                        </div>

                        <div class="total-cost-container">
                            <span class="total-cost">
                                ${book.total_Cost}
                            </span>

                            <a class="btn btn-primary" data-bs-toggle="collapse" href="#collapseExample"
                               role="button" aria-expanded="false" aria-controls="collapseExample"
                               style="color: black; background-color: transparent; border: none;">
                                <i class="fa-solid fa-chevron-down"></i>
                            </a>
                        </div>
                    </div>               

                    <div class="collapse" id="collapseExample" style="border-top: solid 1px rgba(197, 197, 197, 0.726);">
                        <div class="card card-body" style="border: none; padding: 15px 0px;">
                            <div class="detail-price-container">
                                <div class="detal-price-name">

                                </div>

                                <div class="detail-price" style="text-align: end;">

                                </div>
                            </div>
                            <div class="detail-discount-container" style="display: flex; justify-content: space-between; align-items: center;">
                                <div class="detal-price-name" style="font-size: 17px; font-weight: 600; color: black;">Total</div>
                                <div class="detail-price" style="font-size: 17px; font-weight: 700; color: #FF5E1F; text-align: end;">${totalNoDis} VND</div>
                            </div>
                            
                            <div class="detail-discount-container" style="display: flex; justify-content: space-between; align-items: center; padding-bottom: 10px;">
                                <div class="detal-price-name">Discount</div>
                                <div class="detail-price" style="text-align: end">${discountCost}</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="continue-btn-conatiner">
                    <button class="continue-btn">Complete Payment</button>
                </div>

                <div class="modal fade" id="statusSuccessModal" tabindex="-1" role="dialog" data-bs-backdrop="static" data-bs-keyboard="false"> 
                    <div class="modal-dialog modal-dialog-centered modal-sm" role="document"> 
                        <div class="modal-content"> 
                            <div class="modal-body text-center p-lg-4"> 
                                <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 130.2 130.2">
                                <circle class="path circle" fill="none" stroke="#198754" stroke-width="6" stroke-miterlimit="10" cx="65.1" cy="65.1" r="62.1" />
                                <polyline class="path check" fill="none" stroke="#198754" stroke-width="6" stroke-linecap="round" stroke-miterlimit="10" points="100.2,40.2 51.5,88.8 29.8,67.5 " /> 
                                </svg> 
                                <h4 class="text-success mt-3">Payment Complete!</h4> 
                                <p class="mt-3">You have successfully book a tour.</p>
                                <button type="button" class="btn btn-sm mt-3 btn-success" data-bs-dismiss="modal" onclick="window.location.href='FinishBooking?id=${book.book_Id}'">Ok</button> 
                            </div> 
                        </div> 
                    </div> 
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let MY_BANK = {
                BANK_ID: "MB",
                ACCOUNT_NO: "0000871278620"
            };

            // Set to store used booking IDs
            let usedBookingIds = new Set();

            function generateUniqueBookingId() {
                let newId;
                do {
                    newId = Math.floor(100000 + Math.random() * 900000); // Generate a 6-digit number
                } while (usedBookingIds.has(newId)); // Repeat if ID is already used

                usedBookingIds.add(newId); // Store the new unique ID
                return "BK" + newId;
            }

            var bookingId = generateUniqueBookingId();
            var bookingCost = "${book.total_Cost}";

            console.log("Unique Booking ID:", bookingId);
            console.log("Booking Cost:", bookingCost);

            const paidContent = bookingId;
            const paidPrice = bookingCost;

            const paid_content = document.getElementById("paid-content");
            const qr_img = document.querySelector(".tour-qr-img");
            
            const amountSpan = document.querySelector(".value.amount1");
            amountSpan.innerHTML = paidContent;

            let QR = "https://img.vietqr.io/image/" + MY_BANK.BANK_ID + "-" + MY_BANK.ACCOUNT_NO + "-compact2.jpg?amount=" + paidPrice + "&addInfo=" + paidContent;
            qr_img.src = QR;
            paid_content.innerHTML = paidContent;

            setTimeout(() => {
                checkInterval = setInterval(() => {
                    checkPaid(paidPrice, paidContent);
                }, 1000);
            }, 10000);
        });

        let isSuccess = false;
        let checkInterval = null;

        async function checkPaid(price, content) {
            if (isSuccess) {
                return;
            }

            try {
                const response = await fetch("https://script.google.com/macros/s/AKfycbzUZ3aGbGOZsAgwgGaRreU4HM0F8fi9RoQZnUE-TWCOYX0sWymFkSlfW_ZA73iV5GCQ/exec");
                const data = await response.json();
                const lastPaid = data.data[data.data.length - 1];

                const lastPrice = lastPaid["Giá trị"];
                const lastContent = lastPaid["Mô tả"];

                console.log(lastPrice);
                console.log(lastContent);
                console.log(content);

                if (lastPrice >= price && lastContent.includes(content)) {
                    isSuccess = true;
                    clearInterval(checkInterval);

                    const paymentSuccessModal = new bootstrap.Modal(document.getElementById('statusSuccessModal'));
                    paymentSuccessModal.show();
                } else {
                    console.log("Payment not successful yet.");
                }
            } catch (error) {
                console.error("Error occurred during payment check:", error);
            }
        }
    </script>

    <script>
        // Giả sử booking_Detail có dạng như sau:
        var bookingDetail = "${book.booking_Detail}";

        console.log(bookingDetail);

        // Tách chuỗi thành mảng các phần tử bằng dấu chấm phẩy
        var detailsArray = bookingDetail.split(";");

        // Lấy các thẻ div tương ứng
        var nameContainer = document.querySelector('.detal-price-name');
        var priceContainer = document.querySelector('.detail-price');

        // Xóa nội dung cũ trong các container
        nameContainer.innerHTML = "";
        priceContainer.innerHTML = "";

        // Lặp qua từng phần tử của mảng
        for (var i = 0; i < detailsArray.length; i++) {
            if (i % 2 === 0) {
                // Nếu i là chẵn, thêm tên vào detal-price-name
                nameContainer.innerHTML += detailsArray[i] + "<br>";
            } else {
                // Nếu i là lẻ, thêm giá vào detail-price
                priceContainer.innerHTML += detailsArray[i] + "<br>";
            }
        }
    </script>
</body>

<%@include file="includes/footer.jsp" %>    