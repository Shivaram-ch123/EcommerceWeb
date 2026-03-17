<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Out of Stock</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .message-box {
            background-color: #fff;
            padding: 40px 60px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
        }

        .message-box h1 {
            font-size: 36px;
            color: #e74c3c; /* red color for alert */
            margin-bottom: 20px;
        }

        .message-box p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        .message-box a {
            text-decoration: none;
            color: #fff;
            background-color: #3498db;
            padding: 12px 25px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .message-box a:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="message-box">
        <h1>Oops!</h1>
        <p>Sorry, the products you are looking for are currently out of stock.</p>
        <a href="showhomepag">Go Back to Home</a>
    </div>
</body>
</html>