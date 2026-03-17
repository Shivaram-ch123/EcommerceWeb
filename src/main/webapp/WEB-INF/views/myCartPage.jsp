<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Cart - Techouts Store</title>

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
	background: linear-gradient(to right, #f1f3f6, #e8ecf1);
	color: #333;
}

/* Header */
header {
	background: #0a1238;
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

/* Cart container */
main {
	padding: 120px 30px 30px 30px;
}

.container {
	width: 75%;
	margin: auto;
	margin-top: 40px;
	background: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
}

h2 {
	text-align: center;
	margin-bottom: 25px;
	color: #333;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th {
	background: #343a40;
	color: white;
	padding: 14px;
}

td {
	padding: 14px;
	border-bottom: 1px solid #eee;
	text-align: center;
}

.price {
	color: #28a745;
	font-weight: bold;
}

.total {
	color: #007bff;
	font-weight: bold;
}

.grandTotal {
	font-size: 18px;
	font-weight: bold;
	color: #28a745;
}

.quantity-buttons {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
}

.qty-btn {
	padding: 5px 12px;
	border: none;
	border-radius: 5px;
	background: #007bff;
	color: white;
	cursor: pointer;
}

.qty-btn:hover {
	background: #0056b3;
}

.empty {
	text-align: center;
	font-size: 18px;
	color: #777;
	margin-top: 40px;
}

.action-buttons {
	display: flex;
	justify-content: space-between;
	margin-top: 25px;
}

.home-btn {
	display: inline-block;
	padding: 10px 20px;
	background: #6c757d;
	color: white;
	border-radius: 5px;
	text-decoration: none;
	cursor: pointer;
	text-align: center;
}

.home-btn:hover {
	background: #5a6268;
}

.checkout-btn {
	padding: 12px 25px;
	background: #28a745;
	color: white;
	border: none;
	border-radius: 6px;
	font-size: 16px;
	cursor: pointer;
}

/* Footer */
footer {
	background: #222;
	color: #fff;
	text-align: center;
	padding: 25px;
	margin-top: 310px;
	font-size: 0.95em;
}

/* Responsive */
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

			<h2>🛒 My Shopping Cart</h2>

			<c:choose>
				<c:when test="${not empty cartItems}">
					<c:set var="grandTotal" value="0" />

					<table>
						<tr>
							<th>Product</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Total</th>
						</tr>

						<c:forEach var="item" items="${cartItems}">
							<tr>
								<td>${item.product.name}</td>
								<td class="price">₹ ${item.product.cost}</td>
								<td>
									<div class="quantity-buttons"
										style="flex-direction: column; align-items: center;">
										<div style="display: flex; gap: 5px; align-items: center;">
											<form method="post" action="decrease">
												<input type="hidden" name="productId"
													value="${item.product.id}" />
												<button class="qty-btn">-</button>
											</form>
											<span
												style="${item.quantity >= item.product.stock ? 'color:red;' : ''}">
												${item.quantity} </span>
											<form method="post" action="increase">
												<input type="hidden" name="productId"
													value="${item.product.id}" />
												<button class="qty-btn"
													${item.quantity >= item.product.stock ? 'disabled="disabled" title=\'Max stock reached\'' : ''}>+</button>
											</form>
										</div>
										<small style="color: #555; margin-top: 2px;">Stock
											Available: ${item.product.stock}</small>
									</div>
								</td>
								<td class="total">₹ ${item.product.cost * item.quantity}</td>
							</tr>

							<c:set var="grandTotal"
								value="${grandTotal + (item.product.cost * item.quantity)}" />
						</c:forEach>

						<c:set var="deliveryCharge" value="0" />
						<c:if test="${grandTotal < 300}">
							<c:set var="deliveryCharge" value="120" />
						</c:if>
						<c:set var="finalTotal" value="${grandTotal + deliveryCharge}" />

						<tr>
							<td colspan="3" style="text-align: right;">Subtotal :</td>
							<td>₹ ${grandTotal}</td>
						</tr>
						<tr>
							<td colspan="3" style="text-align: right;">Delivery Charge :</td>
							<td>₹ ${deliveryCharge}</td>
						</tr>
						<tr style="background: #f8f9fa;">
							<td colspan="3" style="text-align: right;">Final Total :</td>
							<td class="grandTotal">₹ ${finalTotal}</td>
						</tr>
					</table>

					<div class="action-buttons">
						<a href="showhomepag" class="home-btn">← Continue Shopping</a>
						<form action="checkout" method="post">
							<input type="hidden" name="totalAmount" value="${finalTotal}">
							<button class="checkout-btn">Proceed to Checkout</button>
						</form>
					</div>

				</c:when>
				<c:otherwise>
					<p class="empty">🛒 Your cart is empty</p>
					<a href="showhomepag" class="home-btn">← Continue Shopping</a>
				</c:otherwise>
			</c:choose>

		</div>
	</main>

	<footer> &copy; 2026 Techouts Store </footer>

</body>
</html>