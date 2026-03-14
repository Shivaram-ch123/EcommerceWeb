<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My E-Commerce Store</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: Arial;
	background: #f5f5f5;
}

header {
	background: #6c757d;
	color: white;
	padding: 20px;
}

header h1 {
	display: inline-block;
}

nav {
	float: right;
}

nav form {
	display: inline-block;
}

nav select, nav button {
	padding: 5px 10px;
	margin-left: 10px;
}

.products {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	padding: 30px;
}

.product-card {
	background: white;
	padding: 20px;
	width: 250px;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.product-card button {
	background: #6c757d;
	color: white;
	border: none;
	padding: 10px;
	cursor: pointer;
	margin-top: 10px;
}
</style>

</head>
<body>

	<header>

		<h1>My E-Commerce Store</h1>

		<nav>

			<!-- Added Top Right Buttons -->
			<form action="myCart" method="get">
				<button type="submit">MyCart</button>
			</form>

			<form action="myOrders" method="get">
				<button type="submit">MyOrders</button>
			</form>

			<form action="myProfile" method="get">
				<button type="submit">MyProfile</button>
			</form>

			<form action="showCategory" method="post">
				<select name="category">
					<option value="">All Categories</option>
					<option value="Mobiles">Mobiles</option>
					<option value="Laptops">Laptops</option>
				</select>
				<button type="submit">Show Products</button>
			</form>

		</nav>

		<div style="clear: both;"></div>

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
							<h3>${product.name}</h3>
							<p>Price: ₹ ${product.cost}</p>
							<p>Stock: ${product.stock}</p>
							<p>Category: ${product.category}</p>

							<form action="addToCart" method="post"
								style="display: inline-block;">
								<input type="hidden" name="productId" value="${product.id}">
								<button type="submit">Add To Cart</button>
							</form>

							<form action="viewProduct" method="get"
								style="display: inline-block;">
								<input type="hidden" name="productId" value="${product.id}">
								<button type="submit">View</button>
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

	<footer
		style="background: #222; color: white; text-align: center; padding: 20px; margin-top: 40px;">
		&copy; 2026 My E-Commerce Store
	</footer>

</body>
</html>