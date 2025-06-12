<%-- 
    Document   : TableDetail
    Created on : May 21, 2024, 3:45:02 PM
    Author     : minhp
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Cart"%>
<%@page import="model.Item"%>
<%@page import="model.Customer"%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chili POS System</title>
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
                display: flex;
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

            .main-content {
                flex: 1;
                display: flex;
                flex-direction: column;
            }

            .table-container {
                display: grid;
                grid-template-columns: repeat(5, 1fr);
                gap: 20px;
                padding: 20px;
                box-sizing: border-box;
            }

            .table-container a {
                text-decoration: none;
                color: black;
            }

            @media (max-width: 1200px) {
                .table-container {
                    grid-template-columns: repeat(3, 1fr);
                }
            }

            @media (max-width: 900px) {
                .table-container {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

            @media (max-width: 600px) {
                .table-container {
                    grid-template-columns: 1fr;
                }
            }

            .table-card {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .table-header {
                display: flex;
                justify-content: space-between;
                font-weight: bold;
            }

            .table-body {
                display: flex;
                justify-content: space-between;
                margin: 10px 0;
            }

            .table-footer {
                display: flex;
                justify-content: space-between;
            }

            .table-info {
                display: flex;
                justify-content: space-between;
                margin-top: 10px;
            }

            .time-label {
                color: gray;
            }

            .dine-in {
                border-left: 5px solid green;
            }

            .to-go {
                border-left: 5px solid red;
            }

            .delivery {
                border-left: 5px solid orange;
            }

            .qr-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            .qr-container img {
                width: 200px;
                height: 200px;
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

                <main role="main" class="col-md-6 px-4 main-content">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h3 class="h3">Thông tin khách hàng</h3>
                    </div>

                    <c:forEach var="cart" items="${requestScope.tableCarts[tableName]}">
                        <c:if test="${not empty cart.customer.name && not empty cart.customer.phone_number && !cart.items.isEmpty()}">
                            <div class="card mb-4 table-card">
                                <div class="card-body">
                                    <h5 class="card-title" id="profile-name">${cart.customer.name}</h5>
                                    <p class="card-text" id="profile-phone">${cart.customer.phone_number}</p>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${(cart.status == 'Đang chờ xác nhận' || cart.status == 'Đã xác nhận') && !cart.items.isEmpty()}">
                            <div class="card mb-4 table-card order-summary">
                                <div class="card-body">
                                    <div class="scrollable-table-order">
                                        <c:forEach var="i" items="${cart.items}">
                                            <div class="order-item row align-items-center mb-3 p-2 border rounded">
                                                <div class="col-2 col-4">
                                                    <img src="${i.product.image}" alt="" class="img-fluid">
                                                </div>
                                                <div class="col-3 col-8">
                                                    <h5>${i.product.name}</h5>
                                                    <p class="text-muted">${i.product.price} VNĐ</p>
                                                </div>
                                                <div class="col-md-4 col-12 text-center mt-2">
                                                    <div class="btn-group" role="group">
                                                        <c:if test="${cart.status != 'Đã xác nhận'}">
                                                            <button type="button" class="btn btn-secondary update-quantity" data-table="${tableName}" data-id="${i.product.product_id}" data-cart="${cart.id}" data-num="-1">-</button>
                                                        </c:if>
                                                        <input type="text" readonly value="${i.quantity}" class="form-control mx-2" style="width: 50px; text-align: center;">
                                                        <c:if test="${cart.status != 'Đã xác nhận'}">
                                                            <button type="button" class="btn btn-secondary update-quantity" data-table="${tableName}" data-id="${i.product.product_id}" data-cart="${cart.id}" data-num="1">+</button>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="col-md-2 col-6 text-right mt-2">
                                                    <strong>${Math.round(i.product.price * i.quantity)} VNĐ</strong>
                                                </div>
                                                <div class="col-md-1 col-6 text-right mt-2">
                                                    <c:if test="${cart.status != 'Đã xác nhận'}">
                                                        <button type="button" class="btn btn-danger remove-from-cart" data-table="${tableName}" data-id="${i.product.product_id}" data-cart="${cart.id}">X</button>
                                                    </c:if>
                                                    <c:if test="${cart.status == 'Đã xác nhận'}">
                                                        <button type="button" class="btn btn-success mark-served" data-table="${tableName}" data-id="${i.product.product_id}" data-cart="${cart.id}" 
                                                                <c:if test="${i.served}">
                                                                    disabled
                                                                </c:if>>
                                                            &#10003;
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <div class="card mt-4">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-6">
                                                    <h5>Tổng tiền:</h5>
                                                </div>
                                                <div class="col-6 text-right">
                                                    <h5>${Math.round(cart.getTotalMoney())} VNĐ</h5>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <c:if test="${cart.status != 'Đã xác nhận'}">
                                        <button class="btn btn-primary btn-block update-cart-status ${cart.status == 'Đã xác nhận' ? 'disabled btn-disabled' : ''}" 
                                                data-table="${tableName}" 
                                                data-cart="${cart.id}"
                                                ${cart.status == 'Đã xác nhận' ? 'disabled' : ''}>
                                            ${cart.status}
                                        </button>
                                    </c:if>
                                    <button class="btn btn-warning btn-block cancel-cart" data-table="${tableName}" data-cart="${cart.id}">
                                        Hủy đơn
                                    </button>
                                </div> 
                            </div>
                        </c:if>
                        <div class="modal fade" id="qrModal" tabindex="-1" role="dialog" aria-labelledby="qrModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="qrModalLabel">QR Code Payment</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body text-center">
                                        <p>Scan the QR code to make a payment:</p>
                                        <img id="qr-code" src="https://img.vietqr.io/image/MB-0865906672-compact2.png?amount=${tableTotalPrices[tableName] * (1 - cart.discountPercent / 100)}&addInfo=${tableName}" alt="QR Code" class="img-fluid">
                                        <form id="paymentForm" action="completePaymentControl" method="get">
                                            <!-- Customer Selection Dropdown -->
                                            <select name="phoneNumber" class="form-control my-3">
                                                <c:forEach var="customer" items="${tableCustomers[tableName]}">
                                                    <option value="${customer.phone_number}">${customer.name} (${customer.phone_number})</option>
                                                </c:forEach>
                                            </select>

                                            <!-- Hidden Fields for Table and Payment Details -->
                                            <input type="hidden" name="tableName" value="${tableName}">
                                            <input type="hidden" name="totalMoney" value="${tableTotalPrices[tableName] * (1 - cart.discountPercent / 100)}">
                                            <input type="hidden" name="transactiontype" value="Chuyển khoản">
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <button type="submit" form="paymentForm" class="btn btn-primary confirm-payment">Confirm Payment</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <script>
                        var hasConfirmedCart = false;
                        <c:forEach var="cart" items="${requestScope.tableCarts[tableName]}">
                        if ('${cart.status}' === 'Đã xác nhận') {
                            hasConfirmedCart = true;
                        }
                        </c:forEach>
                        document.write('<input type="hidden" id="cartStatus" value="' + (hasConfirmedCart ? 'Đã xác nhận' : '') + '">');
                    </script>
                </main>
                <aside class="col-md-4 summary-content">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h3 class="h3">Tổng hợp sản phẩm</h3>
                    </div>

                    <div class="summary-table-order">
                        <c:forEach var="tableName" items="${tableAggregatedProducts.keySet()}">
                            <c:if test="${tableName == param.tableName}">
                                <div class="table-orders mb-4">
                                    <h4>${tableName}</h4>
                                    <c:forEach var="entry" items="${tableAggregatedProducts[tableName]}">
                                        <div class="order-item row align-items-center mb-3 p-2 border rounded">
                                            <div class="col-2">
                                                <img src="${tableProductImages[tableName][entry.key]}" alt="" class="img-fluid">
                                            </div>
                                            <div class="col-6">
                                                <h5>${entry.key}</h5>
                                            </div>
                                            <div class="col-4 text-right">
                                                <h5>${entry.value}</h5>
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <div class="order-summary row align-items-center p-2 border rounded mb-3">
                                        <div class="col-8">
                                            <h5>Tổng tiền:</h5>
                                        </div>
                                        <div class="col-4 text-right">
                                            <h5>${Math.round(tableTotalPrices[tableName])} VNĐ</h5>
                                        </div>
                                    </div>
                                    <!-- Lấy thông tin giảm giá từ giỏ hàng đầu tiên -->
                                    <c:set var="cart" value="${tableCarts[tableName][0]}" />

                                    <!-- Hiển thị thông tin giảm giá và tổng tiền sau khi giảm -->
                                    <div class="order-summary row align-items-center p-2 border rounded mb-3">
                                        <div class="col-8">
                                            <h5>Giảm giá:</h5>
                                        </div>
                                        <div class="col-4 text-right">
                                            <h5>${cart.discountPercent}% off</h5>
                                        </div>
                                    </div>
                                    <div class="order-summary row align-items-center p-2 border rounded">
                                        <div class="col-8">
                                            <h5>Tổng tiền sau khi giảm:</h5>
                                        </div>
                                        <div class="col-4 text-right">
                                            <h5>${Math.round(tableTotalPrices[tableName] * (1 - cart.discountPercent / 100))} VNĐ</h5>
                                        </div>
                                    </div>
                                    <form action="discount" method="post">
                                        <label for="discountCode">Mã giảm giá</label>
                                        <div class="input-group mb-3">
                                            <input type="hidden" name="tableName" value="${tableName}"/>
                                            <input type="text" class="form-control" name="promo-code" placeholder="Nhập mã giảm giá" required>
                                            <div class="input-group-append">
                                                <button type="submit" class="btn btn-primary">Áp dụng</button>
                                            </div>
                                        </div>
                                        <c:if test="${not empty param.discountMessage}">
                                            <c:set var="messageColor" value="red" />
                                            <c:if test="${param.discountMessage == 'Áp dụng thành công'}">
                                                <c:set var="messageColor" value="green" />
                                            </c:if>
                                            <h6 class="mb" style="color: ${messageColor};">${param.discountMessage}</h6>
                                        </c:if>
                                    </form>
                                    <div class="form-group">
                                        <label for="customer-select">Chọn khách hàng:</label>
                                        <form id="payment-form" action="paymentInCashControl" method="GET">
                                            <select class="form-control mb-3" id="customer-select" name="phoneNumber">
                                                <c:forEach var="customer" items="${tableCustomers[tableName]}">
                                                    <option value="${customer.phone_number}">${customer.name} (${customer.phone_number})</option>
                                                </c:forEach>
                                            </select>
                                            <input type="hidden" name="tableName" value="${tableName}">
                                            <input type="hidden" name="totalMoney" value="${tableTotalPrices[tableName] * (1 - cart.discountPercent / 100)}">
                                            <input type="hidden" name="transactiontype" value="Tiền mặt">
                                            <div class="row d-flex justify-content-around">
                                                <button type="submit" class="btn btn-success col-5">Thanh toán bằng tiền mặt</button>
                                                <button class="btn btn-warning col-5 btn-qrcode" data-table="${tableName}" data-total="${tableTotalPrices[tableName] * (1-cart.discountPercent/100)}">QR Code</button>
                                            </div>
                                        </form>

                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </aside>
            </div> 
        </div>
    </div>
</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</html> 
<script>
                        document.getElementById('payment-form').addEventListener('submit', function (event) {
                            var cartStatus = document.getElementById('cartStatus').value;
                            if (cartStatus !== 'Đã xác nhận') {
                                event.preventDefault();
                                alert('Không có giỏ hàng nào đang chờ xác nhận hoặc đã xác nhận để thanh toán.');
                            }
                        });

                        document.querySelectorAll('.btn-qrcode').forEach(button => {
                            button.addEventListener('click', function (event) {
                                event.preventDefault();
                                var cartStatus = document.getElementById('cartStatus').value;
                                if (cartStatus !== 'Đã xác nhận') {
                                    event.preventDefault();
                                    alert('Không có giỏ hàng nào đang chờ xác nhận hoặc đã xác nhận để thanh toán.');
                                } else {
                                    $('#qrModal').modal('show');
                                }
                            });
                        });
                        $(document).ready(function () {

                            $('.mark-served').click(function (e) {
                                e.preventDefault();
                                var button = $(this);
                                var productId = button.data('id');
                                var tableName = button.data('table');
                                var cartId = button.data('cart');
                                console.log('Mark served clicked', tableName, productId, cartId); // Debugging log

                                var confirmMessage = "Bạn xác nhận đã lên món này?";
                                if (confirm(confirmMessage)) {
                                    $.ajax({
                                        url: 'updateServedStatus', // URL của servlet
                                        type: 'POST',
                                        data: {
                                            productId: productId,
                                            served: true, // Bạn có thể đặt giá trị này là true hoặc false tùy vào nhu cầu
                                            tableName: tableName
                                        },
                                        success: function (response) {
                                            console.log('Success:', response); // Debugging log
                                            location.reload(); // Tải lại trang để phản ánh các thay đổi
                                        },
                                        error: function (xhr, status, error) {
                                            console.error('Error:', error); // Debugging log
                                        }
                                    });
                                } else {
                                    return; // Nếu người dùng không xác nhận, không làm gì cả
                                }
                            });

                            $('.cancel-cart').click(function (e) {
                                e.preventDefault();
                                var button = $(this);
                                var tableName = button.data('table');
                                var cartId = button.data('cart');

                                console.log('Cancel cart:', tableName, cartId); // Debugging log

                                if (confirm('Bạn có chắc chắn muốn hủy đơn hàng này không?')) {
                                    $.ajax({
                                        url: 'cancelCart', // Ensure this is the correct URL for your server-side script
                                        type: 'POST',
                                        data: {
                                            tableName: tableName,
                                            cartId: cartId
                                        },
                                        success: function (response) {
                                            console.log('Success:', response); // Debugging log
                                            location.reload(); // Reload the page to reflect changes
                                        },
                                        error: function (xhr, status, error) {
                                            console.error('Error:', error); // Debugging log
                                        }
                                    });
                                }
                            });

                            $('.update-cart-status').click(function (e) {
                                e.preventDefault();
                                var button = $(this);
                                var tableName = button.data('table');
                                var cartId = button.data('cart');
                                var newStatus = 'Đã xác nhận'; // Hoặc trạng thái bạn muốn cập nhật

                                console.log('Table:', tableName, 'Cart ID:', cartId); // Debugging log

                                $.ajax({
                                    url: 'updateStatus', // Đảm bảo URL này là đúng cho servlet xử lý của bạn
                                    type: 'POST',
                                    data: {
                                        tableName: tableName,
                                        cartId: cartId,
                                        status: newStatus
                                    },
                                    success: function (response) {
                                        console.log('Success:', response); // Debugging log
                                        location.reload(); // Tải lại trang để cập nhật thay đổi
                                    },
                                    error: function (xhr, status, error) {
                                        console.error('Error:', error); // Debugging log
                                    }
                                });
                            });

                            $('.update-quantity').click(function (e) {
                                e.preventDefault();
                                var button = $(this);
                                var tableName = button.data('table');
                                var id = button.data('id');
                                var cartId = button.data('cart');
                                var num = button.data('num');

                                console.log('Button clicked', tableName, id, cartId, num);  // Debugging log

                                // Kiểm tra trạng thái của cart
                                var cartStatus = button.closest('.order-summary').find('.update-cart-status').text().trim();

                                // Nếu trạng thái là "Đã xác nhận", không thực hiện tăng/giảm sản phẩm
                                if (cartStatus === 'Đã xác nhận') {
                                    alert('Không thể thay đổi sản phẩm khi đơn hàng đã được xác nhận.');
                                    return; // Dừng hàm và không thực hiện các lệnh dưới đây
                                }

                                $.ajax({
                                    url: 'CRUDCartItem', // Ensure this is the correct URL for your server-side script
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
                                console.log('Button clicked', tableName, id, cartId); // Debugging log

                                var cartStatus = button.closest('.order-summary').find('.update-cart-status').text().trim();
                                // Nếu trạng thái là "Đã xác nhận", không thực hiện tăng/giảm sản phẩm
                                if (cartStatus === 'Đã xác nhận') {
                                    alert('Không thể thay đổi sản phẩm khi đơn hàng đã được xác nhận.');
                                    return; // Dừng hàm và không thực hiện các lệnh dưới đây
                                }

                                $.ajax({
                                    url: 'CRUDCartItem', // Ensure this is the correct URL for your server-side script
                                    type: 'POST',
                                    data: {
                                        tableName: tableName,
                                        cartId: cartId,
                                        id: id
                                    },
                                    success: function (response) {
                                        console.log('Success:', response); // Debugging log
                                        location.reload(); // Reload the page to reflect changes
                                    },
                                    error: function (xhr, status, error) {
                                        console.error('Error:', error); // Debugging log
                                    }
                                });
                            });
                        }
                        );
</script>
