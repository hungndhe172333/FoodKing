<%-- 
    Document   : ForgotPassword
    Created on : May 21, 2024, 3:45:02 PM
    Author     : minhp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #F6F6F6;
                font-family: 'Roboto', sans-serif;
            }
            .login-container {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 15px;
            }
            .login-box {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                max-width: 800px;
                width: 100%;
                display: flex;
                flex-direction: row;
                align-items: center;
            }
            .login-form {
                flex: 1;
                padding: 20px;
            }
            .login-box h2 {
                margin-bottom: 30px;
                font-weight: 700;
                text-align: center;
            }
            .form-group {
                text-align: left;
            }
            .form-control {
                border-radius: 50px;
                padding: 10px 20px;
            }
            .btn-primary {
                border-radius: 50px;
                padding: 10px;
                font-size: 16px;
            }
            .login-image {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding-right: 20px;
            }
            .login-image img {
                max-width: 100%;
                height: auto;
                border-radius: 10px;
            }
            @media (max-width: 576px) {
                .login-box {
                    flex-direction: column;
                    padding: 30px;
                }
                .login-image {
                    display: none;
                }
            }
        </style>
    </head>
    <body>
        <div class="container login-container">
            <div class="login-box">
                <div class="login-image">
                    <img src="assets/img/background.png" alt="">
                </div>
                <div class="login-form">
                    <h2>Quên mật khẩu</h2>
                    <form action="forgot">
                        <div class="form-group">
                            <p style="color: red">${mess}</p>
                        </div>
                        <div class="form-group">
                            <label for="email">Email khôi phục</label>
                            <input type="email" class="form-control" name="email" placeholder="Nhập email" required>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block mt-4">Gửi xác nhận</button>
                    </form>
                    <button class="btn btn-primary btn-block mt-4" onclick="location.href = 'Login.jsp'">Quay lại đăng nhập</button>
                    <div class="logo text-center mt-4">
                        <img src="assets/img/logo/logo.svg" alt="Logo" width="100">
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
