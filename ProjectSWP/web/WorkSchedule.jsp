<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manager Account</title>
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
            .attendance-table th, .attendance-table td {
                text-align: center;
                vertical-align: middle;
            }
            .attendance-table th {
                position: sticky;
                top: 0;
                background-color: #f8f9fa;
            }
            .modal-content {
                padding: 20px;
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
                            <p>Xin chào ${sessionScope.employ.email}</p>
                        </c:if>
                        <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất </a>
                    </div>
                </div>
                <div class="col-md-10 content">
                    <!-- Main Content -->
                    <div class="container mt-4">
                        <h2 class="mb-4">Quản lý Chấm Công Nhân Viên</h2>
                        <!-- Attendance Form -->
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label for="employeeId" class="sr-only">Tên nhân viên</label>
                                <input type="text" class="form-control" id="employeeName" name="employeeName" placeholder="Tên nhân viên">
                            </div>
                            <div class="col-md-3 mb-3">
                                <form action="filterAttendance" class="form-inline">
                                    <div class="form-group mx-sm-3 ">
                                        <label for="month" class="sr-only">Tháng</label>
                                        <input type="month" class="form-control" id="month" name="month" required>
                                    </div>
                                </form>
                            </div>
                            <div class="col-md-3 mb-3">
                                <form action="attendance">
                                    <button type="submit" class="btn btn-primary mb-2">Cập nhật lịch làm việc hôm nay</button>
                                </form>
                            </div>
                        </div>

                        <c:if test="${requestScope.message == 'success'}">
                            <div class="alert alert-success" role="alert">
                                Cập nhật thành công!
                            </div>
                        </c:if>
                        <c:if test="${requestScope.message == 'failure'}">
                            <div class="alert alert-danger" role="alert">
                                Cập nhật thất bại do hôm nay đã cập nhật rồi!
                            </div>
                        </c:if>

                        <!-- Attendance Table -->
                        <div class="table-responsive">
                            <table class="table table-bordered attendance-table" id="employeeTable">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Ngày</th>
                                        <th>Tên</th>
                                        <th>Ca làm</th>
                                        <th>Thời gian</th>
                                        <th>Trạng thái</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody id="attendanceTableBody">
                                    <c:forEach items="${attendanceRecords}" var="record">
                                        <tr>
                                            <td>${record.attendance_id}</td>
                                            <td>${record.working_date}</td>
                                            <td>${record.workShift.employee.name}</td>
                                            <td>${record.workShift.shift_pattern.pattern_name}</td>
                                            <td>${record.workShift.shift_pattern.start_time}-${record.workShift.shift_pattern.end_time}</td>
                                            <td>${record.attendance_status}</td>
                                            <td>
                                                <button class="btn btn-success btn-sm check-in-employee-btn" data-toggle="modal" data-target="#checkInModal">Check-in</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal for Check-in -->
        <div class="modal fade" id="checkInModal" tabindex="-1" role="dialog" aria-labelledby="checkInModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="checkInModalLabel">Check-in Employee</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="updateAttendance" id="checkInForm">
                            <div class="form-group">
                                <input type="hidden" class="form-control" id="attendanceID" name="attendance_id" readonly>
                            </div>
                            <div class="form-group">
                                <label for="workDate">Ngày</label>
                                <input type="date" class="form-control" id="workDate" name="workDate" readonly>
                            </div>
                            <div class="form-group">
                                <label for="employeeNameModal">Tên</label>
                                <input type="text" class="form-control" id="employeeNameModal" name="employeeNameModal" readonly>
                            </div>
                            <div class="form-group">
                                <label for="shift">Ca làm</label>
                                <input type="text" class="form-control" id="shift" name="shift" readonly>
                            </div>
                            <div class="form-group">
                                <label for="shift">Thời gian</label>
                                <input type="text" class="form-control" id="time" name="time" readonly>
                            </div>
                            <div class="form-group">
                                <label for="status">Trạng thái</label>
                                <select class="form-control" id="modalStatus" name="modalStatus" required>
                                    <option value="Có mặt">Có mặt</option>
                                    <option value="Vắng mặt">Vắng mặt</option>
                                    <option value="Muộn">Muộn</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Các tệp JS cần thiết -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>

            document.getElementById('employeeName').addEventListener('input', function () {
                filterData();
            });

            document.getElementById('month').addEventListener('change', function () {
                filterData();
            });

            function filterData() {
                var filterName = document.getElementById('employeeName').value.trim().toLowerCase();
                var filterMonth = document.getElementById('month').value;

                var tableBody = document.getElementById('attendanceTableBody');
                var rows = tableBody.getElementsByTagName('tr');

                for (var i = 0; i < rows.length; i++) {
                    var nameCell = rows[i].getElementsByTagName('td')[2];
                    var dateCell = rows[i].getElementsByTagName('td')[1];

                    if (nameCell && dateCell) {
                        var employeeName = nameCell.textContent.trim().toLowerCase();
                        var date = new Date(dateCell.textContent || dateCell.innerText);
                        var rowMonth = date.getMonth() + 1;
                        var rowYear = date.getFullYear();
                        var filterYearMonth = filterMonth.split('-');

                        var nameMatch = employeeName.includes(filterName);
                        var monthMatch = rowMonth == filterYearMonth[1] && rowYear == filterYearMonth[0];

                        if ((!filterName || nameMatch) && (!filterMonth || monthMatch)) {
                            rows[i].style.display = '';
                        } else {
                            rows[i].style.display = 'none';
                        }
                    }
                }
            }

            // Lắng nghe sự kiện click trên nút check-in
            $('.check-in-employee-btn').click(function () {
                // Lấy thông tin từ thuộc tính data của nút check-in
                var attendanceId = $(this).closest('tr').find('td:eq(0)').text();
                var workDate = $(this).closest('tr').find('td:eq(1)').text();
                var employeeName = $(this).closest('tr').find('td:eq(2)').text();
                var shift = $(this).closest('tr').find('td:eq(3)').text();
                var time = $(this).closest('tr').find('td:eq(4)').text();

                // Cập nhật giá trị của các trường trong modal
                $('#attendanceID').val(attendanceId);
                $('#workDate').val(workDate);
                $('#employeeNameModal').val(employeeName);
                $('#shift').val(shift);
                $('#time').val(time);
            });

            //loc theo thang
            document.getElementById('month').addEventListener('change', function () {
                var filterMonth = this.value;
                var tableBody = document.getElementById('attendanceTableBody');
                var rows = tableBody.getElementsByTagName('tr');

                for (var i = 0; i < rows.length; i++) {
                    var dateCell = rows[i].getElementsByTagName('td')[1]; // Lấy ô chứa ngày làm việc
                    if (dateCell) {
                        var date = new Date(dateCell.textContent || dateCell.innerText); // Chuyển thành đối tượng Date
                        var rowMonth = date.getMonth() + 1; // Lấy tháng (0-11) và cộng thêm 1
                        var rowYear = date.getFullYear(); // Lấy năm
                        var filterYearMonth = filterMonth.split('-'); // Tách chuỗi năm-tháng

                        if (filterMonth === "") {
                            // Nếu người dùng chọn "clear", hiển thị lại tất cả các bản ghi
                            rows[i].style.display = '';
                        } else if (rowMonth == filterYearMonth[1] && rowYear == filterYearMonth[0]) {
                            rows[i].style.display = '';
                        } else {
                            rows[i].style.display = 'none';
                        }
                    }
                }
            });

        </script>
    </body>
</html>
