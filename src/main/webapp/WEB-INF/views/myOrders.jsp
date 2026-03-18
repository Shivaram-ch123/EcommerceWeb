<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Orders - Techouts Store</title>

<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

<style>

/* ===== GLOBAL (FROM HEADER PAGE) ===== */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Roboto', sans-serif;
	background: #f9f9f9;
	color: #333;
}

/* ===== HEADER ===== */
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

/* ===== MAIN ===== */
main {
	padding: 100px 30px 30px 30px;
}

h2 {
	text-align: center;
	margin-bottom: 20px;
}

/* ===== ORDERS PAGE (YOUR ORIGINAL STYLES) ===== */
.order-card {
	border: 1px solid black;
	margin: 10px;
	padding: 10px;
	position: relative;
	background: white;
	border-radius: 8px;
}

.order-total {
	position: absolute;
	top: 10px;
	right: 10px;
	font-weight: bold;
}

.product-item {
	display: flex;
	align-items: center;
	padding: 8px 0;
	border-bottom: 1px solid #ccc;
	position: relative;
}

.product-item img {
	width: 50px;
	height: 50px;
	margin-right: 10px;
}

.cancel-btn {
	background-color: red;
	color: white;
	border: none;
	padding: 4px 8px;
	cursor: pointer;
	position: absolute;
	right: 0;
	bottom: 0;
}

.canceled-order {
	color: red;
	font-weight: bold;
	font-style: italic;
}

/* Empty Orders */
.empty-orders {
	text-align: center;
	margin-top: 80px;
}

.empty-orders img {
	width: 120px;
	height: 120px;
	opacity: 0.6;
}

.empty-orders h2 {
	color: #555;
	margin-top: 20px;
}

.empty-orders p {
	color: gray;
	margin-bottom: 20px;
}

.empty-orders button {
	padding: 10px 20px;
	background-color: green;
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 5px;
}

/* ===== FOOTER ===== */
footer {
	background: #222;
	color: #fff;
	text-align: center;
	padding: 25px;
	margin-top: 170px;
	font-size: 0.95em;
}

</style>
</head>

<body>

<!-- ===== HEADER ===== -->
<header>
	<h1>Techouts Store</h1>
	<nav>

		<c:if test="${empty sessionScope.currentUser}">
			<form action="register" method="get">
				<button type="submit">Signin</button>
			</form>
		</c:if>
		<form action="showhomepag" method="get">
				<button type="submit">Home</button>
			</form>

		<form action="myCart" method="get">
			<button type="submit">My Cart</button>
		</form>

		<form action="myOrders" method="get">
			<button type="submit">My Orders</button>
		</form>

		<form action="myProfile" method="get">
			<button type="submit">Profile</button>
		</form>

		<form action="showCategory" method="post">
			<select name="category" onchange="this.form.submit()">
				<option value="">All Categories</option>
				<option value="Mobiles">Mobiles</option>
				<option value="Laptops">Laptops</option>
			</select>
		</form>

		<form action="showWishlist" method="get">
			<button type="submit">Wishlist</button>
		</form>

		<c:if test="${not empty sessionScope.currentUser}">
			<form action="showlogin" method="get">
				<button type="submit" style="background: #dc3545;">Logout</button>
			</form>
		</c:if>

	</nav>
</header>

<!-- ===== MAIN CONTENT ===== -->
<main>

<h2>My Orders</h2>

<c:choose>

	<c:when test="${empty ordersList}">
		<div class="empty-orders">
			<img src="https://cdn-icons-png.flaticon.com/512/4076/4076504.png" />
			<h2>You have no orders yet</h2>
			<p>Looks like you haven’t placed any orders.</p>
			<a href="showhomepag">
				<button>Start Shopping</button>
			</a>
		</div>
	</c:when>

	<c:otherwise>

		<c:forEach var="order" items="${ordersList}">

			<c:set var="sum" value="0" />
			<c:forEach var="item" items="${order.products}">
				<c:if test="${item.status == 'ACTIVE'}">
					<c:set var="sum" value="${sum + (item.product.cost * item.quantity)}" />
				</c:if>
			</c:forEach>

			<div class="order-card">

				<p><b>Order ID:</b> ${order.id}</p>
				<p><b>Address:</b> ${order.address}</p>
				<p><b>Payment Mode:</b> ${order.paymentMode}</p>
				<p><b>Delivery Date:</b> ${order.dateOfDelivery}</p>

				<div class="order-total">
					<c:choose>
						<c:when test="${sum == 0}">
							<span class="canceled-order">₹ 0 (No active products)</span>
						</c:when>
						<c:when test="${sum < 300}">
							₹ ${sum + 120}<br />
							<span style="font-size: 12px; color: gray;">
								(₹${sum} + ₹120 delivery)
							</span>
						</c:when>
						<c:otherwise>
							₹ ${sum}<br />
							<span style="font-size: 12px; color: green;">
								Free Delivery
							</span>
						</c:otherwise>
					</c:choose>
				</div>

				<h4>Products:</h4>

				<c:if test="${empty order.products}">
					<p class="canceled-order">Canceled Order</p>
				</c:if>

				<ul style="list-style-type: none; padding: 0;">
					<c:forEach var="item" items="${order.products}">

						<li class="product-item ${item.status == 'CANCELED' ? 'canceled-order' : ''}">

							<c:set var="productImage" value="${productImagesMap[item.product.id]}" />

							<c:if test="${not empty productImage}">
								<img src="${productImage.url}" 
									style="${item.status == 'CANCELED' ? 'opacity:0.5;' : ''}" />
							</c:if>

							<span>
								${item.product.name} - Quantity: ${item.quantity} - Price: ₹
								<c:choose>
									<c:when test="${item.status == 'CANCELED'}">0</c:when>
									<c:otherwise>${item.product.cost * item.quantity}</c:otherwise>
								</c:choose>
							</span>

							<c:choose>
								<c:when test="${item.status == 'ACTIVE'}">
									<form method="post" action="cancelProduct">
										<input type="hidden" name="orderItemId" value="${item.id}" />
										<button type="submit" class="cancel-btn">Cancel</button>
									</form>
								</c:when>
								<c:otherwise>
									<span class="canceled-order">CANCELED</span>
								</c:otherwise>
							</c:choose>

						</li>

					</c:forEach>
				</ul>

			</div>

		</c:forEach>

	</c:otherwise>

</c:choose>

<br>


</main>
<a href="showCategory?category=">home page</a>

<!-- ===== FOOTER ===== -->
<footer>
	&copy; 2026 Techouts Store
</footer>

</body>
</html>