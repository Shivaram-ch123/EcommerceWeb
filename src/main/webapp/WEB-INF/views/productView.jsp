<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Product</title>

<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

<style>

/* ===== Base Styles ===== */

*{
margin:0;
padding:0;
box-sizing:border-box;
}

body{
font-family:'Roboto',sans-serif;
background:#f9f9f9;
color:#333;
min-height:100vh;
display:flex;
flex-direction:column;
}

/* ===== Header =+==== */

header{
background:#0a1238;
color:white;
padding:20px 40px;
display:flex;
justify-content:space-between;
align-items:center;
position:fixed;
top:0;
left:0;
width:100%;
z-index:1000;
}

header h1{
font-size:1.8em;
}

nav form{
display:inline-block;
margin-left:10px;
}

nav button{
background:transparent;
color:white;
border:none;
padding:8px 12px;
font-weight:500;
cursor:pointer;
transition:all .3s ease;
}

nav button:hover{
text-shadow:0 0 6px rgba(255,255,255,.8);
transform:translateY(-2px);
}

nav select{
min-width:140px;
padding:8px 12px;
border-radius:5px;
border:none;
cursor:pointer;
font-weight:500;
}

/* ===== Main ===== */

main{
flex:1;
padding:120px 20px 60px 20px;
display:flex;
justify-content:center;
align-items:center;
}

/* ===== Product Container ===== */

.product-container{
display:flex;
flex-wrap:wrap;
background:white;
border-radius:10px;
box-shadow:0 4px 12px rgba(0,0,0,.1);
max-width:1000px;
width:100%;
min-height:500px;
overflow:hidden;
}

/* ===== Product Image ===== */

.product-image{
flex:1 1 400px;
min-width:300px;
background:#f5f5f5;
display:flex;
align-items:center;
justify-content:center;
padding:20px;
}

.product-image img{
max-width:100%;
max-height:420px;
border-radius:8px;
object-fit:contain;
}

/* ===== Product Details ===== */

.product-details{
flex:1 1 400px;
padding:35px 25px;
display:flex;
flex-direction:column;
justify-content:center;
}

.product-details h2{
margin-bottom:20px;
color:#222;
}

.product-details p{
margin:8px 0;
font-size:16px;
color:#555;
}

/* ===== Buttons ===== */

.action-buttons{
margin-top:25px;
display:flex;
gap:15px;
flex-wrap:wrap;
}

.action-buttons form button,
.action-buttons a{
flex:1;
padding:12px 15px;
font-weight:500;
border-radius:5px;
border:none;
cursor:pointer;
text-align:center;
transition:.3s;
}

.add-cart-btn{
background:#28a745;
color:white;
}

.add-cart-btn:hover{
background:#218838;
}

.buy-now-btn{
background:#007bff;
color:white;
}

.buy-now-btn:hover{
background:#0069d9;
}

.back-btn{
background:#6c757d;
color:white;
text-decoration:none;
}

.back-btn:hover{
background:#5a6268;
}

/* ===== Footer ===== */

footer{
background:#222;
color:#fff;
text-align:center;
padding:25px;
font-size:.95em;
margin-top:auto;
}

/* ===== Responsive ===== */

@media(max-width:768px){

.product-container{
flex-direction:column;
}

.product-image,
.product-details{
min-width:100%;
}

nav{
display:flex;
flex-wrap:wrap;
gap:10px;
}

header{
flex-direction:column;
align-items:flex-start;
}

}

</style>
</head>

<body>

<!-- ===== Header ===== -->

<header>

<h1>My E-Commerce Store</h1>

<nav>

<form action="myCart" method="get">
<button type="submit">My Cart</button>
</form>

<form action="myOrders" method="get">
<button type="submit">My Orders</button>
</form>

<form action="myProfile" method="get">
<button type="submit">Profile</button>
</form>

<form action="showCategory" method="post">

<select name="category" onchange="this.form.submit()">

<option value="" <c:if test="${param.category == ''}">selected</c:if>>
All Categories
</option>

<option value="Mobiles" <c:if test="${param.category == 'Mobiles'}">selected</c:if>>
Mobiles
</option>

<option value="Laptops" <c:if test="${param.category == 'Laptops'}">selected</c:if>>
Laptops
</option>

</select>

</form>

<form action="${pageContext.request.contextPath}/showWishlist" method="get">
<button type="submit">Wishlist</button>
</form>

<form action="${pageContext.request.contextPath}/showlogin" method="get">
<button type="submit" style="background:#dc3545;color:white;">Logout</button>
</form>

</nav>

</header>

<!-- ===== Main ===== -->

<main>

<div class="product-container">

<div class="product-image">

<c:choose>

<c:when test="${not empty image}">
<img src="${image.url}" alt="${product.name}">
</c:when>

<c:otherwise>
<img src="/images/no-image.png" alt="No Image Available">
</c:otherwise>

</c:choose>

</div>

<div class="product-details">

<h2>${product.name}</h2>

<p><strong>Price:</strong> ₹ ${product.cost}</p>

<p><strong>Stock:</strong> ${product.stock}</p>

<p><strong>Category:</strong> ${product.category}</p>

<p><strong>Description:</strong>
<c:out value="${image.description}" default="No description available"/>
</p>

<div class="action-buttons">

<a href="showCategory?category=${param.category}" class="back-btn">
Back to Products
</a>

<form action="addToCart" method="post">
<input type="hidden" name="productId" value="${product.id}">
<button type="submit" class="add-cart-btn">Add to Cart</button>
</form>

<form action="buyNow" method="post">
<input type="hidden" name="productId" value="${product.id}">
<button type="submit" class="buy-now-btn">Buy Now</button>
</form>

</div>

</div>

</div>

</main>

<!-- ===== Footer ===== -->

<footer>
© 2026 My E-Commerce Store
</footer>

</body>
</html>