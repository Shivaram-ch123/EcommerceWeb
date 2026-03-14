<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Product Details</title>
<style>
body {
	font-family: Arial;
	background: #f5f5f5;
	padding: 20px;
}

.product-details {
	background: white;
	padding: 30px;
	border-radius: 8px;
	max-width: 500px;
	margin: 50px auto;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.product-details h2 {
	margin-bottom: 20px;
}

.product-details p {
	margin: 10px 0;
	font-size: 16px;
}

.back-button {
	margin-top: 20px;
	display: inline-block;
	padding: 10px 15px;
	background: #6c757d;
	color: white;
	text-decoration: none;
	border-radius: 5px;
}
</style>
</head>
<body>

	<div class="product-details">
		<h2>Product Details</h2>

		<p>
			<strong>ID:</strong> ${product.id}
		</p>
		<p>
			<strong>Name:</strong> ${product.name}
		</p>
		<p>
			<strong>Price:</strong> ₹ ${product.cost}
		</p>
		<p>
			<strong>Stock:</strong> ${product.stock}
		</p>
		<p>
			<strong>Category:</strong> ${product.category}
		</p>

		<a href="showCategory?category=" class="back-button">Back to
			Products</a>
		<form action="addToCart" method="post">
			<input type="hidden" name="productId" value="${product.id}">
			<button type="submit" class="back-button">Add to Cart</button>
		</form>
	</div>

</body>
</html>