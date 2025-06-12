<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hồ sơ nhân viên</title>
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
            .table th, .table td {
                vertical-align: middle;
            }
            .profile-card {
                margin-bottom: 20px;
                padding: 20px;
                border-radius: 10px;
                background: #fff;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                text-align: center;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .profile-card h3 {
                margin-bottom: 20px;
                font-size: 1.75rem;
            }
            .profile-card img {
                border-radius: 50%;
                width: 150px;
                height: 150px;
                object-fit: cover;
                margin-bottom: 20px;
            }
            .profile-info {
                text-align: left;
                width: 100%;
                padding: 0 20px;
            }
            .profile-info p {
                margin: 10px 0;
            }
            .profile-info strong {
                display: inline-block;
                width: 150px;
            }
            .edit-button {
                margin-top: 20px;
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
                <div class="col-md-10 content">
                    <div class="row">
                        <div class="profile-card col-md-3 order-1 order-md-1">
                            <h3>Hồ sơ nhân viên</h3>
                            <div class="profile-info">
                                <p>Tên: ${sessionScope.employ.name}</p>
                                <p>Email: ${sessionScope.employ.email}</p>
                                <p>Số điện thoại: ${sessionScope.employ.phone_number}</p>
                                <p>Lương: ${sessionScope.employ.hourly_wage_rate}k VNĐ / 1h</p>
                                <p>Lịch làm việc:
                                    <c:forEach var="o" items="${list}">
                                    <p><strong>${o.pattern_name}: ${o.start_time}-${o.end_time}</strong></p>
                                </c:forEach>
                                </p>
                            </div>
                            <a href="#" class="btn btn-primary edit-button" data-toggle="modal" data-target="#editProfileModal">
                                <i class="fas fa-edit"></i> Chỉnh sửa hồ sơ
                            </a>
                            <div class="modal fade" id="editProfileModal" tabindex="-1" role="dialog" aria-labelledby="editProfileModalLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="editProfileModalLabel">Chỉnh sửa hồ sơ</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body text-left">
                                            <form onsubmit="return validatePhoneNumber();" id="editProfileForm" action="updateProfile" method="post">
                                                <div class="form-group">
                                                    <label for="name">Tên</label>
                                                    <input type="text" class="form-control" id="name" name="name" value="${sessionScope.employ.name}" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="email">Email</label>
                                                    <input type="email" class="form-control" id="email" name="email" value="${sessionScope.employ.email}" readonly>
                                                </div>
                                                <div class="form-group">
                                                    <label for="phone_number">Số điện thoại</label>
                                                    <input type="text" class="form-control" id="phone_number" name="phone_number" value="${sessionScope.employ.phone_number}" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="hourly_wage_rate">Lương</label>
                                                    <input type="text" class="form-control" id="hourly_wage_rate" name="hourly_wage_rate" value="${sessionScope.employ.hourly_wage_rate}" readonly>
                                                </div>
                                                <button type="submit" class="btn btn-primary">Cập nhật</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>



                            <c:if test="${success != null}">
                                <p style="color: green"><strong>${success}</strong></p>
                                    </c:if>
                                    <c:if test="${failed != null}">
                                <p style="color: red"><strong>${success}</strong></p>
                                    </c:if>
                        </div>
                        <div class="orders-card col-md-9 order-2 order-md-2">
                            <h3>Danh sách hóa đơn đã thanh toán hôm nay</h3>
                            <div class="orders-result">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Mã đơn hàng</th>
                                            <th>Tên khách hàng</th>
                                            <th>Số điện thoại</th>
                                            <th>Tổng hóa đơn</th>
                                            <th>Giảm giá</th>
                                            <th>Tổng tiền thanh toán</th>
                                            <th>Ngày thanh toán</th>
                                            <th>Phương thức thanh toán</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${not empty listOrder}">
                                            <c:forEach var="o" items="${listOrder}">
                                                <tr>
                                                    <td>${o.orderId}</td>
                                                    <td>${o.customer.name}</td>
                                                    <td>${o.customer.phone_number}</td>
                                                    <td>${o.totalAmount}</td>
                                                    <td>${o.discount.discountPercentage}%</td>
                                                    <td>${o.transactionHistory.transactionAmount}</td>
                                                    <td>${o.transactionHistory.transactionDate}</td>
                                                    <td>${o.transactionHistory.transactionType}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty listOrder}">
                                            <tr>
                                                <td colspan="8">Không có đơn hàng nào để hiển thị.</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        function validatePhoneNumber() {
            var phoneNumber = document.getElementById("phone_number").value;
            var phoneNumberPattern = /^[0-9]{10,11}$/; 

            if (!phoneNumberPattern.test(phoneNumber)) {
                alert("Vui lòng nhập số điện thoại hợp lệ (10-11 chữ số).");
                return false;
            }
            return true;
        }
    </script>
</html>
