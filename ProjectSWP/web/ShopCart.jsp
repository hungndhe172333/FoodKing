<%-- 
    Document   : ShopCart
    Created on : May 22, 2024, 3:48:34 PM
    Author     : minhp
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <!--<< Header Area >>-->
    <head>
        <!-- ========== Meta Tags ========== -->
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="modinatheme">
        <meta name="description" content="Foodking - Fast Food Restaurant Html">
        <!-- ======== Page title ============ -->
        <title>Foodking - Fast Food Restaurant Html</title>
        <!--<< Favcion >>-->
        <link rel="shortcut icon" href="assets/img/logo/favicon.svg">
        <!--<< Bootstrap min.css >>-->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <!--<< Font Awesome.css >>-->
        <link rel="stylesheet" href="assets/css/font-awesome.css">
        <!--<< Animate.css >>-->
        <link rel="stylesheet" href="assets/css/animate.css">
        <!--<< Magnific Popup.css >>-->
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <!--<< MeanMenu.css >>-->
        <link rel="stylesheet" href="assets/css/meanmenu.css">
        <!--<< Swiper Bundle.css >>-->
        <link rel="stylesheet" href="assets/css/swiper-bundle.min.css">
        <!--<< Nice Select.css >>-->
        <link rel="stylesheet" href="assets/css/nice-select.css">
        <!--<< Main.css >>-->
        <link rel="stylesheet" href="assets/css/main.css">
        <!--<< Style.css >>-->
        <link rel="stylesheet" href="style.css">

        <style>
            .main-cart-wrapper .cart-wrapper-footer form input {
                color: black;
            }

            .cart-item-quantity a {
                font-size: 18px;
            }

            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgb(0,0,0);
                background-color: rgba(0,0,0,0.4);
                justify-content: center;
                align-items: center;
            }


            .modal-content {
                background-color: #fefefe;
                margin: auto;
                padding: 20px;
                border: 1px solid #888;
                width: 60%; /* 60% width */
                aspect-ratio: 3 / 2; /* 6:4 aspect ratio */
                max-width: 400px; /* Max width */
                text-align: center;
                position: relative;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }

            .spinner {
                border: 4px solid rgba(0, 0, 0, 0.1);
                width: 36px;
                height: 36px;
                border-radius: 50%;
                border-left-color: #09f;
                margin-bottom: 20px;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }
                100% {
                    transform: rotate(360deg);
                }
            }
        </style>
    </head>

    <body>
        <c:set var="tableName" value="${param.tableName}"/>
        <c:set var="customerName" value="${param.customerName}"/>
        <c:set var="phoneNumber" value="${param.phoneNumber}"/>
        <!-- Offcanvas Area Start -->
        <div class="fix-area">
            <div class="offcanvas__info">
                <div class="offcanvas__wrapper">
                    <div class="offcanvas__content">
                        <div class="offcanvas__top mb-5 d-flex justify-content-between align-items-center">
                            <div class="offcanvas__logo">
                                <a href="home?tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">
                                    <img src="assets/img/logo/logo.svg" alt="logo-img">
                                </a>
                            </div>
                            <div class="offcanvas__close">
                                <button>
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                        </div>
                        <p class="text d-none d-lg-block">
                            This involves interactions between a business and its customers. It's about meeting customers' needs and resolving their problems. Effective customer service is crucial.
                        </p>
                        <div class="offcanvas-gallery-area d-none d-lg-block">
                            <div class="offcanvas-gallery-items">
                                <a href="assets/img/header/01.jpg" class="offcanvas-image img-popup">
                                    <img src="assets/img/header/01.jpg" alt="gallery-img">
                                </a>
                                <a href="assets/img/header/02.jpg" class="offcanvas-image img-popup">
                                    <img src="assets/img/header/02.jpg" alt="gallery-img">
                                </a>
                                <a href="assets/img/header/03.jpg" class="offcanvas-image img-popup">
                                    <img src="assets/img/header/03.jpg" alt="gallery-img">
                                </a>
                            </div>
                            <div class="offcanvas-gallery-items">
                                <a href="assets/img/header/04.jpg" class="offcanvas-image img-popup">
                                    <img src="assets/img/header/04.jpg" alt="gallery-img">
                                </a>
                                <a href="assets/img/header/05.jpg" class="offcanvas-image img-popup">
                                    <img src="assets/img/header/05.jpg" alt="gallery-img">
                                </a>
                                <a href="assets/img/header/06.jpg" class="offcanvas-image img-popup">
                                    <img src="assets/img/header/06.jpg" alt="gallery-img">
                                </a>
                            </div>
                        </div>
                        <div class="mobile-menu fix mb-3"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="offcanvas__overlay"></div>

        <!-- Header Area Start -->
        <header class="section-bg">
            <div id="header-sticky" class="header-1">
                <div class="container">
                    <div class="mega-menu-wrapper">
                        <div class="header-main">
                            <div class="logo">
                                <a href="home?tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}" class="header-logo">
                                    <img src="assets/img/logo/logo.svg" alt="logo-img">
                                </a>
                            </div>
                            <div class="header-left">
                                <div class="mean__menu-wrapper d-none d-lg-block">
                                    <div class="main-menu">
                                        <nav id="mobile-menu">
                                            <ul>                                              
                                                <li class="has-dropdown active">
                                                    <a href="home?tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">
                                                        <h4>Trang chủ</h4>
                                                    </a>
                                                <li></li>
                                                <li class="has-dropdown">
                                                    <a href="shop?tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">
                                                        <h4>Cửa hàng</h4>
                                                    </a>
                                                </li>
                                                <li></li>
                                                <li>
                                                    <a href="Contact.jsp?tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">
                                                        <h4>Liên hệ</h4>
                                                    </a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                            <div class="header-right d-flex justify-content-start align-items-center">
                                <div class="menu-cart d-flex align-items-center">
                                    <a href="ShopCart.jsp?tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}" class="cart-icon">
                                        <i class="far fa-shopping-basket"></i>
                                    </a>
                                    <c:if test="${sessionScope.size > 0}">
                                        <div class="cart-size ms-2">(${sessionScope.size})</div>
                                    </c:if>
                                </div>
                                <div class="header__hamburger d-xl-block my-auto">
                                    <div class="sidebar__toggle">
                                        <div class="header-bar">
                                            <span></span>
                                            <span></span>
                                            <span></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <!--<< Breadcrumb Section Start >>-->
        <div class="breadcrumb-wrapper bg-cover" style="background-image: url('assets/img/banner/breadcrumb.jpg');">
            <div class="container">
                <div class="page-heading center">
                    <h1>Giỏ hàng</h1>
                    <ul class="breadcrumb-items">
                        <li>
                            Trang chủ
                        </li>
                        <li>
                            <i class="far fa-chevron-right"></i>
                        </li>
                        <li>
                            giỏ hàng
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!--<< Product Cart Section Start >>-->
        <section class="cart-section section-padding fix">
            <div class="container">
                <div class="main-cart-wrapper">
                    <div class="row">
                        <div class="col-12">
                            <div class="cart-wrapper">
                                <div class="cart-items-wrapper">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Sản phẩm</th>
                                                <th>Giá thành</th>
                                                <th>Số lượng</th>
                                                <th>Tổng tiền</th>
                                                <th>Xóa</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:set var="tableName" value="${param.tableName}"/>
                                            <c:set var="tableCarts" value="${sessionScope.tableCarts}"/>
                                            <c:set var="cart" value="${tableCarts[tableName].get(tableCarts[tableName].size() - 1)}"/>
                                            <c:forEach items="${cart.items}" var="i">
                                                <tr class="cart-item">
                                                    <td class="cart-item-info">
                                                        <img src="${i.product.image}" alt="mon an" width="50" height="50"/>
                                                    </td>
                                                    <td class="cart-item-price">
                                                        ${Math.round(i.product.price)} VNĐ
                                                    </td>
                                                    <td>
                                                        <div class="cart-item-quantity">
                                                            <button type="button" class="btn btn-secondary update-quantity" data-table="${tableName}" data-id="${i.product.product_id}" data-cart="${cart.id}" data-num="-1">-</button>
                                                            <input type="text" readonly value="${i.quantity}" class="form-control mx-2" style="width: 50px; text-align: center;">
                                                            <button type="button" class="btn btn-secondary update-quantity" data-table="${tableName}" data-id="${i.product.product_id}" data-cart="${cart.id}" data-num="1">+</button>
                                                        </div>
                                                    </td>
                                                    <td class="cart-item-total">
                                                        ${Math.round(i.quantity * i.product.price)} VNĐ
                                                    </td>
                                                    <td>
                                                        <button class="btn btn-danger remove-from-cart" data-table="${tableName}" data-id="${i.product.product_id}" data-cart="${cart.id}">X</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6"></div>
                        <div class="col-xl-6">
                            <div class="cart-pragh-box">
                                <div class="cart-graph">
                                    <h4>Tổng giá trị giỏ hàng</h4>
                                    <ul>
                                        <li>
                                            <span>Tổng tiền</span>
                                            <span>${Math.round(cart.getTotalMoney())} VNĐ</span>
                                        </li>
                                    </ul>
                                    <div class="chck" method="post">
                                        <form id="checkoutForm" action="checkout" method="post">
                                            <input type="hidden" name="tableName" value="${tableName}">
                                            <input type="submit" value="Checkout" id="checkoutButton" style="color: white; background-color: #00813D; width: 150px; height: 60px; font-weight: 600"/>
                                        </form>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer Section Start -->
        <footer class="footer-section fix section-bg">
            <div class="burger-shape">
                <img src="assets/img/shape/burger-shape-3.png" alt="burger-shape">
            </div>
            <div class="fry-shape">
                <img src="assets/img/shape/fry-shape-2.png" alt="burger-shape">
            </div>
            <div class="container">
                <div class="footer-widgets-wrapper">
                    <div class="row">
                        <div class="col-xl-3 col-sm-3 col-md-3 col-lg-3 wow fadeInUp" data-wow-delay=".2s">
                            <div class="single-footer-widget">
                                <div class="widget-head">
                                    <a href="index-2.html">
                                        <img src="assets/img/logo/logo.svg" alt="logo-img">
                                    </a>
                                </div>
                                <div class="footer-content">
                                    <p>
                                        Chúng tôi tin rằng nó có sức mạnh <br>
                                        để làm những điều tuyệt vời.
                                    </p>
                                    <span>Có thấy thú vị khi làm việc với chúng tôi không?</span> <br>
                                    <a href="mailto:info@example.com" class="link">info@example.com</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-5 col-sm-4 col-md-4 col-lg-5 wow fadeInUp" data-wow-delay=".8s">
                            <div class="single-footer-widget">
                                <div class="widget-head">
                                    <h4>Địa Chỉ:</h4>
                                </div>
                                <div class="footer-address-text">
                                    <h6>Pizza & Fastfood Tân Xã - Tân Xã - Thạch Thất - Hà Nội</h6></br>
                                    <div>
                                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d476707.18344027665!2d104.99019666562499!3d21.021685!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345b353a7f69bb%3A0x207c8fea54ec145c!2zUGl6emEgJiBGYXN0Zm9vZCBUw6JuIFjDow!5e0!3m2!1sen!2s!4v1716172940411!5m2!1sen!2s" width="350" height="200" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>                                    </div>
                                    <h5>Giờ Mở Cửa:</h5>
                                    <h6>
                                        8h00 – 23h00 <br>
                                        Thứ Hai - Chủ Nhật
                                    </h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 ps-xl-5 col-sm-4 col-md-4 col-lg-4 wow fadeInUp" data-wow-delay=".9s">
                            <div class="single-footer-widget">
                                <div class="widget-head">
                                    <h4>Cài Đặt Ứng Dụng:</h4>
                                </div>
                                <div class="footer-apps-items">
                                    <h5>Tải ứng dụng trên App Store hoặc Google Play</h5>
                                    <div class="apps-image d-flex align-items-center">
                                        <a href="#"><img src="assets/img/app-store.png" alt="store-img"></a>
                                        <a href="#"><img src="assets/img/google-play.png" alt="store-img"></a>
                                    </div>
                                    <div class="support-text">
                                        <h5>Hỗ trợ và tư vấn:</h5>
                                        <h3><a href="tel:+8486-9138-563">+8486-9138-563</a></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="container">
                    <div class="footer-bottom-wrapper d-flex align-items-center justify-content-between">
                        <p class="wow fadeInLeft" data-wow-delay=".3s">
                            © Copyright <span class="theme-color-3">2024</span> <a href="home?tableName=${tableName}">Foodking </a>. All Rights Reserved.
                        </p>
                        <div class="card-image wow fadeInRight" data-wow-delay=".5s">
                            <img src="assets/img/card.png" alt="card-img">
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <div id="confirmationModal" class="modal">
            <div class="modal-content">
                <div class="spinner"></div>
                <p id="modalMessage">Vui lòng chờ nhân viên xác nhận</p>
            </div>
        </div>


        <!-- Back To Top Start -->
        <div class="scroll-up">
            <svg class="scroll-circle svg-content" width="100%" height="100%" viewBox="-1 -1 102 102">
            <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98" />
            </svg>
        </div>

        <!--<< All JS Plugins >>-->
        <script src="assets/js/jquery-3.7.1.min.js"></script>
        <!--<< Viewport Js >>-->
        <script src="assets/js/viewport.jquery.js"></script>
        <!--<< Bootstrap Js >>-->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!--<< Nice Select Js >>-->
        <script src="assets/js/jquery.nice-select.min.js"></script>
        <!--<< Waypoints Js >>-->
        <script src="assets/js/jquery.waypoints.js"></script>
        <!--<< Counterup Js >>-->
        <script src="assets/js/jquery.counterup.min.js"></script>
        <!--<< Swiper Slider Js >>-->
        <script src="assets/js/swiper-bundle.min.js"></script>
        <!--<< MeanMenu Js >>-->
        <script src="assets/js/jquery.meanmenu.min.js"></script>
        <!--<< Magnific Popup Js >>-->
        <script src="assets/js/jquery.magnific-popup.min.js"></script>
        <!--<< GSAP Animation Js >>-->
        <script src="assets/js/animation.js"></script>
        <!--<< Wow Animation Js >>-->
        <script src="assets/js/wow.min.js"></script>
        <!--<< Main.js >>-->
        <script src="assets/js/main.js"></script>
    </body>
