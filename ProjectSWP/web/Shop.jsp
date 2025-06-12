<%-- 
    Document   : Shop
    Created on : May 22, 2024, 3:49:39 PM
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
            a.active {
                background-color: orange !important;
            }

            .widget-categories li:hover {
                background-color: #ccc;
                cursor: pointer;
            }

            .widget-categories li {
                padding: 10px;
            }

            li.active {
                background-color: orange !important;
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
                                <a href="home" class="header-logo">
                                    <img src="assets/img/logo/logo.svg" alt="logo-img">
                                </a>
                            </div>
                            <div class="header-left">
                                <div class="mean__menu-wrapper d-none d-lg-block">
                                    <div class="main-menu">
                                        <nav id="mobile-menu">
                                            <ul>                                              
                                                <li class="has-dropdown">
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
                    <h1>cửa hàng</h1>
                    <ul class="breadcrumb-items">
                        <li>
                            Trang chủ
                        </li>
                        <li>
                            <i class="far fa-chevron-right"></i>
                        </li>
                        <li>
                            cửa hàng
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Food Catagory Section Start -->
        <section class="food-category-section fix section-padding section-bg" style="padding-bottom: 0px">
            <div class="container">
                <div class="row g-5">
                    <div class="col-xl-3 col-lg-4 order-2 order-md-1 mt-5">
                        <div class="main-sidebar">
                            <div class="single-sidebar-widget">
                                <div class="wid-title">
                                    <h4>Danh mục</h4>
                                </div>
                                <div class="widget-categories">
                                    <ul>
                                        <li onclick="location.href = 'shop?tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}'">
                                            All
                                        </li>
                                        <c:forEach var="o" items="${listC}">
                                            <li class="${check==o.category_id?'active':''}" onclick="location.href = 'shop?cid=${o.category_id}&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}'">
                                                ${o.name}
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>

                            <div class="single-sidebar-widget">
                                <div class="wid-title">
                                    <h4>HÀNG MỚI VỀ</h4>
                                </div>
                                <div class="popular-food-posts">
                                    <c:forEach var="o" items="${list4}">
                                        <div class="single-post-item">
                                            <a href="shopsingle?id=${o.product_id}&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">
                                                <div class="thumb bg-cover" style="background-image: url('${o.image}')"></div>
                                            </a>
                                            <div class="post-content">
                                                <div class="star">
                                                    <span class="fas fa-star"></span>
                                                    <span class="fas fa-star"></span>
                                                    <span class="fas fa-star"></span>
                                                    <span class="fas fa-star"></span>
                                                    <span class="fas fa-star color-bg"></span>
                                                </div>
                                                <h4>${o.name}</h4>
                                                <div class="post-price">
                                                    <span class="theme-color-2">${Math.round(o.price)} VNĐ</span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-9 col-lg-8 order-1 order-md-2">
                        <div class="woocommerce-notices-wrapper mb-0">
                            <div class="product-showing">
                                <h5>Hiển thị ${totalproduct} kết quả</h5>
                            </div>
                            <div class="form-clt">

                                <div class="nice-select" tabindex="0">
                                    <span class="current">
                                        Giá
                                    </span>
                                    <ul class="list">
                                        <li data-value="1" class="option ${type == 'asc' ? 'selected' : ''}">
                                            <c:choose>
                                                <c:when test="${check != null}">
                                                    <a href="shop?cid=${check}&type=asc&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">tăng dần</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="shop?type=asc&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">tăng dần</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                        <li data-value="1" class="option ${type == 'desc' ? 'selected' : ''}">
                                            <c:choose>
                                                <c:when test="${check != null}">
                                                    <a href="shop?cid=${check}&type=desc&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">giảm dần</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="shop?type=desc&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">giảm dần</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <form name="f" action="" method="post">
                                <c:forEach items="${listP}" var="o">
                                    <div class="col-xl-12 col-lg-12">
                                        <div class="shop-list-items">

                                            <div class="shop-image">
                                                <a href="shopsingle?id=${o.product_id}&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">
                                                    <img src="${o.image}" alt="shop-img">
                                                </a>
                                            </div>

                                            <div class="shop-content">
                                                <div class="star pb-4">
                                                    <a href="#"> <i class="fas fa-star"></i></a>
                                                    <a href="#"><i class="fas fa-star"></i></a>
                                                    <a href="#"> <i class="fas fa-star"></i></a>
                                                    <a href="#"><i class="fas fa-star"></i></a>
                                                    <a href="#" class="color-bg"> <i class="fas fa-star"></i></a>
                                                </div>
                                                <h3><a href="shopsingle?id=${o.product_id}&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">${o.name}</a></h3>
                                                <p>${o.description}</p>
                                                <h5>${Math.round(o.price)} VNĐ</h5>
                                                <p>Số lượng: ${o.stock_quantity}</p>
                                                <div class="shop-list-btn">
                                                    <button type="submit" class="theme-btn" onclick="buy('${o.product_id}', '${tableName}', '${customerName}', '${phoneNumber}')">
                                                        <span class="button-content-wrapper d-flex align-items-center">
                                                            <span class="button-icon"><i class="flaticon-delivery"></i></span>
                                                            <span class="button-text">thêm vào giỏ hàng</span>
                                                        </span>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </form>

                            <div class="page-nav-wrap mt-5 text-center">
                                <ul>
                                    <c:if test="${tag > 1}">
                                        <li>
                                            <c:choose>
                                                <c:when test="${check != null}">
                                                    <a class="page-numbers" href="shop?cid=${check}&index=${tag-1}&type=${type}&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">
                                                        <i class="fal fa-long-arrow-left"></i>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a class="page-numbers" href="shop?index=${tag-1}&type=${type}&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">
                                                        <i class="fal fa-long-arrow-left"></i>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="1" end="${endP}" var="i">
                                        <c:if test="${i <= 3 || i > endP - 3 || (i >= tag - 1 && i <= tag + 1)}">
                                            <li>
                                                <c:choose>
                                                    <c:when test="${check != null}">
                                                        <a class="page-numbers ${i == tag ? 'active' : ''}" href="shop?cid=${check}&index=${i}&type=${type}&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">
                                                            ${i}
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="page-numbers ${i == tag ? 'active' : ''}" href="shop?index=${i}&type=${type}&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">
                                                            ${i}
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </li>
                                        </c:if>
                                        <c:if test="${i == 4 && tag > 5}">
                                            <li>
                                                <span>...</span>
                                            </li>
                                        </c:if>
                                        <c:if test="${i == endP - 3 && tag < endP - 4}">
                                            <li>
                                                <span>...</span>
                                            </li>
                                        </c:if>
                                    </c:forEach>

                                    <c:if test="${tag < endP}">
                                        <li>
                                            <c:choose>
                                                <c:when test="${check != null}">
                                                    <a class="page-numbers" href="shop?cid=${check}&index=${tag+1}&type=${type}&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">
                                                        <i class="fal fa-long-arrow-right"></i>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a class="page-numbers" href="shop?index=${tag+1}&type=${type}&tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">
                                                        <i class="fal fa-long-arrow-right"></i>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </c:if>
                                </ul>
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
                                        We believe it has the power to do <br>
                                        amazing things.
                                    </p>
                                    <span>Interested in working with us?</span> <br>
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
                            © SWP391 <span class="theme-color-3">2024</span> <a href="home?tableName=${tableName}&customerName=${customerName}&phoneNumber=${phoneNumber}">Foodking </a>. All Rights Reserved.
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

