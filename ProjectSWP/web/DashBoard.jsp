<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Giao Dịch</title>
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
            .table th, .table td {
                vertical-align: middle;
            }
            .dashboard-card {
                margin-bottom: 20px;
                padding: 20px;
                border-radius: 5px;
                background: #fff;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                text-align: center;
                display: flex;
                flex-direction: column;
                justify-content: center;
                height: 100%;
            }
            .dashboard-card h3 {
                margin-bottom: 15px;
                font-size: 1.5rem;
            }
            .dashboard-row {
                display: flex;
                flex-wrap: wrap;
            }
            .dashboard-col {
                flex: 1;
                padding: 10px;
                min-width: 300px;
            }
            .chart-container {
                position: relative;
                margin: auto;
                height: 300px;
                width: 100%;
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
                        <a href="Profile.jsp"><i class="fas fa-user"></i> Hồ sơ</a>
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
                            <p>Xin chào ${sessionScope.employ.name}</p>
                        </c:if>
                        <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất </a>
                    </div>
                </div>
                <div class="col-md-10 content">
                    <!-- Main Content -->
                    <div class="container mt-4">
                        <h2 class="mb-4">Trang chủ</h2>
                        <div class="row">
                            <div class="col-6">
                                <form id="monthForm" action="dashboard" method="post">
                                    <select id="monthSelector" name="selectedMonth" class="form-control mb-3">
                                        <c:if test="${testD == false}">
                                            <option value="0" ${selectedMonth == 0 ? 'selected' : ''}> --- Chọn để xem theo tháng --- </option>
                                        </c:if>
                                        <option value="1" ${selectedMonth == 1 ? 'selected' : ''}>Tháng 1</option>
                                        <option value="2" ${selectedMonth == 2 ? 'selected' : ''}>Tháng 2</option>
                                        <option value="3" ${selectedMonth == 3 ? 'selected' : ''}>Tháng 3</option>
                                        <option value="4" ${selectedMonth == 4 ? 'selected' : ''}>Tháng 4</option>
                                        <option value="5" ${selectedMonth == 5 ? 'selected' : ''}>Tháng 5</option>
                                        <option value="6" ${selectedMonth == 6 ? 'selected' : ''}>Tháng 6</option>
                                        <option value="7" ${selectedMonth == 7 ? 'selected' : ''}>Tháng 7</option>
                                        <option value="8" ${selectedMonth == 8 ? 'selected' : ''}>Tháng 8</option>
                                        <option value="9" ${selectedMonth == 9 ? 'selected' : ''}>Tháng 9</option>
                                        <option value="10" ${selectedMonth == 10 ? 'selected' : ''}>Tháng 10</option>
                                        <option value="11" ${selectedMonth == 11 ? 'selected' : ''}>Tháng 11</option>
                                        <option value="12" ${selectedMonth == 12 ? 'selected' : ''}>Tháng 12</option>
                                    </select>
                                    <c:if test="${selectedMonth != 0}">
                                        <select id="daySelector" name="selectedDay" class="form-control mb-3">
                                            <c:if test="${selectedDay == 0}">
                                                <option value="0" selected> --- Chọn để xem theo ngày --- </option>
                                            </c:if>
                                            <c:forEach var="day" begin="1" end="${daysInMonth}">
                                                <option value="${day}" ${selectedDay == day ? 'selected' : ''}>Ngày ${day}</option>
                                            </c:forEach>
                                        </select>
                                    </c:if>
                                    <input type="hidden" id="selectedDate" name="selectedDate" value="${selectedMonth}-${selectedDay}">
                                </form>
                            </div>
                            <div class="col-6">
                                <form action="dashboard" method="get">
                                    <button type="submit" class="form-control btn-success"> Xem cả năm </button>
                                </form>
                            </div>
                        </div>
                        <div class="dashboard-row">
                            <div class="dashboard-col">
                                <div class="dashboard-card">
                                    <h3>Tổng Số Giao Dịch</h3>
                                    <p><strong>${totalTranHis}</strong></p>
                                </div>
                            </div>
                            <div class="dashboard-col">
                                <div class="dashboard-card">
                                    <h3>Doanh Thu Tổng Cộng</h3>
                                    <p><strong><span id="formattedTotalRevenue">${totalRevenue}</span> VNĐ</strong></p>
                                    <script>
                                        const totalRevenueElement = document.getElementById("formattedTotalRevenue");
                                        totalRevenueElement.textContent = Number(totalRevenueElement.textContent).toLocaleString("vi-VN");
                                    </script>
                                </div>
                            </div>
                            <div class="dashboard-col">
                                <div class="dashboard-card">
                                    <h3>Giá Trị Trung Bình Mỗi Giao Dịch</h3>
                                    <p><strong><span id="formattedAvgEveryTrans">${avgEveryTrans}</span> VNĐ</strong></p>
                                    <script>
                                        const avgEveryTransElement = document.getElementById("formattedAvgEveryTrans");
                                        avgEveryTransElement.textContent = Number(avgEveryTransElement.textContent).toLocaleString("vi-VN");
                                    </script>
                                </div>
                            </div>
                        </div>
                        <div class="dashboard-row">
                            <div class="dashboard-col">
                                <div class="dashboard-card">
                                    <h3>Sản Phẩm Bán Chạy</h3>
                                    <canvas id="topProductsChart"></canvas>
                                </div>
                            </div>
                            <div class="dashboard-col">
                                <div class="dashboard-card">
                                    <h3>Phương Thức Thanh Toán Phổ Biến</h3>
                                    <canvas id="paymentMethodsChart"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="dashboard-row">
                            <div class="dashboard-col">
                                <div class="dashboard-card" id="transactionSection">
                                    <c:if test="${testD == true}">
                                        <h3>Số Lượng Giao Dịch Theo Ngày Trong Tháng</h3>
                                    </c:if>
                                    <c:if test="${testD == false}">
                                        <h3>Số Lượng Giao Dịch Theo Tháng</h3>
                                    </c:if>
                                    <div class="chart-container">
                                        <canvas id="transactionsPerDayChart"></canvas>
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
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <c:if test="${totalTranHis == 0}">
            <script>
                                        $(document).ready(function () {
                                            Swal.fire({
                                                title: 'Thông báo',
                                                allowOutsideClick: false,
                                                text: 'Không có giao dịch nào !',
                                                icon: 'info',
                                                confirmButtonText: 'Quay về xem cả năm'
                                            }).then((result) => {
                                                if (result.isConfirmed) {
                                                    window.location.href = 'dashboard'; // Chuyển hướng đến doGet của dashboard
                                                }
                                            });
                                        });
            </script>
        </c:if>
        <c:if test="${testD && totalTranHis != 0 && selectedDay == 0}">
            <script>
                $(document).ready(function () {
                    const monthNames = ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"];
                    const selectedMonth = ${selectedMonth};
                    Swal.fire({
                        title: 'THÔNG BÁO',
                        text: "Bạn đang xem thông tin của " + monthNames[selectedMonth - 1] + "!",
                        icon: 'info',
                        confirmButtonText: 'ĐÃ RÕ !'
                    });
                });
            </script>
        </c:if>
        <c:if test="${testD == false && totalTranHis != 0}">
            <script>
                $(document).ready(function () {
                    Swal.fire({
                        title: 'THÔNG BÁO',
                        text: "Bạn đang xem thông tin CẢ NĂM !",
                        icon: 'info',
                        confirmButtonText: 'ĐÃ RÕ !'
                    });
                });
            </script>
        </c:if>
        <script>
            $(document).ready(function () {
                const topProductsCtx = document.getElementById('topProductsChart').getContext('2d');
                // Prepare data from the server-side
                const productNames = [];
                const quantities = [];
            <c:forEach var="detail" items="${listOrderDetails}">
                productNames.push('${detail.product.name}');
                quantities.push(${detail.quantity});
            </c:forEach>

                const topProductsChart = new Chart(topProductsCtx, {
                    type: 'bar',
                    data: {
                        labels: productNames,
                        datasets: [{
                                label: 'Số lượng bán',
                                data: quantities,
                                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                borderColor: 'rgba(75, 192, 192, 1)',
                                borderWidth: 1
                            }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
                const paymentMethodsCtx = document.getElementById('paymentMethodsChart').getContext('2d');
                const paymentMethodsChart = new Chart(paymentMethodsCtx, {
                    type: 'pie',
                    data: {
                        labels: ['Thanh toán tiền mặt', 'Chuyển khoản'],
                        datasets: [{
                                data: [${tranTypeOff}, ${tranTypeOnl}],
                                backgroundColor: [
                                    'rgba(255, 99, 132, 0.2)',
                                    'rgba(54, 162, 235, 0.2)'
                                ],
                                borderColor: [
                                    'rgba(255, 99, 132, 1)',
                                    'rgba(54, 162, 235, 1)'
                                ],
                                borderWidth: 1
                            }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'top'
                            },
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        let label = context.label || '';
                                        if (label) {
                                            label += ': ';
                                        }
                                        label += context.raw;
                                        return label;
                                    }
                                }
                            }
                        }
                    }
                });
                const transactionsPerDayCtx = document.getElementById('transactionsPerDayChart').getContext('2d');
                let transactionsPerDayChart;
                
                const listDay = [<c:forEach var="day" items="${listDay}">${day},</c:forEach>];
                function updateTransactionsPerDayChart(month) {
                    if (transactionsPerDayChart) {
                        transactionsPerDayChart.destroy();
                    }

                    transactionsPerDayChart = new Chart(transactionsPerDayCtx, {
                        type: 'line',
                        data: {
                            labels: Array.from({length: listDay.length}, (_, i) => i + 1),
                            datasets: [{
                                    label: 'Số lượng giao dịch',
                                    data: listDay,
                                    backgroundColor: 'rgba(255, 159, 64, 0.2)',
                                    borderColor: 'rgba(255, 159, 64, 1)',
                                    borderWidth: 1,
                                    fill: false,
                                    tension: 0.4
                                }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                                y: {
                                    beginAtZero: true
                                },
                                x: {
                                    display: true
                                }
                            }
                        }
                    });
                }

                document.getElementById('monthSelector').addEventListener('change', function () {
                    updateTransactionsPerDayChart(this.value);
                    $('#monthForm').submit();
                });
                updateTransactionsPerDayChart(1); 
            });

            $(document).ready(function () {
                $('#monthSelector, #daySelector').on('change', function () {
                    const month = $('#monthSelector').val();
                    const day = $('#daySelector').val();
                    $('#selectedDate').val(month + '-' + day);
                    $('#monthForm').submit();
                });
            });
        </script>
    </body>
</html>
