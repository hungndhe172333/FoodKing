<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lí sản phẩm</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
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
            /* Căn giữa văn bản trong các thẻ <th> */
            thead th {
                text-align: center;
            }
            /* Đặt độ rộng cho các cột */
            .col-name {
                width: 15%;
            }
            .col-price {
                width: 15%;
            }
            .col-quantity,
            .col-category {
                width: 10%;
            }
            .col-description {
                width: 35%;
            }
            .col-actions {
                width: 15%;
            }
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
                        <h2 class="mb-4">Sản phẩm đã ẩn</h2>
                        <div class="row mb-4">
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="search" placeholder="Tìm kiếm sản phẩm...">
                            </div>
                            <div class="col-md-4">
                                <select class="form-control" id="filterCategory" name="filterCategory">
                                    <option value="">Lọc theo loại sản phẩm</option>
                                    <c:forEach var="c" items="${listCategorys}">
                                        <option value="${c.name}">${c.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <button class="btn btn-secondary btn-right" onclick="location.href = 'managerproducts'">Xem sản phẩm đang hiển thị</button>
                            </div>
                        </div>
                        <c:if test="${ms != null}">
                            <h3 style="color: green">${ms}</h3>
                        </c:if>
                        <div class="row">
                            <div class="col-md-12">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th class="col-name">Tên sản phẩm</th>
                                            <th class="col-quantity">Số lượng</th>
                                            <th class="col-price">Giá thành</th>
                                            <th class="col-description">Miêu tả</th>
                                            <th class="col-category">Thể loại</th>
                                            <th class="col-actions">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody id="productTable">
                                        <c:forEach var="product" items="${listP}">
                                            <tr>
                                                <td>${product.name}</td>
                                                <td>${product.stock_quantity}</td>
                                                <td>${Math.round(product.price)} VNĐ</td>
                                                <td>${product.description}</td>
                                                <td>${product.category_id.name}</td>
                                                <td> 
                                                    <button class="btn btn-sm btn-success" onclick="confirmShowProduct(${product.product_id})">Hiển thị sản phẩm</button> 
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <script>
                            function confirmShowProduct(productId) {
                                Swal.fire({
                                    title: 'Bạn có chắc chắn?',
                                    text: "Bạn có chắc chắn muốn hiển thị sản phẩm này không?",
                                    icon: 'warning',
                                    showCancelButton: true,
                                    confirmButtonColor: '#3085d6',
                                    cancelButtonColor: '#d33',
                                    confirmButtonText: 'Có, hiển thị sản phẩm này',
                                    cancelButtonText: 'Hủy'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        location.href = 'showproduct?id=' + productId;
                                    }
                                });
                            }

                            document.addEventListener('DOMContentLoaded', function () {
                                const searchInput = document.getElementById('search');
                                const filterCategory = document.getElementById('filterCategory');
                                const productTable = document.getElementById('productTable');

                                searchInput.addEventListener('input', filterTable);
                                filterCategory.addEventListener('change', filterTable);

                                function filterTable() {
                                    const searchValue = searchInput.value.toLowerCase();
                                    const categoryValue = filterCategory.value;
                                    const rows = productTable.getElementsByTagName('tr');

                                    Array.from(rows).forEach(row => {
                                        const cells = row.getElementsByTagName('td');
                                        const productName = cells[0].textContent.toLowerCase();
                                        const productCategory = cells[4].textContent;
                                        const matchesSearch = productName.includes(searchValue);
                                        const matchesCategory = !categoryValue || productCategory === categoryValue;

                                        if (matchesSearch && matchesCategory) {
                                            row.style.display = '';
                                        } else {
                                            row.style.display = 'none';
                                        }
                                    });
                                }
                            });
                        </script>
                        <!-- Include Bootstrap JS -->
                        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
                        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
                        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                        </body>
                        </html>
