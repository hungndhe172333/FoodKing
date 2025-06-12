<%-- 
    Document   : ManagerAccount
    Created on : May 26, 2024, 8:05:17 PM
    Author     : minhp
--%>

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
                        <h2 class="mb-4">Danh Sách Nhân Viên</h2>
                        <div class="row mb-4">
                            <div class="col-md-12">
                                                                <input type="text" class="form-control" id="search" placeholder="Tìm kiếm nhân viên...">
                            </div>

                        </div>
                        <div id="result" class="text-danger mt-2"></div>
                        <c:if test="${param.message == 'success'}">
                            <div class="alert alert-success" role="alert">
                                Đăng ký ca làm thành công!
                            </div>
                        </c:if>
                        <c:if test="${param.message == 'failure'}">
                            <div class="alert alert-danger" role="alert">
                                Đăng ký ca làm thất bại, Nhân viên đã đăng kí ca làm này rồi!
                            </div>
                        </c:if>
                        <c:if test="${param.message2 == 'success'}">
                            <div class="alert alert-success" role="alert">
                                Xóa ca làm thành công!
                            </div>
                        </c:if>
                        <c:if test="${param.message2 == 'failure'}">
                            <div class="alert alert-danger" role="alert">
                                Xóa ca làm thất bại, Nhân viên không có ca làm này rồi!
                            </div>
                        </c:if>
                        <div class="row">
                            <div class="col-md-12">
                                <table class="table table-bordered" id="employeeTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên</th>
                                            <th>Số điện thoại</th>
                                            <th>Trạng thái</th>
                                            <th>Lương theo giờ</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Example data, replace with dynamic content -->
                                        <c:forEach var="o" items="${listE}">
                                            <tr>
                                                <td>${o.employee_id}</td>
                                                <td>${o.name}</td>
                                                <td>${o.phone_number}</td>
                                                <td>${o.employment_status}</td>
                                                <td>${Math.round(o.hourly_wage_rate)} VNĐ</td>
                                                <td>
                                                    <button class="btn btn-sm btn-primary edit-employee-btn" data-toggle="modal" data-target="#editEmployeeModal">Sửa</button>
                                                    <button class="btn btn-sm btn-primary register-shift-btn" data-toggle="modal" data-target="#registerShiftModal">Đăng Ký Ca Làm</button> 
                                                    <button class="btn btn-sm btn-danger delete-shift-btn" data-toggle="modal" data-target="#deleteShiftModal" data-employee-id="${o.employee_id}">Xóa Ca Làm</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!--                        <button class="btn btn-primary" data-toggle="modal" data-target="#addEmployeeModal">Thêm Nhân Viên</button>-->
                    </div>
                </div>
            </div>
        </div>

        <!-- Add Employee Modal -->
        <div class="modal fade" id="addEmployeeModal" tabindex="-1" role="dialog" aria-labelledby="addEmployeeModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addEmployeeModalLabel">Thêm Nhân Viên Mới</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="addEmployee">
                            <div class="form-group">
                                <label for="name">Tên</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">Số điện thoại</label>
                                <input type="text" class="form-control" id="phone" name="phone" required>
                            </div>
                            <div class="form-group">
                                <label for="status">Trạng thái</label>
                                <select class="form-control" id="status" name="status">
                                    <option value="Đang làm việc">Đang làm việc</option>
                                    <option value="Đã nghỉ việc">Đã nghỉ việc</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="hourly_wage_rate">Lương theo giờ</label>
                                <input type="number" min="0" class="form-control" id="hourly" name="hourly_wage_rate" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Thêm</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Employee Modal -->
        <div class="modal fade" id="editEmployeeModal" tabindex="-1" role="dialog" aria-labelledby="editEmployeeModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editEmployeeModalLabel">Chỉnh Sửa Thông Tin Nhân Viên</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="editEmployee">
                            <input type="hidden" id="editEmployeeId" name="employee_id">
                            <div class="form-group">
                                <label for="editName">Tên</label>
                                <input type="text" class="form-control" id="editName" name="name" readonly>
                            </div>
                            <div class="form-group">
                                <label for="editPhone">Số điện thoại</label>
                                <input type="text" class="form-control" id="editPhone" name="phone" readonly>
                            </div>
                            <div class="form-group">
                                <label for="editStatus">Trạng thái</label>
                                <select class="form-control" id="editStatus" name="status">
                                    <option value="Đang làm việc">Đang làm việc</option>
                                    <option value="Đã nghỉ việc">Đã nghỉ việc</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="hourly_wage_rate">Lương theo giờ</label>
                                <input type="text" class="form-control" id="hourly_wage_rate" name="hourly_wage_rate" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Register Shift Modal -->
        <div class="modal fade" id="registerShiftModal" tabindex="-1" role="dialog" aria-labelledby="registerShiftModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="registerShiftModalLabel">Đăng Ký Ca Làm</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="registerWorkShift" >
                            <div class="form-group">
                                <input type="hidden" class="form-control" id="employeeId" name="employee_id" readonly>
                            </div>
                            <div class="form-group">
                                <label for="shiftPattern">Ca Làm</label>
                                <select class="form-control" id="shiftPattern" name="shiftPattern" required>
                                    <c:forEach var="shift" items="${listS}">
                                        <option value="${shift.pattern_id}">${shift.pattern_name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Đăng Ký</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Shift Modal -->
        <div class="modal fade" id="deleteShiftModal" tabindex="-1" role="dialog" aria-labelledby="deleteShiftModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteShiftModalLabel">Xóa Ca Làm</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="deleteWorkShiftControl" method="post">
                            <input type="hidden" id="deleteEmployeeId" name="employee_id">
                            <div class="form-group">
                                <label for="deletePattern">Ca Làm</label>
                                <select class="form-control" id="deletePattern" name="deletePattern" required>
                                    <c:forEach var="w" items="${listW}">
                                        <option value="${w.shift_pattern.pattern_id}" data-employee-id="${w.employee.employee_id}">${w.shift_pattern.pattern_name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-danger">Xóa</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>



        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
    <script>
       
        document.getElementById('search').addEventListener('keyup', function () {
            let searchValue = this.value.toLowerCase();
            let rows = document.querySelectorAll('#employeeTable tbody tr');
            rows.forEach(row => {
                let name = row.cells[1].textContent.toLowerCase();
                if (name.includes(searchValue)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });

        const editButtons = document.querySelectorAll('#employeeTable .edit-employee-btn');
        editButtons.forEach(button => {
            button.addEventListener('click', function (event) {
                const row = event.target.closest('tr');
                const employeeId = row.cells[0].textContent;
                const name = row.cells[1].textContent;
                const phone = row.cells[2].textContent;
                const status = row.cells[3].textContent;
                const hourly_wage_rate = row.cells[4].textContent;

                document.getElementById('editEmployeeId').value = employeeId;
                document.getElementById('editName').value = name;
                document.getElementById('editPhone').value = phone;
                document.getElementById('editStatus').value = status;
                document.getElementById('hourly_wage_rate').value = hourly_wage_rate;
            });
        });

        // JavaScript cho phần đăng ký ca làm
        const registerButtons = document.querySelectorAll('#employeeTable .register-shift-btn');
        registerButtons.forEach(button => {
            button.addEventListener('click', function (event) {
                const row = event.target.closest('tr');
                const employeeId = row.cells[0].textContent;

                document.getElementById('employeeId').value = employeeId;
            });
        });

        // JavaScript for deleting a shift
        document.addEventListener('DOMContentLoaded', function () {
            // JavaScript for deleting a shift
            const deleteButtons = document.querySelectorAll('#employeeTable .delete-shift-btn');
            deleteButtons.forEach(button => {
                button.addEventListener('click', function (event) {
                    // Lấy employee_id từ thuộc tính data-employee-id
                    const employeeId = event.currentTarget.getAttribute('data-employee-id');

                    // Đặt giá trị cho input hidden với id là deleteEmployeeId
                    document.getElementById('deleteEmployeeId').value = employeeId;

                    // Lấy danh sách các ca làm của nhân viên từ danh sách tổng thể
                    const shiftOptions = document.querySelectorAll('#deletePattern option');
                    shiftOptions.forEach(option => {
                        if (option.getAttribute('data-employee-id') == employeeId) {
                            option.style.display = ''; // Hiển thị các ca làm của nhân viên
                        } else {
                            option.style.display = 'none'; // Ẩn các ca làm không thuộc về nhân viên
                        }
                    });

                    // Mở modal sau khi nội dung đã được cập nhật
                    $('#deleteShiftModal').modal('show');
                });
            });
        });


    </script>
</html>