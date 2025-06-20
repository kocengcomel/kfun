<%-- 
    Document   : profile
    Created on : 14 Jun 2025, 2:09:47 am
    Author     : END USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.model.User" %>
<%@ include file="/include/navbar.jsp" %>

<%
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    boolean isAdmin = "admin".equalsIgnoreCase(role);
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= isAdmin ? "Admin" : "User" %> Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Booking/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="profile-container">
    <h2><%= isAdmin ? "Admin" : "User" %> Profile</h2>
    <p><strong>Full Name:</strong> <%= user.getFullName() %></p>
    <p><strong>Username:</strong> <%= user.getUsername() %></p>
    <p><strong>Email:</strong> <%= user.getEmail() %></p>
    <p><strong>Phone:</strong> <%= user.getPhone() %></p>
    <p><strong>Role:</strong> <%= role %></p>

    <div class="d-flex justify-content-center gap-3 mt-4">
        <a href="editProfile.jsp" class="btn btn-primary px-4">Edit Profile</a>
        <button id="logoutBtn" class="btn btn-danger px-4">Logout</button>
    </div>
</div>

<!-- ✅ SweetAlert2 CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
document.getElementById('logoutBtn').addEventListener('click', function () {
    Swal.fire({
        icon: 'warning',
        title: 'Are you sure?',
        text: 'You will be logged out.',
        showCancelButton: true,
        confirmButtonText: 'Yes, logout!',
        cancelButtonText: 'Cancel',
        confirmButtonColor: '#9333ea',   // purple confirm
        cancelButtonColor: '#d33',       // red cancel
        reverseButtons: true,
        background: '#1a1a2e',           // dark background
        color: '#ffffff',                // white text
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = '<%= request.getContextPath() %>/User/logout.jsp';
        }
    });
});
</script>


</body>
</html>
