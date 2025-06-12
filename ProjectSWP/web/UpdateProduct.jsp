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
            .custom-file-label::after {
                content: "Chọn tệp khác";
            }
            .image-preview-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-top: 10px;
            }
            .image-preview {
                max-width: 300px;
                width: 100%;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 5px;
                margin-top: 10px;
                display: none;
            }
            .button-container {
                display: flex;
                justify-content: center;
                gap: 10px;
                margin-top: 20px;
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
                        <h2 class="mb-4">Cập nhật sản phẩm</h2>
                        <c:if test="${ms != null}">
                            <h4>${ms}</h4>
                        </c:if>
                        <div class="row">
                            <div class="col-md-12">
                                <form action="updateproduct" method="post" enctype="multipart/form-data">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th class="col-name">Tên sản phẩm</th>
                                                <th class="col-description">Miêu tả</th>
                                                <th class="col-price">Giá thành</th>
                                            </tr>
                                        </thead>
                                        <tbody id="scheduleTable">
                                            <tr>
                                                <td><input class="form-control" type="text" name="productName" value="${productName}" required></td>
                                                <td><textarea class="form-control" name="description" required>${productDescription}</textarea></td>
                                                <td><input class="form-control" type="number" min="0" name="price" value="${productPrice}" required> VNĐ</td>
                                            </tr>
                                            <tr>
                                                <th class="col-category">Thể loại</th>
                                                <th class="col-img">Ảnh minh họa sản phẩm</th>
                                                <th class="col-quantity">Số lượng</th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <select class="form-control" name="category" required onchange="checkOther(this)">
                                                        <option value="${cate.category_id}" selected>${cate.name}</option>
                                                        <c:forEach var="c" items="${listCategorys}">
                                                            <c:if test="${c.category_id != cate.category_id}">
                                                                <option value="${c.category_id}">${c.name}</option>
                                                            </c:if>
                                                        </c:forEach>
                                                        <option value="Other">Other</option>
                                                    </select>
                                                    <input class="form-control mt-2" type="text" id="otherCategory" name="otherCategory" placeholder="Nhập thể loại khác" style="display:none;">
                                                </td>
                                                <td>
                                                    <div class="custom-file">
                                                        <input type="file" class="custom-file-input" id="productImage" name="productImage" accept="image/*" onchange="validateImage(event)">
                                                        <label class="custom-file-label" for="productImage">Chọn hình ảnh khác</label>
                                                    </div>
                                                    <div class="image-preview-container">
                                                        <img id="imagePreview" class="image-preview" src="${productImg}" alt="Ảnh sản phẩm" style="display: ${not empty productImg ? 'block' : 'none'};"/>
                                                    </div>
                                                </td>
                                                <td><input class="form-control" type="number" min="0" name="quality" value="${productQuantity}" required></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <input type="hidden" class="form-control" name="productId" value="${productId}">
                                    <div class="button-container">
                                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                        <a href="managerproducts" class="btn btn-danger">Hủy thay đổi</a>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <script>
                            function checkOther(select) {
                                var otherCategoryInput = document.getElementById('otherCategory');
                                if (select.value === 'Other') {
                                    otherCategoryInput.style.display = 'block';
                                    otherCategoryInput.required = true;
                                } else {
                                    otherCategoryInput.style.display = 'none';
                                    otherCategoryInput.required = false;
                                }
                            }

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
                        </script>

                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
