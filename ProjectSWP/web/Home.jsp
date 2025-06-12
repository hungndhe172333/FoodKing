<%-- 
    Document   : home
    Created on : May 22, 2024, 3:47:22 PM
    Author     : minhp
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <title>Foodking - Fast Food Restaurant HTML Template</title>
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
            .catagory-product-card-2 {
                position: relative;
                overflow: hidden;
            }

            .catagory-product-image {
                display: flex;
                align-items: center;
                justify-content: center;
                overflow: hidden;
            }

            .catagory-product-image img {
                max-width: 100%;
                max-height: 100%;
                object-fit: cover;
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
                                <a href="home">
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

        <!-- Hero Section Start -->
        <section class="hero-section">
            <div class="hero-1 bg-cover" style="background-image: url('assets/img/hero/hero-bg.jpg');">
                <div class="chilii-shape" data-animation="fadeInUp">
                    <img src="assets/img/hero/chilli-shape.png" alt="shape-img">
                </div>
                <div class="fire-shape" data-animation="fadeInUp">
                    <img src="assets/img/hero/fire-shape.png" alt="shape-img">
                </div>
                <div class="chilii-shape-2" data-animation="fadeInUp">
                    <img src="assets/img/hero/chilli-shape-2.png" alt="shape-img">
                </div>
                <div class="chilii-shape-3" data-animation="fadeInUp">
                    <img src="assets/img/hero/chilli-shape-3.png" alt="shape-img">
                </div>
                <h2 class="hero-back-title"  data-animation="fadeInRight">fast food</h2>
                <div class="container">
                    <div class="row justify-content-between">
                        <div class="col-xl-5 col-lg-7">
                            <div class="hero-content">
                                <p data-animation="fadeInUp">giòn, ngon, siêu rẻ</p>
                                <h1  data-animation="fadeInUp">
                                    Cánh gà
                                    <span>Chiên</span>
                                    giòn
                                </h1>
                            </div>
                        </div>
                        <div class="col-xl-6 col-lg-5 mt-5 mt-lg-0">
                            <div class="chiken-image" data-animation="fadeInUp">
                                <img src="assets/img/hero/chiken.png" alt="chiken-img">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="swiper-dot text-center pt-5">
                    <div class="dot"></div>
                </div>
            </div>
        </section>

        <!-- Food Catagory Section Start -->
        <section class="food-category-section fix section-padding section-bg">
            <div class="tomato-shape">
                <img src="assets/img/shape/tomato-shape.png" alt="shape-img">
            </div>
            <div class="burger-shape-2">
                <img src="assets/img/shape/burger-shape-2.png" alt="shape-img">
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-md-7 col-9">
                        <div class="section-title">
                            <span class="wow fadeInUp">giòn, ngon, siêu rẻ</span>
                            <h2 class="wow fadeInUp" >Foodking có gì ?</h2>
                        </div>
                    </div>
                    <div class="col-md-5 ps-0 col-3 text-end wow fadeInUp" >
                        <div class="array-button">
                            <button class="array-prev"><i class="far fa-long-arrow-left"></i></button>
                            <button class="array-next"><i class="far fa-long-arrow-right"></i></button>
                        </div>
                    </div>
                </div>
                <div class="swiper food-catagory-slider">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <div class="catagory-product-card bg-cover" style="background-image: url('assets/img/shape/catagory-card-shape.jpg');">
                                <div class="catagory-product-image text-center">
                                    <img src="assets/img/food/pizza.png" alt="product-img">
                                    <div class="decor-leaf">
                                        <img src="assets/img/shape/decor-leaf.svg" alt="shape-img">
                                    </div>
                                    <div class="decor-leaf-2">
                                        <img src="assets/img/shape/decor-leaf-2.svg" alt="shape-img">
                                    </div>
                                    <div class="burger-shape">
                                        <img src="assets/img/shape/burger-shape.png" alt="shape-img">
                                    </div>
                                </div>
                                <div class="catagory-product-content text-center">
                                    <div class="catagory-product-icon">
                                        <img src="assets/img/shape/food-shape.svg" alt="shape-text">
                                    </div>
                                    <h3>
                                        pro pizza
                                    </h3>
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide">
                            <div class="catagory-product-card bg-cover" style="background-image: url('assets/img/shape/catagory-card-shape.jpg');">
                                <div class="catagory-product-image text-center">
                                    <img src="assets/img/food/delicious-burger.png" alt="product-img">
                                    <div class="decor-leaf">
                                        <img src="assets/img/shape/decor-leaf.svg" alt="shape-img">
                                    </div>
                                    <div class="decor-leaf-2">
                                        <img src="assets/img/shape/decor-leaf-2.svg" alt="shape-img">
                                    </div>
                                    <div class="burger-shape">
                                        <img src="assets/img/shape/burger-shape.png" alt="shape-img">
                                    </div>
                                </div>
                                <div class="catagory-product-content text-center">
                                    <div class="catagory-product-icon">
                                        <img src="assets/img/shape/food-shape.svg" alt="shape-text">
                                    </div>
                                    <h3>
                                        pro chicken
                                    </h3>
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide">
                            <div class="catagory-product-card bg-cover" style="background-image: url('assets/img/shape/catagory-card-shape.jpg');">
                                <div class="catagory-product-image text-center">
                                    <img src="assets/img/food/burger.png" alt="product-img">
                                    <div class="decor-leaf">
                                        <img src="assets/img/shape/decor-leaf.svg" alt="shape-img">
                                    </div>
                                    <div class="decor-leaf-2">
                                        <img src="assets/img/shape/decor-leaf-2.svg" alt="shape-img">
                                    </div>
                                    <div class="burger-shape">
                                        <img src="assets/img/shape/burger-shape.png" alt="shape-img">
                                    </div>
                                </div>
                                <div class="catagory-product-content text-center">
                                    <div class="catagory-product-icon">
                                        <img src="assets/img/shape/food-shape.svg" alt="shape-text">
                                    </div>
                                    <h3>
                                        pro burger
                                    </h3>
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide">
                            <div class="catagory-product-card bg-cover" style="background-image: url('assets/img/shape/catagory-card-shape.jpg');">
                                <div class="catagory-product-image text-center">
                                    <img src="assets/img/food/french-fry.png" alt="product-img">
                                    <div class="decor-leaf">
                                        <img src="assets/img/shape/decor-leaf.svg" alt="shape-img">
                                    </div>
                                    <div class="decor-leaf-2">
                                        <img src="assets/img/shape/decor-leaf-2.svg" alt="shape-img">
                                    </div>
                                    <div class="burger-shape">
                                        <img src="assets/img/shape/burger-shape.png" alt="shape-img">
                                    </div>
                                </div>
                                <div class="catagory-product-content text-center">
                                    <div class="catagory-product-icon">
                                        <img src="assets/img/shape/food-shape.svg" alt="shape-text">
                                    </div>
                                    <h3>
                                        pro chips
                                    </h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Food Banner Section Start -->
        <section class="food-banner-section section-padding fix section-bg pt-0" style="padding-bottom: 50px">
            <div class="chili-shape">
                <img src="assets/img/shape/chili-shape.png" alt="shape-img">
            </div>
            <div class="fry-shape">
                <img src="assets/img/shape/fry-shape.png" alt="shape-img">
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-xl-5 wow fadeInUp" data-wow-delay=".3s">
                        <div class="single-offer-items bg-cover" style="background-image: url('assets/img/banner/offer-bg.png');">
                            <div class="offer-content">
                                <h5>giòn, ngon, siêu rẻ</h5>
                                <h3>
                                    GIÒN, <br>
                                    THƠM, <br>
                                    NGON 
                                </h3>
                            </div>
                            <div class="burger-text">
                                <img src="assets/img/shape/burger-text.png" alt="shape-img">
                            </div>
                            <div class="main-food">
                                <img src="assets/img/food/main-food.png" alt="food-img">
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-7 mt-5 mt-xl-0 wow fadeInUp" data-wow-delay=".5s">
                        <div class="pizza-banner-items bg-cover" style="background-image: url(assets/img/banner/pizza-bg.png);">
                            <div class="pizza-text">
                                <img src="assets/img/shape/pizza-text.png" alt="shape-img">
                            </div>
                            <div class="pizza-image">
                                <img src="assets/img/food/pizza-2.png" alt="pizza-img">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Food Catagory Section Start -->
        <section class="food-category-section fix section-padding section-bg" style="padding-bottom: 50px">
            <div class="container">
                <div class="section-title text-center">
                    <span class="wow fadeInUp">giòn, ngon, siêu rẻ</span>
                    <h2 class="wow fadeInUp" data-wow-delay=".3s">Thực đơn</h2>
                </div>
                <form name="f" action="" method="post">
                    <div class="row">
                        <c:forEach var="o" items="${list8}">
                            <div class="col-xl-3 col-lg-6 col-md-6 wow fadeInUp" data-wow-delay=".3s">
                                <div class="catagory-product-card-2 text-center">
                                    <div class="catagory-product-image">
                                        <img src="${o.image}" alt="product-img">
                                    </div>
                                    <div class="catagory-product-content">
                                        <div class="catagory-button">
                                            <button type="submit" class="theme-btn" onclick="buy('${o.product_id}', '${tableName}', '${customerName}', '${phoneNumber}')">
                                                <span class="button-content-wrapper d-flex align-items-center">
                                                    <span class="button-icon"><i class="flaticon-delivery"></i></span>
                                                    <span class="button-text">thêm vào giỏ hàng</span>
                                                </span>
                                            </button>
                                        </div>
                                        <div class="info-price d-flex align-items-center justify-content-center">
                                            <h4 style="color: red">${Math.round(o.price)} VNĐ</h4>
                                        </div>
                                        <h4>
                                            ${o.name}
                                        </h4>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </form>
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

        <!-- Marque Section Start -->
        <div class="marque-section fix section-padding pt-0 section-bg" style="padding-bottom: 10px">
            <div class="marquee-wrapper text-slider">
                <div class="marquee-inner to-left">
                    <ul class="marqee-list d-flex">
                        <li class="marquee-item">
                            <span class="text-slider text-color">populer</span><span class="text-slider"></span> <span class="text-slider text-color">dishes</span>
                            <span class="text-slider"><img src="assets/img/icon/burger.png" alt="icon-img"></span> <span class="text-slider"></span> <span class="text-slider text-color-2">delicious</span>
                            <span class="text-slider text-color-2">food</span> <img src="assets/img/icon/pizza.png" alt="icon-img"> <span class="text-slider"></span> <span class="text-slider text-color">populer</span>
                            <span class="text-slider text-color">dishes</span> <span class="text-slider"></span><span class="text-slider"><img src="assets/img/icon/burger.png" alt="icon-img"></span> <span class="text-slider"></span> <span class="text-slider text-color-2">delicious</span>
                            <span class="text-slider text-color">populer</span><span class="text-slider"></span> <span class="text-slider text-color">dishes</span>
                            <span class="text-slider"><img src="assets/img/icon/burger.png" alt="icon-img"></span> <span class="text-slider"></span> <span class="text-slider text-color-2">delicious</span>
                            <span class="text-slider text-color-2">food</span> <img src="assets/img/icon/pizza.png" alt="icon-img"> <span class="text-slider"></span> <span class="text-slider text-color">populer</span>
                            <span class="text-slider text-color">dishes</span> <span class="text-slider"></span><span class="text-slider"><img src="assets/img/icon/burger.png" alt="icon-img"></span> <span class="text-slider"></span> <span class="text-slider text-color-2">delicious</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

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
                            © SWP391 <span class="theme-color-3">2024</span> <a href="home?tableName=${tableName}">Foodking </a>.
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
        <!--<< CountDown Js >>-->
        <script src="assets/js/countdowncustom.js"></script>
        <!--<< Magnific Popup Js >>-->
        <script src="assets/js/jquery.magnific-popup.min.js"></script>
        <!--<< GSAP Animation Js >>-->
        <script src="assets/js/animation.js"></script>
        <!--<< Wow Animation Js >>-->
        <script src="assets/js/wow.min.js"></script>
        <!--<< Main.js >>-->
        <script src="assets/js/main.js"></script>
        <!-- Code injected by live-server -->

    </body>
</html>

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

