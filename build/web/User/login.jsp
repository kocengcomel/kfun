<%-- 
    Document   : login
    Created on : 13 Jun 2025, 10:50:09 pm
    Author     : END USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ include file="/include/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Booking/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="card form-container">
    <h2 class="card-title">Login</h2>
    <form action="${pageContext.request.contextPath}/UserServlet" method="post">
        <input type="hidden" name="action" value="login" />

        <label class="form-label">Username:</label>
        <input type="text" name="username" class="form-control" required>

        <label class="form-label">Password:</label>
        <input type="password" name="password" class="form-control" required>

        <br>
        <button type="submit" class="btn-purple">Login</button>
    </form>

    <p style="text-align:center; margin-top:10px;">
        Don't have an account? <a href="register.jsp" style="color:#a259ff;">Register here</a>
    </p>

    <%
        if (request.getParameter("error") != null) {
    %>
    <p class="error">Invalid login. Please try again.</p>
    <%
        } else if (request.getParameter("msg") != null) {
    %>
    <p class="success">Registration successful. Please login.</p>
    <%
        }
    %>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>


