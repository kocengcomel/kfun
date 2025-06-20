<%-- 
    Document   : roomOptions
    Created on : 13 Jun 2025, 1:01:44 am
    Author     : END USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Room Selection - K-Fun</title>
    <link href="style.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="hero-section">
        <h1 class="hero-title">Select Your Room</h1>
        <p class="hero-subtitle">Sing your heart out in the coolest karaoke rooms</p>
        
        <div class="container room-images mt-5">
            <div class="row justify-content-center text-center">
                <div class="col-md-4 mb-4">
                    <a href="standardRooms.jsp">
                        <img src="${pageContext.request.contextPath}/image/standard-room.png" class="room-thumb" alt="Standard Room">
                    </a>
                    <p class="room-label">Standard</p>
                </div>
                <div class="col-md-4 mb-4">
                    <a href="familyRooms.jsp">
                        <img src="${pageContext.request.contextPath}/image/family-room.png" class="room-thumb" alt="Family Room">
                    </a>
                    <p class="room-label">Family</p>
                </div>
                <div class="col-md-4 mb-4">
                    <a href="vipRooms.jsp">
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