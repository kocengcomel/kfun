<%-- 
    Document   : register
    Created on : 13 Jun 2025, 10:50:22 pm
    Author     : END USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ include file="/include/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Booking/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="card form-container">
    <h2 class="card-title">Register</h2>
    <form action="${pageContext.request.contextPath}/UserServlet" method="post">
        <input type="hidden" name="action" value="register" />

        <label class="form-label">Full Name:</label>
        <input type="text" name="fullName" class="form-control" required>

        <label class="form-label">Username:</label>
        <input type="text" name="username" class="form-control" required>

        <label class="form-label">Email:</label>
        <input type="email" name="email" class="form-control" required>

        <label class="form-label">Phone:</label>
        <input type="text" name="phone" class="form-control" 
               pattern="01[0-9]-[0-9]{7,8}" 
               title="Format: 012-3456789 or 011-12345678" 
               placeholder="e.g. 012-3456789" required>

        <label class="form-label">Password:</label>
        <input type="password" name="password" class="form-control" 
               pattern="(?=.*[a-z])(?=.*\d).{5,}" 
               title="At least 5 characters, including 1 lowercase letter and 1 number" 
               placeholder="e.g. mypass1" required>

        <br>
        <button type="submit" class="btn-purple">Register</button>
    </form>

    <p style="text-align:center; margin-top:10px;">
        Already have an account? <a href="login.jsp" style="color:#a259ff;">Login here</a>
    </p>

    <%
        if (request.getParameter("error") != null) {
    %>
    <p class="error">Registration failed. Please try again.</p>
    <%
        }
    %>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>

