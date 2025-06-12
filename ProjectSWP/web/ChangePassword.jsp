<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Change Password</title>
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
                padding: 8px 16px; /* Điều chỉnh kích thước padding tại đây */
            }

            .btn-primary {
                border-radius: 50px;
                padding: 10px;
                font-size: 16px;
            }

            .forgot-password, .sign-up-link {
                display: block;
                margin-top: 20px;
                text-align: center;
            }

            .sign-up-link {
                color: #007bff;
                text-decoration: none;
            }

            .sign-up-link:hover {
                text-decoration: underline;
            }

            .login-image {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                margin-right: 20px; /* Thêm margin để tạo khoảng cách */
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
                    <h2>Thay đổi mật khẩu</h2>
                    <form action="change" method="post">
                        <p style="color: red">${mess}</p>
                        <input type="hidden" name="username" value="<%= request.getParameter("username") %>">
                        <input type="hidden" name="email" value="<%= request.getParameter("email") %>">
                        <div class="form-group">
                            <label for="password">Mật khẩu cũ</label>
                            <input type="password" class="form-control" name="password" placeholder="Current password" required>
                        </div>
                        <div class="form-group">
                            <label for="newpassword">Mật khẩu mới</label>
                            <input type="password" class="form-control" name="newpassword" placeholder="New password" required>
                        </div>
                        <div class="form-group">
                            <label for="repeatpassword">Nhập lại mật khẩu</label>
                            <input type="password" class="form-control" name="repeatpassword" placeholder="Repeat new password" required>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block mt-4 mb-2">Thay đổi mật khẩu</button>
                    </form>
                    <a href="Login.jsp" class="btn btn-primary btn-block">Đăng nhập</a>
                    <div class="logo text-center mt-4">
                        <img src="assets/img/logo/logo.svg" alt="Logo" width="100">
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
