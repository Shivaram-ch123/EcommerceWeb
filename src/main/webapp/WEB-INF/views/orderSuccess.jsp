<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Success</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f2f2f2;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 900px;
	margin: 50px auto;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
	padding: 40px;
	text-align: center;
}

.success-icon {
	font-size: 80px;
	color: #4CAF50;
	margin-bottom: 20px;
}

h1 {
	color: #333;
	margin-bottom: 10px;
}

p {
	color: #666;
	font-size: 18px;
	margin-bottom: 20px;
}

.btn {
	display: inline-block;
	background-color: #4CAF50;
	color: white;
	padding: 12px 25px;
	font-size: 16px;
	border: none;
	border-radius: 5px;
	text-decoration: none;
	margin: 5px;
	transition: background-color 0.3s;
}

.btn:hover {
	background-color: #45a049;
}

.order-summary {
	text-align: left;
	margin-top: 30px;
	background-color: #f9f9f9;
	padding: 20px;
	border-radius: 8px;
}

.order-summary h3 {
	margin-top: 0;
}

.order-summary table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
}

.order-summary table, .order-summary th, .order-summary td {
	border: 1px solid #ddd;
}

.order-summary th, .order-summary td {
	padding: 8px;
	text-align: left;
}

.order-summary th {
	background-color: #f2f2f2;
}
</style>
</head>
<body>
	<div class="container">
		<div class="success-icon">&#10004;</div>
		<!-- Check mark -->
		<h1>Thank You! Your Order Was Successful</h1>
		<p>
			Your products will be delivered by <strong>${order.dateOfDelivery}</strong>.
		</p>
		<p>Delivery Address: ${order.address}</p>
		<p>Payment Mode: ${order.paymentMode}</p>

		<!-- Buttons -->
		<a class="btn"
			href="${pageContext.request.contextPath}/showCategory?category=">Continue
			Shopping</a> <a class="btn"
			href="${pageContext.request.contextPath}/myOrders">View My Orders</a>

		<!-- Order Summary -->
		<div class="order-summary">
			<h3>Order Summary (Order ID: ${order.id})</h3>
			<table>
				<thead>
					<tr>
						<th>Product Name</th>
						<th>Quantity</th>
						<th>Price (₹)</th>
						<th>Subtotal (₹)</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${order.products}">
						<tr>
							<td>${item.product.name}</td>
							<td>${item.quantity}</td>
							<td>${item.product.cost}</td>
							<td>${item.quantity * item.product.cost}</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="3" style="text-align: right;"><strong>Total
								Amount</strong></td>
						<td><strong>₹${order.totalAmount}</strong></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>