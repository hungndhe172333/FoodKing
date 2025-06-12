<%-- 
    Document   : CustomerInfo
    Created on : Jun 22, 2024, 8:24:39 PM
    Author     : minhp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${param.tableName}</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: sans-serif;
                background-color: #f4f4f4;
            }

            .container {
                max-width: 400px; /* Sử dụng max-width để khung tự co lại khi màn hình nhỏ */
                margin: 50px auto;
                padding: 30px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                margin-bottom: 25px;
                color: #333;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="tel"] {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }

            button {
                display: block;
                width: 100%;
                padding: 12px 20px;
                background-color: #d35400;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            button:hover {
                background-color: #c0392b;
            }
        </style>

        <script>
            function validatePhoneNumber(phoneNumber) {
                var phoneRegex = /^[0-9]{10,11}$/;
                return phoneRegex.test(phoneNumber);
            }

            function validateForm() {
                var phoneNumber = document.getElementById("phoneNumber").value;
                if (!validatePhoneNumber(phoneNumber)) {
                    alert("Số điện thoại phải có 10 hoặc 11 chữ số. Vui lòng nhập lại.");
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <c:set var="tableName" value="${param.tableName}"></c:set>
            <div class="container">
                <form action="customerInfoComtrol" onsubmit="return validateForm()">
                    <h2>${param.tableName}</h2> 
                <input type="hidden" name="tableName" value="${tableName}">
                <div class="form-group">
                    <label for="customerName">Tên khách hàng:</label>
                    <input type="text" id="customerName" name="customerName" required>
                </div>
                <div class="form-group">
                    <label for="phoneNumber">Số điện thoại:</label>
                    <input type="tel" id="phoneNumber" name="phoneNumber" required>
                </div>
                <button type="submit">Chuyển đến trang Order</button>
                <c:if test="${error != null}">
                    <p  style="color: red; text-align: center; margin: 10px"><strong>${error}</strong></p>
                        </c:if>
            </form>
        </div>
    </body>
</html>
