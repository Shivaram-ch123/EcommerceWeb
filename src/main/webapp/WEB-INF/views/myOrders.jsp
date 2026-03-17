<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>My Orders</title>
<style>
.order-card {
	border: 1px solid black;
	margin: 10px;
	padding: 10px;
	position: relative;
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
</style>
</head>
<body>

	<h2>My Orders</h2>

	<c:forEach var="order" items="${ordersList}">

		<!-- Calculate total of ACTIVE products -->
		<c:set var="sum" value="0" />
		<c:forEach var="item" items="${order.products}">
			<c:if test="${item.status == 'ACTIVE'}">
				<c:set var="sum"
					value="${sum + (item.product.cost * item.quantity)}" />
			</c:if>
		</c:forEach>

		<div class="order-card">
			<p>
				<b>Order ID:</b> ${order.id}
			</p>
			<p>
				<b>Address:</b> ${order.address}
			</p>
			<p>
				<b>Payment Mode:</b> ${order.paymentMode}
			</p>
			<p>
				<b>Delivery Date:</b> ${order.dateOfDelivery}
			</p>

			<div class="order-total">
				<c:choose>
					<c:when test="${sum == 0}">
						<span class="canceled-order">₹ 0 (No active products)</span>
					</c:when>
					<c:when test="${sum < 300}">
            ₹ ${sum + 120}<br />
						<span style="font-size: 12px; color: gray;">(₹${sum} + ₹120
							delivery)</span>
					</c:when>
					<c:otherwise>
            ₹ ${sum}<br />
						<span style="font-size: 12px; color: green;">Free Delivery</span>
					</c:otherwise>
				</c:choose>
			</div>

			<h4>Products:</h4>

			<c:if test="${empty order.products}">
				<p class="canceled-order">Canceled Order</p>
			</c:if>

			<ul style="list-style-type: none; padding: 0;">
				<c:forEach var="item" items="${order.products}">
					<li
						class="product-item ${item.status == 'CANCELED' ? 'canceled-order' : ''}">
						<c:set var="productImage"
							value="${productImagesMap[item.product.id]}" /> <c:if
							test="${not empty productImage}">
							<img src="${productImage.url}" alt="${item.product.name}"
								style="${item.status == 'CANCELED' ? 'opacity:0.5;' : ''}" />
						</c:if> <span> ${item.product.name} - Quantity: ${item.quantity} -
							Price: ₹ <c:choose>
								<c:when test="${item.status == 'CANCELED'}">0</c:when>
								<c:otherwise>${item.product.cost * item.quantity}</c:otherwise>
							</c:choose>
					</span> <c:choose>
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

	<br>
	<a href="showhomepag">Go Back to HomePage</a>

</body>
</html>