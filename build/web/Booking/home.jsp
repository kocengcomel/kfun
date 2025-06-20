<%-- 
    Document   : home
    Created on : 13 Jun 2025, 2:49:32 am
    Author     : END USER
--%>

<%-- 
    Document   : home
    Created on : 13 Jun 2025, 2:49:32 am
    Author     : END USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/navbar.jsp" %>
<%@ page import="com.model.User" %>

<!DOCTYPE html>
<html>
<head>
    <title>K-Fun Karaoke</title>
    <link href="style.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="hero-section">

    <% if (user != null) { %>
        <p style="text-align: center; font-size: 1.1rem; color: #fff;">
            Welcome, <strong><%= user.getUsername() %></strong>!
        </p>
    <% } %>

    <h1 class="hero-title">Welcome to K-Fun</h1>
    <p class="hero-subtitle">Sing your heart out in the coolest karaoke rooms</p>

    <% if (user == null) { %>
        <a href="${pageContext.request.contextPath}/User/login.jsp" class="hero-btn mt-4">Login to Book</a>
    <% } else { %>
        <a href="${pageContext.request.contextPath}/Booking/standardRooms.jsp" class="hero-btn mt-4">Book Now</a>
    <% } %>

    <div class="container room-images mt-5">
        <div class="row justify-content-center text-center">

            <div class="col-md-4 mb-4">
                <a href="${pageContext.request.contextPath}/Booking/standardRooms.jsp">
                    <img src="${pageContext.request.contextPath}/image/standard-room.png" class="room-thumb" alt="Standard Room">
                </a>
                <p class="room-label">Standard</p>
            </div>

            <div class="col-md-4 mb-4">
                <a href="${pageContext.request.contextPath}/Booking/familyRooms.jsp">
                    <img src="${pageContext.request.contextPath}/image/family-room.png" class="room-thumb" alt="Family Room">
                </a>
                <p class="room-label">Family</p>
            </div>

            <div class="col-md-4 mb-4">
                <a href="${pageContext.request.contextPath}/Booking/vipRooms.jsp">
                    <img src="${pageContext.request.contextPath}/image/vip-room.png" class="room-thumb" alt="VIP Room">
                </a>
                <p class="room-label">VIP</p>
            </div>

        </div>
    </div>
</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>
