<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<body>

<h2>My Orders</h2>

<c:forEach var="entry" items="${ordersList}">
    <div style="border:1px solid black; margin:10px; padding:10px; position:relative;">

        <p>Order ID: ${entry.key.id}</p>
        <p>Address: ${entry.key.address}</p>
        <p>Payment Mode: ${entry.key.paymentMode}</p>
        <p>Delivery Date: ${entry.key.dateOfDelivery}</p>

        <div style="position:absolute; top:10px; right:10px; font-weight:bold;">
            ₹ ${entry.value}
        </div>

        <h4>Products:</h4>

        <c:if test="${empty entry.key.products}">
            <p style="color:red; font-weight:bold;">Canceled Order</p>
        </c:if>

        <c:forEach var="item" items="${entry.key.products}">
            <li style="position:relative; padding: 8px 0; border-bottom: 1px solid #ccc;">
                ${item.product.name} - Quantity: ${item.quantity}

                <!-- Cancel Button -->
                <form method="post" action="cancelProduct" 
                      style="position:absolute; right:0; bottom:0; display:inline;">
                    <input type="hidden" name="orderItemId" value="${item.id}" />
                    <button type="submit" 
                            style="background-color:red; color:white; border:none; padding:4px 8px; cursor:pointer;">
                        Cancel
                    </button>
                </form>
            </li>
        </c:forEach>

    </div>
</c:forEach>

</body>
</html>