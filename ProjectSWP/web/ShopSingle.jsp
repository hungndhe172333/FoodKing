<%-- 
    Document   : ShopSingle
    Created on : May 22, 2024, 3:49:19 PM
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
    </head>
    <body>
        <c:set var="tableName" value="${param.tableName}"/>
        <c:set var="customerName" value="${param.customerName}"/>
        <c:set var="phoneNumber" value="${param.phoneNumber}"/>
        <c:set var="productId" value="${param.id}"/>
        <!-- Header Area Start -->
        <header class="section-bg">
            <div id="header-sticky" class="header-1">
                <div class="container">
                    <div class="mega-menu-wrapper">
                        <div class="header-main">
                            <div class="logo">
                                <a href="home" class="header-logo">
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
                                    <a href="ShopCart.jsp?tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}" class="cart-icon" class="cart-icon">
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
                    <h1>Chi tiết sản phẩm</h1>
                    <ul class="breadcrumb-items">
                        <li>
                            Trang chủ
                        </li>
                        <li>
                            <i class="far fa-chevron-right"></i>
                        </li>
                        <li>
                            Chi tiết sản phẩm
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Product Details Section Start -->
        <section class="product-details-section section-padding">
            <div class="container">
                <div class="product-details-wrapper">
                    <div class="row">
                        <div class="col-lg-5">
                            <div class="product-image-items">
                                <div class="tab-content" id="nav-tab-Content">
                                    <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                                        <div class="product-image">
                                            <img src="${product.image}" alt="img">
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                                        <div class="product-image">
                                            <img src="assets/img/shop-food/details-1.png" alt="img">

                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
                                        <div class="product-image">
                                            <img src="assets/img/shop-food/details-1.png" alt="img">

                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="nav-contact2" role="tabpanel" aria-labelledby="nav-contact-tab2">
                                        <div class="product-image">
                                            <img src="assets/img/shop-food/details-1.png" alt="img">

                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-7 mt-5 mt-lg-0">
                            <div class="product-details-content">
                                <div class="star pb-3">

                                    <a href="#"> <i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#"> <i class="fas fa-star"></i></a>
                                    <a href="#"><i class="fas fa-star"></i></a>
                                    <a href="#" class="color-bg"> <i class="fas fa-star"></i></a>

                                </div>
                                <h3 class="pb-3">${product.name}</h3>
                                <p class="mb-4">
                                    ${product.description}
                                </p>
                                <div class="price-list d-flex align-items-center">
                                    <span>${Math.round(product.price)} VNĐ</span>

                                </div>
                                <div class="cart-wrp">
                                    <div class="cart-quantity">
                                        <h5>Số lượng:</h5>
                                        <h4>${product.stock_quantity}</h4>
                                    </div>
                                    <div class="shop-button d-flex align-items-center">
                                        <c:if test="${sessionScope.admin == null}">
                                            <button type="submit" class="theme-btn" onclick="buy('${productId}', '${tableName}', '${customerName}', '${phoneNumber}')">
                                                <span class="button-content-wrapper d-flex align-items-center">
                                                    <span class="button-icon"><i class="flaticon-delivery"></i></span>
                                                    <span class="button-text">thêm vào giỏ hàng</span>
                                                </span>
                                            </button>
                                            <a href="shop?tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}" class="theme-btn">
                                                <span class="button-content-wrapper d-flex align-items-center justify-content-center">
                                                    <span class="button-icon"><i class="fas fa-reply"></i></span>
                                                    <span class="button-text">Trở lại</span>
                                                </span>
                                            </a>
                                        </c:if>
                                        <c:if test="${sessionScope.admin != null}">
                                            <a href="updateproduct?id=${product.product_id}" class="theme-btn">
                                                <span class="button-content-wrapper d-flex align-items-center justify-content-center">
                                                    <span class="button-icon"><i class="fas fa-exclamation-circle"></i></span>
                                                    <span class="button-text">Cập nhật sản phẩm</span>
                                                </span>
                                            </a>
                                            <a href="managerproducts" class="theme-btn">
                                                <span class="button-content-wrapper d-flex align-items-center justify-content-center">
                                                    <span class="button-icon"><i class="fas fa-reply"></i></span>
                                                    <span class="button-text">Trở lại</span>
                                                </span>
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="single-tab" style="padding-top: 0px">
                        <div class="tab-content">
                            <div id="description" class="tab-pane fade show active">
                                <div class="description-items">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="description-content">

                                                <h3 class="mb-0 mt-5">Tiêu chí</h3>
                                                <div class="description-list-items d-flex">
                                                    <ul class="description-list">
                                                        <li>
                                                            <i class="fal fa-check"></i>
                                                            <span>Chất lượng nguyên liệu: tươi ngon, nguồn gốc rõ ràng ,phù hợp</span>
                                                        </li>
                                                        <li>
                                                            <i class="fal fa-check"></i>
                                                            <span>Vệ sinh an toàn thực phẩm: nguyên liệu được rửa sạch, phân loại và bảo quản đúng cách.</span>
                                                        </li>
                                                        <li>
                                                            <i class="fal fa-check"></i>
                                                            <span>Cân bằng dinh dưỡng: nguyên liệu chế biến đa dạng, giàu chất dinh dưỡng, tỉ lệ hợp lý. </span>
                                                        </li>
                                                        <li>
                                                            <i class="fal fa-check"></i>
                                                            <span>Thái độ và tác phong phục vụ: chuyên nghiệp,nhanh nhẹn, mang lại cảm giác thoải mái khi khách hàng thưởng thức món ăn.</span>
                                                        </li>
                                                    </ul>
                                                    <ul class="description-list">

                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>                           
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Food Catagory Section Start -->
        <section class="food-category-section fix section-padding section-bg">
            <div class="container">
                <div class="section-title text-center">
                    <span class="wow fadeInUp">Giòn, ngon, siêu rẻ</span>
                    <h2 class="wow fadeInUp" data-wow-delay=".3s">Sản phẩm khác</h2>
                </div>
                <div class="row">
                    <c:forEach var="o" items="${list4}">
                        <div class="col-xl-3 col-lg-6 col-md-6 wow fadeInUp" data-wow-delay=".3s">
                            <div class="catagory-product-card-2 text-center">
                                <div class="catagory-product-image">
                                    <a href="shopsingle?id=${o.product_id}&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">
                                        <img src="${o.image}" alt="product-img" style="max-width: 100%; height: auto;">
                                    </a> 
                                </div>
                                <div class="catagory-product-content">
                                    <div class="catagory-button">
                                        <a href="#" class="theme-btn-2">
                                            <i class="far fa-shopping-basket"></i>Thêm vào giỏ hàng
                                        </a>
                                    </div>
                                    <div class="info-price d-flex align-items-center justify-content-center">
                                        <h6>${Math.round(o.price)} VNĐ</h6>
                                    </div>
                                    <h4>
                                        <a href="shopsingle?id=${o.product_id}&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">${o.name}</a>
                                    </h4>
                                    <div class="star">
                                        <span class="fas fa-star"></span>
                                        <span class="fas fa-star"></span>
                                        <span class="fas fa-star"></span>
                                        <span class="fas fa-star"></span>
                                        <span class="fas fa-star text-white"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
                <div class="catagory-button text-center pt-4 wow fadeInUp" data-wow-delay=".3s">
                    <a href="shop?tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}" class="theme-btn">
                        <span class="button-content-wrapper d-flex align-items-center">
                            <span class="button-icon"><i class="flaticon-delivery"></i></span>
                            <span class="button-text">xem thêm</span>
                        </span>
                    </a>
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
                                    <a href="home?tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">
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
                                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d476707.18344027665!2d104.99019666562499!3d21.021685!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345b353a7f69bb%3A0x207c8fea54ec145c!2zUGl6emEgJiBGYXN0Zm9vZCBUw6JuIFjDow!5e0!3m2!1sen!2s!4v1716172940411!5m2!1sen!2s" 
                                                width="350" height="200" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>                                    </div>
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
                            © Copyright <span class="theme-color-3">2024</span> <a href="home">Foodking </a>. All Rights Reserved.
                        </p>
                        <div class="card-image wow fadeInRight" data-wow-delay=".5s">
                            <img src="assets/img/card.png" alt="card-img">
                        </div>
                    </div>
                </div>
            </div>
        </footer>

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
        <script type="text/javascript">
                                                function buy(productId, tableName, customerName, phoneNumber) {
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "buy",
                                                        data: {
                                                            id: productId,
                                                            tableName: tableName,
                                                            customerName: customerName,
                                                            phoneNumber: phoneNumber
                                                        },
                                                        success: function (response) {
                                                            if (response.status === "success") {
                                                                alert("Sản phẩm đã được thêm vào giỏ hàng!");
                                                            } else {
                                                                alert("Có lỗi xảy ra, vui lòng thử lại.");
                                                            }
                                                        },
                                                        error: function () {
                                                            alert("Có lỗi xảy ra, vui lòng thử lại.");
                                                        }
                                                    });
                                                }
        </script>
    </body>
</html>

