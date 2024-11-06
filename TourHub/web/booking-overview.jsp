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
        <link rel="stylesheet" href="assests/css/booking-overview.css" />

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
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
            crossorigin="anonymous"
            />
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
                        <div class="title-container">
                            <span class="title">
                                My booking
                            </span>
                            <br>
                            <span class="sub-title">
                                Fill in the information and review the reservation
                            </span>
                        </div>

                        <div class="body-container">
                            <div class="forms-container">
<!--                                <div class="invite-login-container">
                                    <div class="invite-login-img">
                                        <img src="Image/login-invite.png" alt="">
                                    </div>

                                    <div class="invite-login-text">
                                        <span class="invite-login-title">
                                            Đăng nhập hoặc Đăng ký và tận hưởng ưu đãi dành riêng cho thành viên
                                        </span>

                                        <span class="invite-login-sub">
                                            Đặt chỗ nhanh và dễ dàng hơn với Passenger Quick Pick
                                        </span>

                                        <span class="invite-login-sub">
                                            Tiết kiệm tới 8% với mã phiếu giảm giá TRAVELOKALANNGOC cho lần mua hàng đầu tiên của bạn
                                        </span>

                                        <a href="" class="invite-login-link">Đăng nhập hoặc đăng kí</a>
                                    </div>
                                </div>-->

                                <div class="contact-information">
                                    <div class="contact-information-title">
                                        Contact Information
                                    </div>

                                    <div class="contact-information-form">
                                        <div class="contact-information-form-title">
                                            Contact Information (receive ticket/Bill)
                                        </div>

                                        <form class="inner-contact-information-form" action="CustomerInformation">
                                            <div class="form-group">
                                                <label for="fullname">Full Name*</label>
                                                <input type="text" id="fullname" name="fullname" placeholder="Similar to CCCD" required>
                                            </div>

                                            <div class="form-group phone-group">
                                                <select class="country-code" id="country-code">
                                                    <option value="+84">+84 🇻🇳</option>
                                                    <!-- Add more country codes here -->
                                                </select>
                                                <input type="tel" id="phone" name="phone" placeholder="VD: 901234567" required>
                                            </div>

                                            <div class="form-group">
                                                <label for="email">Email*</label>
                                                <input type="email" id="email" name="email" placeholder="VD: email@example.com" required>
                                            </div>

                                            <div class="radio-group">
                                                <label>
                                                    <input type="radio" name="visitorType" value="self" checked> I'm a visitor
                                                </label>
                                                <label>
                                                    <input type="radio" name="visitorType" value="other"> I book for another
                                                </label>
                                            </div>

                                            <!-- Input hidden để truyền bookId -->
                                            <input type="hidden" id="bookId" name="bookId" value="${book.book_Id}">
                                            <input type="hidden" id="discountCost" name="discountCost" value="${discountCost}">
                                            <input type="hidden" id="totalNoDis" name="totalNoDis" value="${totalNoDis}">
                                            <input type="hidden" id="discountId" name="discountId" value="${discountId}">

                                            <input type="submit" value="SAVE" id="saveBtn" style="display: none;"/>
                                        </form>
                                    </div>
                                </div>

                                <div class="guest-infomation">
                                    <span class="guest-information-title">
                                        Visitor Information
                                    </span>

                                    <div class="guest-information-form">
                                        <div class="guest-information-form-title">
                                            Adult 1
                                        </div>

                                        <form class="inner-guest-information-form">
                                            <label for="fullname">Title*</label>
                                            <select class="person-title">
                                                <option value=""></option>
                                                <option value="Mr.">Mr.</option>
                                                <option value="Mrs.">Mrs.</option>
                                            </select>

                                            <div class="form-group">
                                                <label for="fullname">Full Name*</label>
                                                <input type="text" id="fullname" name="fullname" placeholder="Similar to CCCD"
                                                       required>
                                            </div>

                                            <div class="form-group phone-group">
                                                <select class="country-code">
                                                    <option value="+84">+84 🇻🇳</option>
                                                    <!-- Add more country codes here -->
                                                </select>
                                                <input type="tel" id="phone" name="phone" placeholder="VD: 901234567" required>
                                            </div>

                                            <div class="form-group">
                                                <label for="email">Email*</label>
                                                <input type="email" id="email" name="email" placeholder="VD: email@example.com"
                                                       required>
                                            </div>

                                            <!-- <div class="form-actions">
                                                <button type="submit">Lưu</button>
                                            </div> -->
                                        </form>
                                    </div>

                                    <div class="additional-infomation">
                                        <div class="additional-infomation-title">
                                            Additional Information
                                        </div>

                                        <div class="form-group additional-form-group">
                                            <label for="fullname">Please provide your contact number *</label>
                                            <input type="text" id="fullname" name="fullname"
                                                   placeholder="Please include your number’s country code (e.g. 0084-903-456-789)"
                                                   required>
                                        </div>
                                    </div>

                                    <div class="additional-request">
                                        <div class="additional-infomation-title">
                                            Additional Request (Optional)
                                        </div>

                                        <div class="form-group additional-form-group">
                                            <input class="request-input" type="text" id="fullname" name="fullname"
                                                   placeholder="Special Request" required>
                                            <label class="request-format">Format: in English or local language at destination.
                                                Requirements subject to the actual situation of the supplier.</label>
                                        </div>
                                    </div>
                                </div>



                                <div class="pickup-location">
                                    <div class="pickup-location-title">
                                        Pickup & drop off information
                                    </div>

                                    <div class="map">

                                    </div>
                                </div>

                                <div class="total-cost-overview-container">
                                    <div class="total-cost-overview-title">
                                        Summary
                                    </div>

                                    <div class="total-cost-overview">
                                        <div class="total-cost-heading">
                                            <div class="pay-title">
                                                You must pay
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

                                                    <div class="detail-price" style="text-align: end">

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
                                        <button class="continue-btn"  type="button">Continue</button>
                                    </div>
                                </div>
                            </div>

                            <div class="booking-overview-container">
                                <span class="booking-overview-title">Tóm tắt đặt chỗ</span>

                                <div class="option-container">
                                    <div class="option-img">
                                        <img src="${book.tour_Img.get(0)}" alt="">
                                    </div>

                                    <div class="option-name-container">
                                        <span class="option-title">${book.tour_Name}</span>
                                        <br>
                                        <span class="option-description">${book.option_Name}</span>
                                    </div>
                                </div>

                                <div class="option-detail-information-container">
                                    <span class="visit-title">
                                        Ngày tham quan: <span class="visit-date">${book.tour_Date}</span>
                                    </span>
                                    <br>
                                    <span class="include-title">
                                        Bao gồm:
                                        <span class="include">
                                            <ul>
                                                <li>Vé vào cổng + Bữa trưa buffet kiểu Việt cho Người lớn: 6</li>
                                                <li>Xe minivan : 1</li>
                                                <li>Vé vào cổng + Bữa trưa buffet kiểu Việt cho Trẻ em: 1</li>
                                                <li>Hướng dẫn viên tiếng Việt/Anh: 1</li>
                                            </ul>
                                        </span>
                                    </span>
                                </div>

                                <div class="option-time-container">
                                    <div class="begin-date-container">
                                        <span>
                                            Có hiệu lực vào <span>${book.tour_Date}</span>
                                        </span>
                                    </div>

                                    <span class="pre-book">
                                        Không cần đặt chỗ trước
                                    </span>

                                    <span class="refundable">
                                        Có thể hoàn tiền cho đến 12 thg 10 2024
                                    </span>
                                </div>

                                <span class="view-more-detail">
                                    Để biết thêm chi tiết của vé này,
                                    <a href="">vui lòng xem tại đây</a>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
    </script>

    <script>
          document.querySelector('.continue-btn').addEventListener('click', function() {
            document.getElementById('saveBtn').click();
          });
          
          document.getElementById('fullname').value = `${user.first_Name} ${user.last_Name}`;
          document.getElementById('phone').value = `${user.phone}`;
          document.getElementById('email').value = `${user.email}`;
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

    <script>
        // Lấy phần tử form và nút continue
        var continueBtn = document.querySelector('.continue-btn');

        // Lắng nghe sự kiện click trên nút "Tiếp tục"
        continueBtn.addEventListener('click', function (event) {
            // Ngăn chặn việc gửi form ngay lập tức
            event.preventDefault();

            // Lấy tất cả các trường input và select cần kiểm tra (ngoại trừ "Yêu cầu thêm")
            var inputs = document.querySelectorAll('.inner-contact-information-form input[required], .inner-contact-information-form select[required], .inner-guest-information-form input[required], .inner-guest-information-form select[required], .additional-infomation input[required]');

            var isFormValid = true;

            // Lặp qua tất cả các trường input và select cần kiểm tra
            inputs.forEach(function (input) {
                // Kiểm tra nếu giá trị của trường input/textarea bị trống
                if (input.value.trim() === "") {
                    // Đặt viền màu đỏ cho trường bị thiếu dữ liệu
                    input.style.border = "2px solid red";
                    isFormValid = false; // Form không hợp lệ
                } else {
                    // Xóa viền màu đỏ nếu trường đã được điền
                    input.style.border = "";
                }

                // Lắng nghe sự kiện "input" để thay đổi lại viền khi người dùng nhập dữ liệu
                input.addEventListener('input', function () {
                    if (input.value.trim() !== "") {
                        // Khôi phục viền bình thường khi người dùng nhập
                        input.style.border = "";
                    }
                });
            });

            // Nếu form hợp lệ (không có trường nào thiếu), có thể tiếp tục
            if (isFormValid) {
                // Bạn có thể thực hiện submit form hoặc chuyển hướng tới servlet khác
                alert("Form đã hoàn tất!");
                // Ví dụ submit form: document.querySelector('.inner-contact-information-form').submit();
            } else {
                alert("Vui lòng điền đầy đủ thông tin vào các trường bắt buộc.");
            }
        });
    </script>
</body>

<%@include file="includes/footer.jsp" %>
