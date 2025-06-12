<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>POS System</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
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
            .orders-table {
                background-color: white;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 15px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                min-height: 100vh;
            }
            .order-details {
                border-left: 1px solid #ddd;
                padding: 20px;
                background-color: #fff;
                min-height: 100vh;
            }
            .order-details h5 {
                font-weight: bold;
            }
            .order-details p {
                margin: 0 0 10px;
            }
            .order-status {
                display: flex;
                flex-direction: column;
            }
            .order-status select {
                margin-bottom: 10px;
            }
            .order-status div {
                display: flex;
                justify-content: space-between;
            }
            .btn-outline-primary {
                width: 48%;
            }
            .order-details-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .order-details-header .text-right {
                text-align: right;
            }
            .pagination-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .pagination-buttons {
                display: flex;
                align-items: center;
            }
            .pagination-buttons button {
                margin: 0 5px;
            }

            .pagination-container span {
                background-color: #f0f0f0;
                padding: 5px;
                border-radius: 5px;
            }

            .table tbody tr:nth-child(odd) {
                background-color: #f9f9f9;
            }
            .table tbody tr:nth-child(even) {
                background-color: #ffffff;
            }

            .orders-table-wrapper {
                max-height: 400px;
                overflow-y: auto;
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
                        <p>Xin chào ${sessionScope.employ.username}</p>
                        <a href="Login.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </div>
                </div>
                <div class="col-md-10 content">
                    <div class="d-flex justify-content-between align-items-center">
                        <h4>All Orders</h4>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-8 orders-table">
                            <h5>Orders</h5>
                            <input type="text" class="form-control mb-3" placeholder="Search order by id, customer">
                            <div class="orders-table-wrapper">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Order Date</th>
                                            <th>Order Total</th>
                                            <th>Channel</th>
                                            <th>Order Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>#WOO_170</td>
                                            <td><i class="fas fa-calendar-alt"></i> Wed Apr 17, 2024</td>
                                            <td>$164.22</td>
                                            <td>POS</td>
                                            <td><span class="badge badge-warning">Pending Payment</span></td>
                                        </tr>
                                        <tr>
                                            <td>#WOO_169</td>
                                            <td><i class="fas fa-calendar-alt"></i> Wed Apr 17, 2024</td>
                                            <td>$5.10</td>
                                            <td>POS</td>
                                            <td><span class="badge badge-success">Completed</span></td>
                                        </tr>
                                        <tr>
                                            <td>#WOO_166</td>
                                            <td><i class="fas fa-calendar-alt"></i> Thu Feb 29, 2024</td>
                                            <td>$36.72</td>
                                            <td>WooCommerce</td>
                                            <td><span class="badge badge-info">Processing</span></td>
                                        </tr>
                                        <tr>
                                            <td>#WOO_165</td>
                                            <td><i class="fas fa-calendar-alt"></i> Thu Feb 29, 2024</td>
                                            <td>$18.36</td>
                                            <td>WooCommerce</td>
                                            <td><span class="badge badge-info">Processing</span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="pagination-container">
                                <span>1 - 48 / 48</span>
                                <div class="pagination-buttons">
                                    <button class="btn btn-primary">Previous</button>
                                    <span>1</span>
                                    <button class="btn btn-primary">Next</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 order-details">
                            <h5>Order ID #WOO_170</h5>
                            <div class="order-details-header">
                                <h6>John Doe</h6>
                                <div class="text-right">
                                    <p><i class="fas fa-calendar-alt"></i> Wed Apr 17, 2024</p>
                                    <p>09:35 AM</p>
                                </div>
                            </div>
                            <hr>
                            <div>
                                <p><strong>Cap:</strong> $10.00 (1 Unit(s))</p>
                                <p><strong>Sunglasses:</strong> $90.00 (1 Unit(s))</p>
                                <p><strong>Subtotal:</strong> $161.00</p>
                                <p><strong>Tax(Tax):</strong> $3.22</p>
                                <p><strong>Discount:</strong> $0.00</p>
                                <p><strong>Total:</strong> $164.22</p>
                                <p><strong>Cash:</strong> $164.22</p>
                                <p><strong>Change:</strong> $0.00</p>
                            </div>
                            <hr>
                            <div class="order-status">
                                <select class="form-control">
                                    <option>Pending Payment</option>
                                    <option>Completed</option>
                                    <option>Processing</option>
                                    <option>On Hold</option>
                                    <option>Cancelled</option>
                                </select>
                                <div>
                                    <button class="btn btn-outline-primary">Print Invoice</button>
                                    <button class="btn btn-outline-primary">Send Order Email</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
