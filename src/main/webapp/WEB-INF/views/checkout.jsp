<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>

<style>
.container{
    width:40%;
    margin:auto;
    margin-top:50px;
}
input, select{
    width:100%;
    padding:8px;
    margin:10px 0;
}
button{
    padding:10px 15px;
}
</style>

</head>
<body>

<div class="container">

<h2>Checkout</h2>

<form action="placeOrder" method="post">

    <label>Address</label>
    <input type="text" name="address" required>

    <label>Date of Delivery</label>
    <input type="date" name="dateOfDelivery" required>

    <label>Payment Mode</label>
    <select name="paymentMode">
        <option value="COD">Cash on Delivery</option>
        <option value="UPI">UPI</option>
        <option value="Card">Card</option>
    </select>

    <button type="submit">Place Order</button>

</form>

</div>

</body>
</html>