<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String total = request.getParameter("totalAmount");
if (total == null) {
	total = "0";
}

/* Generate random delivery days between 4 and 10 */
int deliveryDays = (int) (Math.random() * 7) + 4;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>

<style>
body {
	font-family: Arial;
	background: #f5f5f5;
}

.container {
	width: 40%;
	margin: auto;
	margin-top: 50px;
	background: white;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0px 3px 10px rgba(0, 0, 0, 0.1);
}

h2 {
	text-align: center;
}

.totalBox {
	background: #f1f3f6;
	padding: 12px;
	margin-bottom: 15px;
	font-size: 18px;
	text-align: center;
	font-weight: bold;
}

input, select {
	width: 100%;
	padding: 10px;
	margin: 10px 0;
	border: 1px solid #ccc;
	border-radius: 4px;
}

button {
	width: 100%;
	padding: 12px;
	background: #28a745;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
}

button:hover {
	background: #218838;
}

.deliveryText {
	text-align: center;
	font-size: 15px;
	color: #555;
	margin-bottom: 10px;
}
</style>

</head>
<body>

	<div class="container">

		<h2>Checkout</h2>

		<div class="totalBox">
			Total Amount : ₹
			<%=total%>
		</div>

		<div class="deliveryText">
			Estimated Delivery in <b><%=deliveryDays%></b> days
		</div>

		<form action="placeOrder" method="post">

			<!-- Send total to controller -->
			<input type="hidden" name="totalAmount" value="<%=total%>">

			<!-- Send random delivery days -->
			<input type="hidden" name="deliveryDays" value="<%=deliveryDays%>">

			<label>Address</label> <input type="text" name="address" required>

			<label>Payment Mode</label> <select name="paymentMode">
				<option value="COD">Cash on Delivery</option>
				<option value="UPI">UPI</option>
				<option value="Card">Card</option>
			</select>

			<button type="submit">Place Order</button>

		</form>

	</div>

</body>
</html>