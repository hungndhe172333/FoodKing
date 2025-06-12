<%-- 
    Document   : StaffLogin
    Created on : May 21, 2024, 3:45:02 PM
    Author     : minhp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Point Of Sale - Login</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
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
            .forgot-password, .sign-up-link {
                display: block;
                margin-top: 20px;
            }
            .sign-up-link {
                color: #007bff;
                text-decoration: none;
                text-align: center;
            }
            .sign-up-link:hover {
                text-decoration: underline;
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
                    <h2>Xin chào</h2>
                    <form action="login" method="post">
                        <div class="form-group">
                            <label for="username">Tài khoản</label>
                            <p style="color: red">${mess}</p>
                            <input type="text" class="form-control" name="username" placeholder="Nhập tài khoản" value="${username}" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Mật khẩu</label>
                            <input type="password" class="form-control" name="password" placeholder="Nhập mật khẩu" value="${password}" required>
                        </div>
                        <a href="ForgotPassword.jsp" class="forgot-password">Quên mật khẩu?</a>
                        <button type="submit" class="btn btn-primary btn-block mt-4">Đăng nhập</button>
                    </form>
                    <a href="SignUp.jsp" class="sign-up-link">Đăng kí tài khoản</a>
                    <div class="logo text-center mt-4">
                        <img src="assets/img/logo/logo.svg" alt="Logo" width="100">
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
