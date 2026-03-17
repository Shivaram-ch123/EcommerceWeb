<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>Update Profile</title>
<style>
body {
	font-family: Arial, sans-serif;
	background: linear-gradient(120deg, #f093fb, #f5576c);
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.update-card {
	background-color: #fff;
	border-radius: 20px;
	padding: 40px 30px 30px;
	width: 400px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
	text-align: center;
}

.update-card h2 {
	color: #333;
	margin-bottom: 20px;
}

.update-card input {
	width: 90%;
	padding: 10px;
	margin: 10px 0;
	border-radius: 8px;
	border: 1px solid #ccc;
}

.btn {
	background: linear-gradient(to right, #f093fb, #f5576c);
	color: white;
	padding: 10px 25px;
	border-radius: 25px;
	text-decoration: none;
	font-size: 14px;
	display: inline-block;
	margin-top: 15px;
	border: none;
	cursor: pointer;
}

.btn:hover {
	opacity: 0.9;
}

.error-message {
	color: #ff4d4f;
	margin-bottom: 15px;
}

.success-message {
	color: #28a745;
	margin-bottom: 15px;
}
</style>
</head>
<body>
	<div class="update-card">

		<h2>Update Profile</h2>

		<!-- Show error message if any -->
		<c:if test="${not empty errorMessage}">
			<p class="error-message">${errorMessage}</p>
		</c:if>

		<!-- Show success message if any -->
		<c:if test="${not empty successMessage}">
			<p class="success-message">${successMessage}</p>
		</c:if>

		<!-- Update Form -->
		<form action="${pageContext.request.contextPath}/updateProfileDetails"
			method="post">
			<input type="hidden" name="id" value="${user.id}" />
			<h4>UserName</h4>
			<input type="text" name="userName" value="${user.userName}"
				placeholder="Name" required />
			<h4>Email</h4>
			<input type="email" name="email" value="${user.email}"
				placeholder="Email" required />
			<h4>PhoneNumber</h4>
			<input type="text" name="phoneNumber" value="${user.phoneNumber}"
				placeholder="Phone Number" required />

			<h4>Address</h4>
			<input type="text" name="address" placeholder="Address" required />


			<button type="submit" class="btn">Update</button>
		</form>

		<br> <a href="${pageContext.request.contextPath}/myProfile"
			class="btn">Back to Profile</a>

	</div>
</body>
</html>