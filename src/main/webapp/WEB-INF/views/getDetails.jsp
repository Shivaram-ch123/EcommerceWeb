<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>

<style>
.container {
	width: 40%;
	margin: auto;
	margin-top: 50px;
}

input, select {
	width: 100%;
	padding: 8px;
	margin: 10px 0;
}

button {
	padding: 10px 15px;
}
</style>

</head>
<body>

	<div class="container">

		<h2>Checkout</h2>
		<form action="placeOneOrder" method="post">
			<input type="hidden" name="productId" value="${productId}" />

			Address: <input type="text" name="address" required /><br />
			Delivery Date: <input type="date" name="dateOfDelivery" required /><br />
			Payment Mode: <select name="paymentMode" required>
				<option value="COD">Cash on Delivery</option>
				<option value="Card">Card</option>
			</select><br />

			<button type="submit">Place Order</button>
		</form>

	</div>

</body>
</html>