<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý người dùng</title>
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
                background: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }
            .transaction-header {
                margin-bottom: 20px;
            }
            .transaction-info {
                margin-bottom: 10px;
            }
            .form-inline input[type="date"] {
                margin-right: 10px;
            }
            .transaction-card {
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 5px;
                margin-bottom: 10px;
                padding: 10px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .transaction-card:hover {
                background-color: #d1ecf1;
            }
            .transaction-card p {
                margin: 0;
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
                        <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                    </div>
                </div>
                <div class="col-md-10 content">
                    <!-- Nội dung chính -->
                    <div class="transaction-details">
                        <h2 class="md-4">Giao dịch chi tiết theo khách hàng</h2>
                        <hr>
                        <div class="row transaction-info" style="font-size: 24px">
                            <div class="col-md-6">
                                <p style="margin-bottom: 5px"><strong>Số điện thoại:</strong> ${c.phone_number}</p>

                            </div>
                            <div class="col-md-6">
                                <p><strong>Tổng số tiền đã giao dịch:</strong> <span id="formattedTotalAmount">${totalAmount}</span> VNĐ</p>
                                <script>
                                    const totalAmountElement = document.getElementById("formattedTotalAmount");
                                    totalAmountElement.textContent = Math.trunc(Number(totalAmountElement.textContent)).toLocaleString("vi-VN");
                                </script>
                                <p style="margin-bottom: 5px"><strong>Tổng số giao dịch:</strong> ${totalOrder}</p>
                            </div>
                        </div>
                        <hr>
                        <div class="row mt-4">
                            <c:forEach var="transaction" items="${listTransactionHistorys}">
                                <div class="col-md-4">
                                    <div class="transaction-card" data-thid="${transaction.transactionHistoryId}" data-third="${c.customer_id}">
                                        <input type="hidden" name="thID" value="${transaction.transactionHistoryId}">
                                        <p><strong>Ngày giao dịch:</strong> ${transaction.revenue.date}</p>
                                        <p><strong>Giá thành:</strong> ${Math.round(transaction.transactionAmount)} VNĐ</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="button-container" style="margin-top: 20px">
                            <a style="margin-top: 20px" href="managerCustomer" class="btn btn-danger">Quay lại</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tải jQuery và các thư viện cần thiết -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <script>
    document.addEventListener('DOMContentLoaded', function () {
        var searchInput = document.getElementById('searchUser');
        searchInput.addEventListener('input', function () {
            var searchText = this.value.toLowerCase();
            var tableRows = document.querySelectorAll('#userTable tbody tr');

            tableRows.forEach(function (row) {
                var name = row.cells[1].innerText.toLowerCase(); // Lấy vị trí của cột tên trong hàng
                if (name.indexOf(searchText) > -1) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    });

    document.querySelectorAll('.transaction-card').forEach(function (card) {
        card.addEventListener('click', function () {
            var thID = this.getAttribute('data-thid');
            var CID = this.getAttribute('data-third');
            var form = document.createElement('form');
            form.method = 'post';
            form.action = 'detailTransactionCustomer';

            var inputThID = document.createElement('input');
            inputThID.type = 'hidden';
            inputThID.name = 'thID';
            inputThID.value = thID;

            var inputCID = document.createElement('input');
            inputCID.type = 'hidden';
            inputCID.name = 'CID';
            inputCID.value = CID;

            form.appendChild(inputThID);
            form.appendChild(inputCID);
            document.body.appendChild(form);
            form.submit();
        });
    });

        </script>
    </body>
</html>
