<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Checkout - Techouts Store</title>

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap"
	rel="stylesheet">

<style>
/* Google Fonts */
@import
	url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap')
	;

/* Reset & base styles */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Roboto', sans-serif;
	background-color: #f2f2f2;
	color: #333;
}

/* Header */
header {
	background: #0a1238; /* Dark blue header */
	color: white;
	padding: 20px 40px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 1000;
}

header h1 {
	font-size: 1.8em;
}

/* Header nav forms */
nav form {
	display: inline-block;
	margin-left: 10px;
}

nav button {
	background: transparent;
	color: white;
	border: none;
	padding: 8px 12px;
	font-weight: 500;
	cursor: pointer;
	transition: all 0.3s ease;
}

nav button:hover {
	text-shadow: 0 0 6px rgba(255, 255, 255, 0.8);
	transform: translateY(-2px);
}

nav select {
	min-width: 140px;
	padding: 8px 12px;
	border-radius: 5px;
	border: none;
	cursor: pointer;
	font-weight: 500;
}

/* Checkout container */
main {
	padding: 120px 30px 30px 30px; /* top padding for fixed header */
}

.container {
	max-width: 500px;
	margin: 50px auto;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
	padding: 40px;
	text-align: center;
}

h2 {
	color: #333;
	margin-bottom: 30px;
}

input, select {
	width: 100%;
	padding: 12px;
	margin: 10px 0 20px 0;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
	font-size: 16px;
}

button.checkout-btn {
	background-color: #4CAF50;
	color: white;
	padding: 12px 25px;
	font-size: 16px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s;
}

button.checkout-btn:hover {
	background-color: #45a049;
}

label {
	display: block;
	text-align: left;
	margin-bottom: 5px;
	font-weight: bold;
	color: #333;
}

/* Footer */
footer {
	background: #222;
	color: #fff;
	text-align: center;
	padding: 25px;
	margin-top: 40px;
	font-size: 0.95em;
}

/* Responsive adjustments */
@media ( max-width : 600px) {
	nav {
		display: flex;
		flex-wrap: wrap;
		gap: 10px;
		margin-top: 10px;
	}
	header {
		flex-direction: column;
		align-items: flex-start;
	}
}
</style>
</head>

<body>

	<header>
		<h1>Techouts Store</h1>
		<nav>
			<c:if test="${empty sessionScope.currentUser}">
				<form action="register" method="get">
					<button type="submit">Signin</button>
				</form>
			</c:if>

			<form action="myCart" method="get">
				<button type="submit">My Cart</button>
			</form>
			<form action="myOrders" method="get">
				<button type="submit">My Orders</button>
			</form>
			<form action="myProfile" method="get">
				<button type="submit">Profile</button>
			</form>

			<form action="showCategory" method="post" id="categoryForm">
				<select name="category" onchange="this.form.submit()">
					<option value=""
						<c:if test="${param.category == ''}">selected</c:if>>All
						Categories</option>
					<option value="Mobiles"
						<c:if test="${param.category == 'Mobiles'}">selected</c:if>>Mobiles</option>
					<option value="Laptops"
						<c:if test="${param.category == 'Laptops'}">selected</c:if>>Laptops</option>
				</select>
			</form>

			<form action="${pageContext.request.contextPath}/showWishlist"
				method="get">
				<button type="submit">Wishlist</button>
			</form>

			<c:if test="${not empty sessionScope.currentUser}">
				<form action="${pageContext.request.contextPath}/showlogin"
					method="get">
					<button type="submit" style="background: #dc3545; color: white;">Logout</button>
				</form>
			</c:if>
		</nav>
	</header>

	<main>
		<div class="container">
			<h2>Checkout</h2>
			<form action="placeOneOrder" method="post">
				<input type="hidden" name="productId" value="${productId}" /> <label
					for="address">Address:</label> <input type="text" id="address"
					name="address" required /> <label for="paymentMode">Payment
					Mode:</label> <select id="paymentMode" name="paymentMode" required>
					<option value="COD">Cash on Delivery</option>
					<option value="Card">Card</option>
				</select>

				<button type="submit" class="checkout-btn">Place Order</button>
			</form>

			<a
				href="${pageContext.request.contextPath}/viewProduct?productId=${productId}">
				<button type="button"
					style="background: #6c757d; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; margin-top: 20px;">
					← Back to Product</button>
			</a>
		</div>
	</main>

	<footer> &copy; 2026 Techouts Store </footer>

</body>
</html>