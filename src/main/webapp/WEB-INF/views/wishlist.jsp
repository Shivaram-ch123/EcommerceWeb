<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Wishlist</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .products {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .product-card {
            background: white;
            padding: 20px;
            width: 250px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: center;
        }

        .product-card h3 {
            margin-bottom: 10px;
        }

        .product-card p {
            margin: 5px 0;
        }

        .button-inline {
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            margin-top: 10px;
        }

        .button-view { background: #007bff; color: white; }
        .button-remove { background: red; color: white; }
    </style>
</head>
<body>

<h2>My Wishlist</h2>

<c:choose>
    <c:when test="${not empty wishlistProducts}">
        <div class="products">
            <c:forEach var="product" items="${wishlistProducts}">
                <div class="product-card">
                    <h3>${product.name}</h3>
                    <p>Price: ₹ ${product.cost}</p>
                    <p>Stock: ${product.stock}</p>
                    <p>Category: ${product.category}</p>

                    <!-- View Product Button -->
                    <form action="viewProduct" method="get">
                        <input type="hidden" name="productId" value="${product.id}">
                        <button type="submit" class="button-inline button-view">View</button>
                    </form>

                    <!-- Remove from Wishlist Button -->
                    <form action="removeFromWishlist" method="post">
                        <input type="hidden" name="productId" value="${product.id}">
                        <button type="submit" class="button-inline button-remove">Remove</button>
                    </form>
                </div>
            </c:forEach>
        </div>
    </c:when>

    <c:otherwise>
        <p style="text-align: center; margin-top: 50px;">Your wishlist is empty!</p>
    </c:otherwise>
</c:choose>

<!-- Back to products -->
<div style="text-align: center; margin-top: 30px;">
    <a href="showCategory?category=" style="text-decoration: none; color: white; background: #6c757d; padding: 10px 20px; border-radius: 5px;">Back to Products</a>
</div>

</body>
</html>