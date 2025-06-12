<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manager User</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
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
            .form-control {
                margin-bottom: 10px;
            }
            .transaction-details {
                background-color: #fff;
                padding: 20px;
                margin-top: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .transaction-details h3 {
                margin-bottom: 20px;
            }
            .transaction-details table {
                width: 100%;
            }
            .transaction-details table th,
            .transaction-details table td {
                padding: 8px;
                text-align: left;
            }
            .product-image {
                width: 100px;
                height: 100px;
            }
            .product-table-wrapper {
                max-height: 400px;
                overflow-y: auto;
            }
            .product-table-wrapper table {
                width: 100%;
                table-layout: fixed;
            }
            .product-table-wrapper th,
            .product-table-wrapper td {
                padding: 8px;
                text-align: left;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 sidebar">
                    <div class="logo">
                        <img src="assets/img/logo/logo.svg" alt="Logo">
                    </div>
                    <c:if test="${sessionScope.admin != null}">
                        <a href="dashboard"><i class="fas fa-home"></i> Trang chủ</a>
                    </c:if>
                    <c:if test="${sessionScope.admin == null}">
                        <a href="Table.jsp"><i class="fas fa-users"></i> Bàn</a>
                    </c:if>
                    <c:if test="${sessionScope.admin == null}">
                        <a href="Cash.jsp"><i class="fas fa-cash-register"></i> Tiền</a>
                    </c:if>
                    <c:if test="${sessionScope.admin != null}">
                        <a href="managerproducts"><i class="fas fa-box-open"></i> Quản lí sản phẩm</a>
                    </c:if>
                    <c:if test="${sessionScope.admin != null}">
                        <a href="managertable"><i class="fas fa-utensils"></i> Quản lí Bàn ăn</a>
                    </c:if>
                    <c:if test="${sessionScope.admin != null}">
                        <a href="managerdiscount"><i class="fas fa-ticket"></i> Quản lí phiếu giảm giá</a>
                    </c:if>
                    <c:if test="${sessionScope.admin != null}">
                        <a href="managerCustomer"><i class="fas fa-users"></i> Khách hàng</a>
                    </c:if>
                    <c:if test="${sessionScope.admin != null}">
                        <a href="manageremployee"><i class="fas fa-users"></i> Nhân viên</a>
                    </c:if>
                    <c:if test="${sessionScope.admin != null}">
                        <a href="workScheduleControl"><i class="fas fa-calendar-alt"></i> Lịch làm việc</a>
                    </c:if>
                    <c:if test="${sessionScope.admin != null}">
                        <a href="salaries"><i class="fas fa-money-bill"></i> Quản lí lương</a>
                    </c:if>

                    <div class="user">
                        <c:if test="${sessionScope.employ != null}">
                            <p>Xin chào ${sessionScope.employ.username}</p>
                        </c:if>
                        <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </div>
                </div>
                <div class="col-md-10 content">
                    <!-- Main Content -->
                    <div class="container mt-4">
                        <h2 class="mb-4">Chi tiết đơn hàng</h2>
                        <hr>
                        <div class="row transaction-info" style="font-size: 24px">
                            <div class="col-md-6">
                                <p style="margin-bottom: 5px"><strong>Số điện thoại:</strong> ${c.phone_number}</p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-md-3">
                                <div id="transactionDetails" class="transaction-details">
                                    <h3>Thông tin</h3>
                                    <div id="transactionContent">
                                        <table class="table">
                                            <tr>
                                                <th>Mã giao dịch:</th>
                                                <td>${tranHis.transactionHistoryId}</td>
                                            </tr>
                                            <tr>
                                                <th>Ngày giao dịch:</th>
                                                <td>${tranHis.revenue.date}</td>
                                            </tr>
                                            <tr>
                                                <th>Tổng giá trị:</th>
                                                <td>${Math.round(tranHis.order.totalAmount)} VNĐ</td>
                                            </tr>
                                            <tr>
                                                <th>Chiết khấu:</th>
                                                    <c:if test="${discount == null}">
                                                    <td>0 %</td>
                                                </c:if>
                                                <c:if test="${discount != null}">
                                                    <td>${discount.discountPercentage} %</td>
                                                </c:if>
                                            </tr>
                                            <tr>
                                                <th>Tổng thanh toán:</th>
                                                <td>${Math.round(tranHis.transactionAmount)} VNĐ</td>
                                            </tr>
                                            <tr>
                                                <th>Loại thanh toán:</th>
                                                <td>${tranHis.transactionType}</td>
                                            </tr>
                                        </table>
                                        <div class="button-container" style="margin-top: 20px">
                                            <a style="margin-top: 20px" href="detailTransactionCustomer?customer_id=${c.customer_id}" class="btn btn-info">Xem các giao dịch khác</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div id="productDetails" class="transaction-details">
                                    <h3>Sản phẩm của đơn hàng</h3>
                                    <div id="productContent" class="product-table-wrapper">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>STT</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Số lượng</th>
                                                    <th>Giá thành</th>
                                                    <th>Thành tiền</th>
                                                    <th>Hình ảnh</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="od" items="${od}" varStatus="status">
                                                    <tr>
                                                        <td>${status.index + 1}</td>
                                                        <td>${od.product.name}</td>
                                                        <td>${od.quantity}</td>
                                                        <td>${Math.round(od.price)} VNĐ</td>
                                                        <td>${Math.round(od.price * od.quantity)} VNĐ</td>
                                                        <td><img src="${od.product.image}" alt="${od.product.name}" class="product-image"></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Tải jQuery và các thư viện cần thiết -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
