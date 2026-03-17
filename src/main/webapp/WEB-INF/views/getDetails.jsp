<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f2f2f2;
	margin: 0;
	padding: 0;
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

button {
	background-color: #4CAF50;
	color: white;
	padding: 12px 25px;
	font-size: 16px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s;
}

button:hover {
	background-color: #45a049;
}

label {
	display: block;
	text-align: left;
	margin-bottom: 5px;
	font-weight: bold;
	color: #333;
}
</style>
</head>
<body>

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

			<button type="submit">Place Order</button>
		</form>
	</div>

</body>
</html>