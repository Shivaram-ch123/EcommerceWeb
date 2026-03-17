<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.register-container {
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    width: 350px;
}

.register-container h2 {
    text-align: center;
    margin-bottom: 20px;
}

.register-container label {
    display: block;
    margin-top: 15px;
    margin-bottom: 5px;
    font-weight: bold;
}

.register-container input {
    width: 100%;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ccc;
}

.register-container button {
    margin-top: 20px;
    width: 100%;
    padding: 10px;
    background-color: #6c757d; /* gray */
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}

.register-container button:hover {
    background-color: #495057;
}

.error {
    color: red;
    font-size: 12px;
}
.register-container a {
    display: block;
    text-align: center;
    margin-top: 15px;
    color: #6c757d;
    text-decoration: none;
}
.register-container a:hover {
    text-decoration: underline;
}
</style>
</head>
<body>

<div class="register-container">
    <h2>Register</h2>

    <form:form action="registerUser" method="post" modelAttribute="user">
        <!-- Username -->
        <label for="username">Username</label>
        <form:input path="userName" id="username"/>
        <form:errors path="userName" cssClass="error"/>

        <!-- Password -->
        <label for="password">Password</label>
        <form:password path="password" id="password"/>
        <form:errors path="password" cssClass="error"/>

        <!-- Email -->
        <label for="email">Email</label>
        <form:input path="email" id="email"/>
        <form:errors path="email" cssClass="error"/>

        <!-- Phone -->
        <label for="phone">Phone</label>
        <form:input path="phoneNumber" id="phone"/>
        <form:errors path="phoneNumber" cssClass="error"/>

        <button type="submit">Register</button>
    </form:form>

    <a href="showlogin">Go to Login Page</a>
</div>

</body>
</html>