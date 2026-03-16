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
	font-family: Arial;
	background: #f5f5f5;
}

.container {
	width: 80%;
	margin: auto;
	margin-top: 40px;
}

h2 {
	text-align: center;
}

table {
	width: 100%;
	border-collapse: collapse;
	background: white;
}

th, td {
	padding: 12px;
	border: 1px solid #ddd;
	text-align: center;
}

th {
	background: #6c757d;
	color: white;
}

.empty {
	text-align: center;
	margin-top: 40px;
}

.quantity-buttons button {
	padding: 4px 8px;
	margin: 0 2px;
}
</style>

</head>
<body>

	<div class="container">

		<h2>My Cart</h2>

		<c:choose>

			<c:when test="${not empty cartItems}">

				<table>
					<tr>
						<th>Product Name</th>
						<th>Price</th>
						<th>Quantity</th>
						<th>Total</th>
					</tr>

					<c:forEach var="item" items="${cartItems}">
						<tr>
							<td>${item.product.name}</td>
							<td>${item.product.cost}</td>
							<td>
								<div class="quantity-buttons">
									<form method="post" action="decrease">
										<input type="hidden" name="productId"
											value="${item.product.id}" /> <input type="hidden"
											name="action" value="decrease" />
										<button type="submit">-</button>
									</form>

									${item.quantity}

									<form method="post" action="increase">
										<input type="hidden" name="productId"
											value="${item.product.id}" /> <input type="hidden"
											name="action" value="increase" />
										<button type="submit">+</button>
									</form>
								</div>
							</td>
							<td>${item.product.cost * item.quantity}</td>
						</tr>
					</c:forEach>
				</table>

			</c:when>

			<c:otherwise>

				<p class="empty">Your cart is empty.</p>

			</c:otherwise>

		</c:choose>


		<c:if test="${not empty cartItems}">
			<div style="text-align: right; margin-top: 20px;">
				<a href="checkout">
					<button
						style="padding: 10px 20px; background-color: #28a745; color: white; border: none; cursor: pointer;">
						Continue</button>
				</a>
			</div>
		</c:if>

		<div style="text-align: left; margin-top: 20px;">
			<a href="showhomepag">Go To HomePage</a>

		</div>



	</div>

</body>
</html>