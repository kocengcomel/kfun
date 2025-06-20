<%-- 
    Document   : editProfile
    Created on : 14 Jun 2025, 2:10:00 am
    Author     : END USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.model.User" %>
<%@ include file="/include/navbar.jsp" %>

<%
    user = (User) session.getAttribute("user");
    role = (String) session.getAttribute("role");

    if (user == null) {
        response.sendRedirect("User/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Booking/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<!-- ✅ ADD OUTER CONTAINER -->
<div class="container my-5">

    <div class="form-container card mx-auto" style="max-width: 600px;">
        <h2 class="card-title">Edit Profile</h2>

        <form action="<%=request.getContextPath()%>/UserServlet" method="post">
            <input type="hidden" name="action" value="updateProfile" />
            <input type="hidden" name="userid" value="<%= user.getUserID() %>" />

            <label class="form-label">Full Name:</label>
            <input type="text" name="fullName" value="<%= user.getFullName() %>" class="form-control" required>

            <label class="form-label">Username:</label>
            <input type="text" name="username" value="<%= user.getUsername() %>" class="form-control" required>

            <label class="form-label">Email:</label>
            <input type="email" name="email" value="<%= user.getEmail() %>" class="form-control" required>

            <label class="form-label">Phone:</label>
            <input type="text" name="phone" value="<%= user.getPhone() %>" class="form-control">

            <label class="form-label">Role:</label>
            <input type="text" class="form-control" value="<%= user.getRole() %>" readonly>

            <br>
            <button type="submit" class="btn btn-primary">Save Changes</button>
        </form>
    </div>

</div>  <!-- ✅ Close container BEFORE footer -->

<%@ include file="/include/footer.jsp" %>

</body>
</html>
