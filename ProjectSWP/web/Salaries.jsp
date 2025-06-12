<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý lương nhân viên</title>
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
            .salary-table th, .salary-table td {
                text-align: center;
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
                        <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất </a>
                    </div>
                </div>

                <div class="col-md-10 content">
                    <!-- Main Content -->
                    <div class="container mt-4">
                        <h2 class="mb-4">Quản lý lương nhân viên</h2>
                        <div class="row mb-4">
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="searchEmployee" placeholder="Tìm kiếm theo tên nhân viên...">
                            </div>
                            <div class="col-md-4">
                                <input type="month" class="form-control" id="searchDate" placeholder="Lọc theo thời gian">
                            </div>
                            <div class="col-md-4">
                                <form id="updateSalaryForm" action="updatesalaries">
                                    <button class="btn btn-primary" id="updateButton" type="submit">Cập nhật bảng lương của tháng này</button>
                                </form>
                            </div>
                        </div>
                        <c:if test="${param.message3 == 'success'}">
                            <div class="alert alert-success" role="alert">
                                Cập nhật thành công!
                            </div>
                        </c:if>
                        <c:if test="${param.message3 == 'failure'}">
                            <div class="alert alert-danger" role="alert">
                                Lương tháng này đã được cập nhật rồi!
                            </div>
                        </c:if>
                        <form action="" id="salaryForm" method="post">
                            <input type="hidden" name="currentMonth" id="currentMonth">
                            <div class="row">
                                <div class="col-md-12">
                                    <table class="table table-bordered salary-table">
                                        <thead>
                                            <tr>
                                                <th>Tháng</th>
                                                <th>Tên nhân viên</th>
                                                <th>Tổng số giờ làm</th>
                                                <th>Tổng lương</th>
                                            </tr>
                                        </thead>
                                        <tbody id="salaryTable">
                                            <c:forEach var="o" items="${listS}">
                                                <tr>
                                                    <td>${fn:substring(o.month_year, 0, 7)}</td>
                                                    <td>${o.employee.name}</td>
                                                    <td>${o.totalHoursWorked}</td>
                                                    <td>${Math.round(o.total_salary)} VNĐ</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal" id="confirmModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">Xác nhận cập nhật bảng lương</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        Bạn có chắc chắn muốn cập nhật bảng lương của tháng này?
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-primary" id="confirmUpdate">Đồng ý</button>
                    </div>


                </div>
            </div>
        </div>


        <!-- Include Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            document.getElementById('searchEmployee').addEventListener('input', function () {
                filterData();
            });

            document.getElementById('searchDate').addEventListener('change', function () {
                filterData();
            });

            // Lắng nghe sự kiện nhấn vào nút cập nhật
            document.getElementById('updateButton').addEventListener('click', function () {
                // Hiển thị modal popup
                $('#confirmModal').modal('show');
            });

            // Lắng nghe sự kiện nhấn vào nút xác nhận trong modal
            document.getElementById('confirmUpdate').addEventListener('click', function () {
                // Ẩn modal popup
                $('#confirmModal').modal('hide');

                // Gửi form đi
                document.getElementById('updateSalaryForm').submit();
            });

            function filterData() {
                var filterName = document.getElementById('searchEmployee').value.trim().toLowerCase();
                var filterDate = document.getElementById('searchDate').value;

                var rows = document.querySelectorAll('#salaryTable tr');

                rows.forEach(function (row) {
                    var nameCell = row.querySelector('td:nth-child(2)');
                    var dateCell = row.querySelector('td:first-child');

                    if (nameCell && dateCell) {
                        var employeeName = nameCell.textContent.trim().toLowerCase();
                        var rowDate = dateCell.textContent.trim();

                        var nameMatch = employeeName.includes(filterName);
                        var dateMatch = filterDate === '' || rowDate.startsWith(filterDate);

                        if (nameMatch && dateMatch) {
                            row.style.display = '';
                        } else {
                            row.style.display = 'none';
                        }
                    }
                });
            }
        });

        document.getElementById('updateSalaryForm').addEventListener('submit', function (event) {
            event.preventDefault(); // Ngăn chặn hành động mặc định của form
        });


    </script>
</html>
