<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý bàn ăn</title>
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
            thead th {
                text-align: center;
            }
            .col-name {
                width: 20%;

            }
            .col-qr_code {
                width: 20%;
            }
            .imgQrcode {
                width: 150px;
                height: 150px
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
                        <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                    </div>
                </div>
                <div class="col-md-10 content">
                    <!-- Main Content -->
                    <div class="container mt-4">
                        <h2 class="mb-4"><i class="fas fa-ticket-alt"></i> Phiếu giảm giá</h2>

                        <form action="searchdiscount" method="post" class="row mb-4">
                            <div class="  col-md-4">                           
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa fa-search"></i></span>
                                    <input  name="txtD" id="search" type="text" class="form-control"  placeholder="Tìm kiếm phiếu giảm giá..."> <br/>
                                </div>

                            </div>

                        </form>
                        <button class="btn btn-secondary btn-right" onclick="location.href = 'hidediscount'"><i class="fas fa-eye-slash"></i> Xem phiếu đã ẩn</button>
                        <div>
                            <br/>
                            <c:if test="${ms != null}">
                                <h3 style="color: green">${ms}</h3>
                            </c:if>
                            <div class="row">
                                <div class="col-md-12">
                                    <table class="table table-bordered" id="discountTable">
                                        <thead>
                                            <tr>
                                                <th class="col-name"><i class="fas fa-ticket-alt"></i> Mã giảm giá</th>
                                                <th class="col-qr_code"><i class="fas fa-percent"></i> Giảm giá</th>
                                                <th class="col-qr_code"><i class="fas fa-sign-language"></i> Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody id="discountList">
                                            <c:forEach var="discount" items="${listD}">
                                                <tr>
                                                    <td>${discount.code}</td>
                                                    <td>${Math.round(discount.discountPercentage)}</td>   
                                                    <td>
                                                        <button class="btn btn-sm btn-success" onclick="confirmHideDiscount(${discount.discountId})"><i class="fas fa-eye-slash"></i> Ẩn Phiếu</button> 
                                                        <button class="btn btn-sm btn-primary edit-discount-btn" data-toggle="modal" data-target="#editDiscountModal" data-id="${discount.discountId}" data-code="${discount.code}" data-percentage="${discount.discountPercentage}"><i class="fas fa-edit"></i></button> 
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <button class="btn btn-primary" data-toggle="modal" data-target="#addDiscountModal">Thêm Phiếu</button>

                            <!-- Add Discount Modal -->
                            <div class="modal fade" id="addDiscountModal" tabindex="-1" role="dialog" aria-labelledby="addDiscountModalLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="addDiscountModalLabel">Thêm Phiếu Mới</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="insertdiscount" method="post">
                                                <div class="form-group">
                                                    <label for="code"><i class="fas fa-table"></i> Mã giảm giá</label>
                                                    <input type="text" class="form-control" name="code1" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="discountPercentage"><i class="fas fa-percent"></i> Giảm giá</label>
                                                    <input type="number" min="0" class="form-control" name="discountPercentage1" required>
                                                </div>
                                                <button type="submit" class="btn btn-primary">Lưu</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Edit Discount Modal -->
                            <div class="modal fade" id="editDiscountModal" tabindex="-1" role="dialog" aria-labelledby="editDiscountModalLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="editDiscountModalLabel">Chỉnh Sửa Thông Tin Phiếu Giảm Giá</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="editdiscount" method="POST">
                                                <input type="hidden" id="editDiscountId" name="discountId">
                                                <div class="form-group">
                                                    <label for="editCode">Phiếu giảm giá</label>
                                                    <input type="text" class="form-control" id="editCode" name="code" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="editDiscountPercentage"> <i class="fas fa-percent"></i> giảm giá</label>
                                                    <input type="text" class="form-control" id="editDiscountPercentage" name="discountPercentage" placeholder="Bạn cần nhập số %" required>
                                                </div>
                                                <button type="submit" class="btn btn-primary">Lưu</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- JavaScript to handle the data loading into the modal -->
                            <script>
                                document.addEventListener('DOMContentLoaded', function () {
                                    const editButtons = document.querySelectorAll('#discountTable .edit-discount-btn');
                                    editButtons.forEach(button => {
                                        button.addEventListener('click', function () {
                                            const discountId = this.getAttribute('data-id');
                                            const code = this.getAttribute('data-code');
                                            const discountPercentage = this.getAttribute('data-percentage');

                                            document.getElementById('editDiscountId').value = discountId;
                                            document.getElementById('editCode').value = code;
                                            document.getElementById('editDiscountPercentage').value = discountPercentage;
                                        });
                                    });
                                });




                                function validateImage(event) {
                                    var file = event.target.files[0];
                                    if (!file.type.match('image.*')) {
                                        alert("Chỉ cho phép tệp hình ảnh!");
                                        event.target.value = ""; // Xóa lựa chọn tệp
                                        return false;
                                    } else {
                                        previewImage(event);
                                    }
                                    return true; // Cho phép previewImage tiếp tục
                                }

                                function previewImage(event) {
                                    var imagePreview = document.getElementById('imagePreview');
                                    var reader = new FileReader();
                                    reader.onload = function () {
                                        if (reader.readyState == 2) {
                                            imagePreview.src = reader.result;
                                            imagePreview.style.display = 'block';
                                        }
                                    };
                                    reader.onerror = function (error) {
                                        console.error("Error reading image:", error);
                                    };
                                    reader.readAsDataURL(event.target.files[0]);
                                }

                                function confirmHideDiscount(discount_Id) {
                                    Swal.fire({
                                        title: 'Bạn có chắc chắn?',
                                        text: "Bạn có chắc chắn muốn ẩn phiếu này không?",
                                        icon: 'warning',
                                        showCancelButton: true,
                                        confirmButtonColor: '#3085d6',
                                        cancelButtonColor: '#d33',
                                        confirmButtonText: 'Có, ẩn phiếu này',
                                        cancelButtonText: 'Hủy'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            location.href = 'hidediscount?id=' + discount_Id;
                                        }
                                    });
                                }
                                function confirmShowDiscount(discountId) {
                                    Swal.fire({
                                        title: 'Bạn có chắc chắn?',
                                        text: "Bạn có chắc chắn muốn hiển thị bàn này không?",
                                        icon: 'warning',
                                        showCancelButton: true,
                                        confirmButtonColor: '#3085d6',
                                        cancelButtonColor: '#d33',
                                        confirmButtonText: 'Có, hiển thị bàn này',
                                        cancelButtonText: 'Hủy'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            location.href = 'showDiscount?id=' + discountId;
                                        }
                                    });
                                }

                                function searchDiscount(param) {
                                    var txtSearch = param.value;
                                    $.ajax({
                                        url: "searchdiscount",
                                        type: "get", //send it through get method
                                        data: {
                                            txt: txtSearch
                                        },
                                        success: function (data) {
                                            var row = document.getElementById("content");
                                            row.innerHTML = data;
                                        },
                                        error: function (xhr) {
                                            //Do Something to handle error
                                        }
                                    });
                                }

                                document.addEventListener('DOMContentLoaded', function () {
                                    const searchInput = document.getElementById('search');
                                    const discountList = document.getElementById('discountList');

                                    searchInput.addEventListener('input', filterTable);

                                    function filterTable() {
                                        const searchValue = searchInput.value.toLowerCase();
                                        const rows = discountList.getElementsByTagName('tr');

                                        Array.from(rows).forEach(row => {
                                            const cells = row.getElementsByTagName('td');
                                            const tableName = cells[0].textContent.toLowerCase();
                                            const matchesSearch = tableName.includes(searchValue);

                                            if (matchesSearch) {
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
                        </div>
                    </div>
                </div>
            </div>
    </body>
</html>
