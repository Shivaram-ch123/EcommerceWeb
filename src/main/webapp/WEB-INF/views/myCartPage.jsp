<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Cart</title>

<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(to right, #f1f3f6, #e8ecf1);
	margin: 0;
	padding: 0;
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
	padding: 10px 20px;
	background: #6c757d;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
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
</style>

</head>
<body>

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

										<!-- Decrease button -->
										<form method="post" action="decrease">
											<input type="hidden" name="productId"
												value="${item.product.id}" />
											<button class="qty-btn"
												${item.quantity <= 1 ? 'disabled="disabled"' : ''}>-</button>
										</form>

										<!-- Current Quantity -->
										<span
											style="${item.quantity >= item.product.stock ? 'color:red;' : ''}">
											${item.quantity} </span>

										<!-- Increase button -->
										<form method="post" action="increase">
											<input type="hidden" name="productId"
												value="${item.product.id}" />
											<button class="qty-btn"
												${item.quantity >= item.product.stock ? 'disabled="disabled" title=\'Max stock reached\'' : ''}>
												+</button>
										</form>

									</div>

									<!-- Stock info -->
									<small style="color: #555; margin-top: 2px;">Stock
										Available: ${item.product.stock}</small>

								</div>
							</td>
							</td>

							<td class="total">₹ ${item.product.cost * item.quantity}</td>

						</tr>

						<c:set var="grandTotal"
							value="${grandTotal + (item.product.cost * item.quantity)}" />

					</c:forEach>

					<!-- DELIVERY CHARGE LOGIC -->

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

			</c:when>

			<c:otherwise>

				<p class="empty">🛒 Your cart is empty</p>

			</c:otherwise>

		</c:choose>


		<c:if test="${not empty cartItems}">

			<div class="action-buttons">

				<a href="showhomepag">
					<button class="home-btn">← Continue Shopping</button>
				</a>

				<form action="checkout" method="post">

					<input type="hidden" name="totalAmount" value="${finalTotal}">

					<button class="checkout-btn">Proceed to Checkout</button>

				</form>

			</div>

		</c:if>

	</div>

</body>
</html>