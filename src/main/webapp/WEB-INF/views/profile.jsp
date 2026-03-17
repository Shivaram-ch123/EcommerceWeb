<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>My Profile</title>

<style>
body {
	font-family: Arial, sans-serif;
	background: linear-gradient(120deg, #f093fb, #f5576c);
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

/* Profile Card */
.profile-card {
	background-color: #fff;
	border-radius: 20px;
	padding: 40px 30px 30px;
	width: 350px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
	text-align: center;
	position: relative;
}

/* Profile Image */
.profile-card img {
	width: 120px;
	height: 120px;
	border-radius: 50%;
	object-fit: cover;
	border: 5px solid #fff;
	position: absolute;
	top: -80px;
	left: 50%;
	transform: translateX(-50%);
}

.profile-card h2 {
	margin-top: 70px;
	font-size: 22px;
	color: #333;
}

.profile-card p {
	color: #777;
	margin: 5px 0;
}

.btn {
	background: linear-gradient(to right, #f093fb, #f5576c);
	color: white;
	padding: 10px 25px;
	border-radius: 25px;
	text-decoration: none;
	font-size: 14px;
	display: inline-block;
	margin-top: 15px;
}

.btn:hover {
	opacity: 0.9;
}

.error-message {
	color: #ff4d4f;
	margin-bottom: 15px;
}
</style>
</head>

<body>
	<div class="profile-card">

		<!-- Profile Image -->
		<c:choose>
			<c:when test="${not empty info and not empty info.profileImageUrl}">
				<img
					src="https://img.freepik.com/free-vector/isolated-young-handsome-man-different-poses-white-background-illustration_632498-859.jpg?semt=ais_hybrid&w=740&q=80"
					alt="Profile Picture" />
			</c:when>
			<c:otherwise>
				<img
					src="https://static.vecteezy.com/system/resources/thumbnails/032/176/191/small/business-avatar-profile-black-icon-man-of-user-symbol-in-trendy-flat-style-isolated-on-male-profile-people-diverse-face-for-social-network-or-web-vector.jpg"
					alt="Default Profile" />
			</c:otherwise>
		</c:choose>

		<!-- Error Message -->
		<c:if test="${not empty errorMessage}">
			<p class="error-message">${errorMessage}</p>
		</c:if>

		<!-- User Information -->
		<c:if test="${not empty user}">
			<h2>${user.userName}</h2>
			<p>Email: ${user.email}</p>
			<p>Phone: ${user.phoneNumber}</p>
			<p>
				Address:
				<c:choose>
					<c:when test="${not empty info and not empty info.address}">
						<c:out value="${info.address}" />
					</c:when>
					<c:otherwise>
                    Not Provided
                </c:otherwise>
				</c:choose>
			</p>

			<!-- Back Button -->
			<a class="btn"
				href="${pageContext.request.contextPath}/showCategory?category=${category}">Back
				to Products</a>
		</c:if>

		<c:if test="${not empty user}">
			<a class="btn"
				href="${pageContext.request.contextPath}/updateProfile"> Update
				Profile </a>
		</c:if>
	</div>
</body>
</html>