</html>
<script>
    $(document).ready(function () {
        $('#checkoutButton').click(function (e) {
            e.preventDefault();

            // Check if the cart is empty
            if ($('.cart-item').length === 0) {
                $('#modalMessage').text('Vui lòng chọn món trước khi checkout');
                $('#confirmationModal').css('display', 'flex'); // Hiển thị modal
                setTimeout(function () {
                    $('#confirmationModal').hide(); // Hide modal
                }, 2000); // Hide modal after 2 seconds
                return; // Exit the function early
            }

            $('#modalMessage').text('Vui lòng chờ nhân viên xác nhận');
            $('#confirmationModal').css('display', 'flex'); // Hiển thị modal

            var formData = $('#checkoutForm').serialize(); // Lấy dữ liệu từ form

            // Gửi form bằng AJAX
            $.ajax({
                url: $('#checkoutForm').attr('action'), // URL của form
                type: 'POST',
                data: formData,
                success: function (response) {
                    setTimeout(function () {
                        $('#confirmationModal').hide(); // Hide modal
                        location.reload();
                    }, 2000); // 2 seconds timeout
                },
                error: function (xhr, status, error) {
                    var response = JSON.parse(xhr.responseText);
                    if (response.message === "Not enough stock available") {
                        $('#modalMessage').text('Không đủ số lượng sản phẩm trong kho.');
                    } else {
                        $('#modalMessage').text('Đã xảy ra lỗi: ' + response.message);
                    }
                    setTimeout(function () {
                        $('#confirmationModal').hide(); // Hide modal
                    }, 2000); // Hide modal after 2 seconds
                    console.error('Error:', error);
                }
            });
        });
    });



    $(document).ready(function () {
        $('.update-quantity').click(function (e) {
            e.preventDefault();
            var button = $(this);
            var tableName = button.data('table');
            var id = button.data('id');
            var cartId = button.data('cart');
            var num = button.data('num');

            console.log('Button clicked', tableName, id, cartId, num);  // Debugging log

            $.ajax({
                url: 'process', // Ensure this is the correct URL for your server-side script
                type: 'GET',
                data: {
                    tableName: tableName,
                    cartId: cartId,
                    id: id,
                    num: num
                },
                success: function (response) {
                    console.log('Success:', response);  // Debugging log
                    location.reload();  // Reload the page to reflect changes
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);  // Debugging log
                }
            });
        });

        $('.remove-from-cart').click(function (e) {
            e.preventDefault();
            var button = $(this);
            var tableName = button.data('table');
            var id = button.data('id');
            var cartId = button.data('cart');

            console.log('Button clicked', tableName, id, cartId);  // Debugging log

            $.ajax({
                url: 'process', // Ensure this is the correct URL for your server-side script
                type: 'POST',
                data: {
                    tableName: tableName,
                    cartId: cartId,
                    id: id
                },
                success: function (response) {
                    console.log('Success:', response);  // Debugging log
                    location.reload();  // Reload the page to reflect changes
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);  // Debugging log
                }
            });
        });
    });


</script>


