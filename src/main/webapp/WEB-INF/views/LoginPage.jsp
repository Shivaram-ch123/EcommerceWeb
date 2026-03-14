<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            width: 350px;
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .login-container label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .login-container input {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .login-container button {
            margin-top: 20px;
            width: 100%;
            padding: 10px;
            background-color: #6c757d; /* gray */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .login-container button:hover {
            background-color: #495057; /* darker gray */
        }

        .login-container .register-link {
            margin-top: 15px;
            text-align: center;
        }

        .login-container .register-link a {
            text-decoration: none;
            color: #6c757d;
            font-weight: bold;
        }

        .login-container .register-link a:hover {
            text-decoration: underline;
            color: #495057;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Login</h2>
    <form action="checkUser" method="post">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" required>

        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>

        <button type="submit">Login</button>
    </form>

    <div class="register-link">
        <p>Don't have an account? <a href="register">Register here</a></p>
    </div>
</div>

</body>
</html>