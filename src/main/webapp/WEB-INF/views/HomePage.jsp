<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My E-Commerce Store</title>

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
	background: #f9f9f9;
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
	position: fixed; /* Fixed on top */
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

/* Header top-right buttons: transparent, white text */
nav button {
	background: transparent; /* No background color */
	color: white; /* Text stays white */
	border: none;
	padding: 8px 12px;
	font-weight: 500;
	cursor: pointer;
	transition: all 0.3s ease;
}

/* Hover effect for top-right buttons */
nav button:hover {
	text-shadow: 0 0 6px rgba(255, 255, 255, 0.8); /* Soft white glow */
	transform: translateY(-2px); /* Slight lift */
}

/* Header select dropdown */
nav select {
	min-width: 140px;
	padding: 8px 12px;
	border-radius: 5px;
	border: none;
	cursor: pointer;
	font-weight: 500;
}

/* Main content */
main {
	padding: 100px 30px 30px 30px; /* Top padding ≈ header height */
}

h2 {
	text-align: center;
	margin-bottom: 30px;
}

/* Products grid */
.products {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 20px;
	justify-items: center;
}

/* Product card */
.product-card {
	background: white;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	padding: 20px;
	width: 100%;
	max-width: 250px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	transition: transform 0.3s, box-shadow 0.3s;
}

.product-card:hover {
	transform: scale(1.05);
	box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
}

/* Product images */
.product-card img {
	width: 100%;
	height: 160px;
	object-fit: contain;
	border-radius: 8px;
	margin-bottom: 15px;
}

.product-card h3 {
	margin-bottom: 10px;
	font-size: 1.2em;
	color: #222;
}

.product-card p {
	margin-bottom: 8px;
	font-size: 0.95em;
	color: #555;
}

/* Product buttons */
.button-row {
	display: flex;
	gap: 10px;
	margin-top: 10px;
}

.button-inline {
	flex: 1;
	padding: 10px;
	border-radius: 5px;
	border: none;
	cursor: pointer;
	font-weight: 500;
	transition: 0.3s;
}

.button-cart {
	background: #28a745;
	color: white;
}

.button-cart:hover {
	background: #218838;
}

.button-view {
	background: #007bff;
	color: white;
}

.button-view:hover {
	background: #0069d9;
}

.button-wishlist {
	background: #ff4757;
	color: white;
	margin-top: 10px;
	width: 100%;
}

.button-wishlist:hover {
	background: #e84118;
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
		<h1>My E-Commerce Store</h1>
		<nav>
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

			<form action="${pageContext.request.contextPath}/showlogin"
				method="get">
				<button type="submit" style="background: #dc3545; color: white;">Logout</button>
			</form>
		</nav>
	</header>

	<main>
		<h2>Products</h2>

		<c:if test="${not empty cartMessage}">
			<script>
				alert('${cartMessage}');
				window.location.href = 'showCategory?category=';
			</script>
		</c:if>

		<c:choose>
			<c:when test="${not empty products}">
				<div class="products">
					<c:forEach var="product" items="${products}">
						<div class="product-card">
							<img src="${productImages[product.id]}" alt="${product.name}">
							<h3>${product.name}</h3>
							<p>Price: ₹ ${product.cost}</p>
							<p>Stock: ${product.stock}</p>
							<p>Category: ${product.category}</p>

							<div class="button-row">
								<form action="addToCart" method="post">
									<input type="hidden" name="productId" value="${product.id}">
									<button type="submit" class="button-inline button-cart">Add
										to Cart</button>
								</form>
								<form action="viewProduct" method="get">
									<input type="hidden" name="productId" value="${product.id}">
									<button type="submit" class="button-inline button-view">View</button>
								</form>
							</div>

							<form action="addToWishlist" method="post">
								<input type="hidden" name="productId" value="${product.id}">
								<button type="submit" class="button-inline button-wishlist">Add
									to Wishlist</button>
							</form>
						</div>
					</c:forEach>
				</div>
			</c:when>
			<c:otherwise>
				<p style="text-align: center; margin-top: 40px;">No products
					available.</p>
			</c:otherwise>
		</c:choose>
	</main>

	<footer> &copy; 2026 My E-Commerce Store </footer>

</body>
</html>