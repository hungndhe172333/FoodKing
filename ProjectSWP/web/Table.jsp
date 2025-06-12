<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Table Management</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="shortcut icon" href="assets/img/logo/favicon.svg">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/font-awesome.css">
        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/css/meanmenu.css">
        <link rel="stylesheet" href="assets/css/swiper-bundle.min.css">
        <link rel="stylesheet" href="assets/css/nice-select.css">
        <link rel="stylesheet" href="assets/css/main.css">
        <style>
            body {
                background-color: #F6F6F6;
            }
            .sidebar {
                min-height: 100vh;
                background-color: #ffffff;
                border-right: 1px solid #ddd;
            }
            .sidebar a {
                color: #333;
                padding: 15px;
                display: block;
                text-decoration: none;
            }
            .sidebar a:hover {
                background-color: #f0f0f0;
            }
            .sidebar .logo img {
                width: 100px;
                margin: 20px;
            }
            .sidebar .user {
                margin-left: 20px;
                margin-top: 30px;
            }
            .content {
                padding: 20px;
            }
            .table-card {
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 5px;
                margin-bottom: 20px;
                padding: 15px;
            }
            .table-header {
                font-weight: bold;
                margin-bottom: 10px;
            }
            .order-info {
                margin-bottom: 10px;
            }
            .order-selecting {
                color: blue;
            }
            .order-waiting {
                color: orange;
            }
            .order-confirm {
                color: green;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 sidebar d-none d-md-block">
                    <div class="logo">
                        <img src="assets/img/logo/logo.svg" alt="Logo">
                    </div>
                    <c:if test="${sessionScope.admin == null}">
                        <a href="profile"><i class="fas fa-user"></i> Hồ sơ</a>
                    </c:if>
                    <c:if test="${sessionScope.admin == null}">
                        <a href="tableControl"><i class="fas fa-table"></i> Bàn</a>
                    </c:if>
                    <div class="user">
                        <c:if test="${sessionScope.employ != null}">
                            <p>Xin chào ${sessionScope.employ.name}</p>
                        </c:if>
                        <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                    </div>
                </div>
                <nav class="navbar navbar-expand-md navbar-light bg-light d-md-none">
                    <a class="navbar-brand" href="#">
                        <img src="assets/img/logo/logo.svg" alt="Logo" width="30" height="30" class="d-inline-block align-top">
                    </a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="profile"><i class="fas fa-user"></i> Hồ sơ</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="tableControl"><i class="fas fa-table"></i> Bàn</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Cash.jsp"><i class="fas fa-cash-register"></i> Tiền</a>
                            </li>
                            <li class="nav-item">
                                <c:if test="${sessionScope.employ != null}">
                                    <a class="nav-link" href="#"><i class="fas fa-user"></i> Xin chào ${sessionScope.employ.name}</a>
                                </c:if>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                            </li>
                        </ul>
                    </div>
                </nav>
                <div class="main-content col-md-10">
                    <div class="table-container">
                        <c:choose>
                            <c:when test="${not empty requestScope.tableCarts}">
                                <c:forEach var="entry" items="${requestScope.tableCarts}">
                                    <a href="tableDetailControl?tableName=${entry.key}" style="text-decoration: none">
                                        <div class="table-card dine-in">
                                            <div class="table-header">
                                                <span><i class="fas fa-utensils"></i> ${entry.key}</span>
                                            </div>
                                            <div class="table-body">
                                                <c:forEach var="cart" items="${entry.value}" varStatus="status">
                                                    <c:if test="${cart.status == 'Đang chờ xác nhận' || cart.status == 'Đã xác nhận'}">
                                                        <div class="order-info
                                                             ${cart.status == 'Đang chọn món' ? 'order-selecting' : ''}
                                                             ${cart.status == 'Đang chờ xác nhận' ? 'order-waiting' : ''}
                                                             ${cart.status == 'Đã xác nhận' ? 'order-confirm' : ''}">
                                                            <span>Order ${status.index + 1}: ${cart.status}</span><br>
                                                            <span>Thời gian đặt món: ${cart.checkoutTime}</span>
                                                            <br/>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p>Không có bàn nào được tìm thấy</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
