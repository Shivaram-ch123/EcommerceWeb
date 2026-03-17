<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Wishlist</title>

<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Roboto', sans-serif;
    background: #f9f9f9;
}

/* HEADER */
header {
    background: #0a1238;
    color: white;
    padding: 20px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 1000;
}

nav form {
    display: inline-block;
    margin-left: 10px;
}

nav button {
    background: transparent;
    color: white;
    border: none;
    padding: 8px 12px;
    cursor: pointer;
    font-weight: 500;
    transition: all 0.3s ease;
}

nav button:hover {
    text-shadow: 0 0 6px rgba(255,255,255,0.8);
}

/* MAIN */
main {
    padding: 100px 20px 30px 20px;
    max-width: 1200px;
    margin: 0 auto;
}

h2 {
    text-align: center;
    margin-bottom: 30px;
    font-weight: 700;
    color: #222;
}

/* PRODUCTS GRID */
.products {
    display: flex;
    flex-wrap: wrap;
    gap: 25px;
    justify-content: center;
}

/* PRODUCT CARD */
.product-card {
    background: white;
    padding: 20px;
    width: 260px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    text-align: center;
    display: flex;
    flex-direction: column;
    transition: box-shadow 0.3s ease;
}
.product-card:hover {
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

/* PRODUCT IMAGE */
.product-image {
    width: 100%;
    height: 160px;
    margin-bottom: 15px;
    border-radius: 8px;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #f5f5f5;
}
.product-image img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
}

/* PRODUCT DETAILS */
.product-card h3 {
    font-size: 1.2rem;
    color: #222;
    margin-bottom: 12px;
    font-weight: 700;
}
.product-card p {
    color: #555;
    margin-bottom: 8px;
    font-size: 15px;
}
.product-card p strong {
    color: #333;
}

/* BUTTONS */
.button-inline {
    padding: 10px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    width: 100%;
    margin-top: 10px;
    font-weight: 600;
    font-size: 14px;
    transition: background 0.3s ease;
}

.button-view {
    background: #007bff;
    color: white;
}
.button-view:hover {
    background: #0056b3;
}

.button-remove {
    background: #dc3545;
    color: white;
}
.button-remove:hover {
    background: #a71d2a;
}

/* EMPTY MESSAGE */
.empty-message-container {
    text-align: center;
    margin-top: 60px;
    padding: 30px 20px;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.07);
    max-width: 320px;
    margin-left: auto;
    margin-right: auto;
}
.empty-message-container img {
    width: 220px;
    margin-bottom: 20px;
}
.empty-message {
    font-size: 1.3rem;
    font-weight: 700;
    color: #444;
    margin-bottom: 0;
}
.empty-message-container p.subtext {
    color: #777;
    font-size: 1rem;
    margin-top: 10px;
}

/* BACK BUTTON */
.back-button-container {
    text-align: center;
    margin-top: 30px;
}
.back-button-container a {
    background: #6c757d;
    color: white;
    padding: 12px 30px;
    border-radius: 6px;
    font-weight: 600;
    text-decoration: none;
    display: inline-block;
    transition: background 0.3s ease;
}
.back-button-container a:hover {
    background: #5a6268;
}

/* FOOTER */
footer {
    background: #222;
    color: #fff;
    text-align: center;
    padding: 25px;
    margin-top: 110px;
}

/* RESPONSIVE */
@media (max-width: 768px) {
    .products {
        flex-direction: column;
        align-items: center;
    }
    .product-card {
        width: 90%;
    }
    main {
        padding: 120px 15px 30px 15px;
    }
}
</style>
</head>

<body>

<!-- HEADER -->
<header>
    <h1>Techouts Store</h1>
    <nav>
        <c:if test="${empty sessionScope.currentUser}">
            <form action="register" method="get">
                <button type="submit">Signin</button>
            </form>
        </c:if>

        <form action="myCart" method="get">
            <button type="submit">My Cart</button>
        </form>

        <form action="myOrders" method="get">
            <button type="submit">My Orders</button>
        </form>

        <form action="myProfile" method="get">
            <button type="submit">Profile</button>
        </form>

        <form action="showWishlist" method="get">
            <button type="submit">Wishlist</button>
        </form>

        <c:if test="${not empty sessionScope.currentUser}">
            <form action="showlogin" method="get">
                <button type="submit" style="background: #dc3545;">Logout</button>
            </form>
        </c:if>
    </nav>
</header>

<!-- MAIN CONTENT -->
<main>

<h2>My Wishlist</h2>

<c:choose>
    <c:when test="${not empty wishlistProducts}">
        <div class="products">
            <c:forEach var="product" items="${wishlistProducts}">
                <div class="product-card">
                    <div class="product-image">
                        <c:choose>
                            <c:when test="${not empty productImages[product.id]}">
                                <img src="${productImages[product.id].url}" alt="${product.name}">
                            </c:when>
                            <c:otherwise>
                                <img src="/images/no-image.png" alt="No Image Available">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h3>${product.name}</h3>
                    <p><strong>Price:</strong> ₹ ${product.cost}</p>
                    <p><strong>Stock:</strong> ${product.stock}</p>
                    <p><strong>Category:</strong> ${product.category}</p>

                    <form action="viewProductdublicate" method="get">
                        <input type="hidden" name="productId" value="${product.id}">
                        <button type="submit" class="button-inline button-view">View</button>
                    </form>

                    <form action="removeFromWishlist" method="post">
                        <input type="hidden" name="productId" value="${product.id}">
                        <button type="submit" class="button-inline button-remove">Remove</button>
                    </form>
                </div>
            </c:forEach>
        </div>
    </c:when>

    <c:otherwise>
        <div class="empty-message-container">
            <img src="https://i.pinimg.com/564x/f6/e4/64/f6e464230662e7fa4c6a4afb92631aed.jpg" alt="Empty Wishlist">
            <p class="empty-message">Your wishlist is empty!</p>
            <p class="subtext">Start adding products you love.</p>
        </div>
    </c:otherwise>
</c:choose>

<div class="back-button-container">
    <a href="showCategory?category=">Back to Products</a>
</div>

</main>

<!-- FOOTER -->
<footer>
    &copy; 2026 Techouts Store
</footer>

</body>
</html>