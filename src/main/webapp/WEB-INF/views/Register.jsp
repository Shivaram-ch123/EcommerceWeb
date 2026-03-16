<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.register-container {
	background-color: #fff;
	padding: 30px 40px;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	width: 350px;
}

.register-container h2 {
	text-align: center;
	margin-bottom: 20px;
}

.register-container label {
	display: block;
	margin-top: 15px;
	margin-bottom: 5px;
	font-weight: bold;
}

.register-container input {
	width: 100%;
	padding: 10px;
	border-radius: 5px;
	border: 1px solid #ccc;
}

.register-container button {
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

.register-container button:hover {
	background-color: #495057;
}
</style>
</head>
<body>

	<div class="register-container">
		<h2>Register</h2>
		<form action="registerUser" method="post">
			<label for="username">Username</label> <input type="text"
				id="username" name="userName" required> <label
				for="password">Password</label> <input type="password" id="password"
				name="password" required> <label for="email">Email</label> <input
				type="email" id="email" name="email" required> <label
				for="phone">Phone</label> <input type="text" id="phone"
				name="phoneNumber" required>

			<button type="submit">Register</button>
		</form>
		<a href="showlogin">Go to Login Page</a>
	</div>



</body>
</html>