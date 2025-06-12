<%-- 
    Document   : PaymentInCash
    Created on : Jun 23, 2024, 8:42:02 PM
    Author     : minhp
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thanh Toán - Bàn 1</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: sans-serif;
                background-color: #f4f4f4;
            }

            .container {
                width: 90%;
                max-width: 500px;
                margin: 20px auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }

            .form-group {
                margin-bottom: 15px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="number"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 16px;
            }

            .total-price,
            .change-info {
                font-size: 18px;
                margin-bottom: 15px;
                text-align: right;
            }

            button {
                display: block;
                width: 100%;
                padding: 10px;
                background-color: #27ae60;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
                font-size: 16px;
            }

            button:hover {
                background-color: #2ecc71;
            }

            /* Media query cho điện thoại */
            @media (max-width: 768px) {
                .container {
                    width: 95%;
                }
            }
        </style>
    </head>
    <body>
        <c:set var="tableName" value="${param.tableName}"></c:set>
            <div class="container">
                <form action="completePaymentControl"> 

                    <h2>Thanh Toán - ${tableName}</h2>

                <div class="form-group">
                    <label for="totalPrice">Tổng tiền:</label>
                    <div class="total-price" id="totalPrice">${totalMoney} VND</div>
                </div>

                <div class="form-group">
                    <label for="paymentAmount">Tiền khách đưa:</label>
                    <input type="number" id="paymentAmount" class="payment-input" min="0">
                </div>

                <button type="button" onclick="calculateChange()">Tính tiền thừa</button>

                <div class="change-info">
                    Tiền thừa trả khách: <span id="changeAmount">0 VND</span>
                </div>
                <input type="hidden" name="tableName" value="${tableName}"/>
                <input type="hidden" name="totalMoney" value="${totalMoney}"/>
                <input type="hidden" name="transactiontype" value="${transactiontype}"/>
                <input type="hidden" name="phoneNumber" value="${phoneNumber}"/>
                <button onclick="completePayment()">Hoàn tất thanh toán</button>
            </form>
        </div>

        <script>
            function calculateChange() {
                const totalPrice = parseFloat(document.getElementById("totalPrice").textContent);
                const paymentAmount = parseFloat(document.getElementById("paymentAmount").value);

                if (isNaN(paymentAmount) || paymentAmount < totalPrice) {
                    alert("Số tiền khách đưa không hợp lệ!");
                    return;
                }

                const changeAmount = paymentAmount - totalPrice;
                document.getElementById("changeAmount").textContent = changeAmount.toFixed(2) + " VND";
            }

            function completePayment() {
                // Thực hiện các xử lý cần thiết khi hoàn tất thanh toán
                alert("Thanh toán hoàn tất!");
                // Ví dụ: In hóa đơn, cập nhật dữ liệu, ...
            }
        </script>
    </body>
</html>
