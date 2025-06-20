<%-- 
    Document   : roomDetails
    Created on : 13 Jun 2025, 2:10:36 am
    Author     : END USER
--%>

<%@ page import="java.util.*, com.model.Room, dao.RoomDAO" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Room Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Booking/style.css" />
    <style>
        .room-card {
            display: flex;
            flex-direction: row;
            background-color: #1a1a2e;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 0 20px rgba(162, 89, 255, 0.2);
            margin-top: 50px;
            color: #fff;
        }
        .room-img {
            width: 400px;
            height: 300px;
            object-fit: cover;
            border-radius: 16px;
            margin-right: 40px;
        }
        .btn-primary {
            background-color: #a259ff;
            border: none;
            border-radius: 30px;
            padding: 10px 30px;
            font-weight: bold;
        }
        .btn-primary:hover {
            background-color: #9333ea;
            transform: scale(1.05);
        }
    </style>
</head>

<body>

<div class="container">
    <!-- Centered Back button between navbar and card -->
    <div class="mt-5 mb-4">
        <a href="home.jsp" class="btn btn-outline-light">&larr; Back</a>
    </div>

    <%
        int roomID = Integer.parseInt(request.getParameter("roomID"));
        Room room = RoomDAO.getRoomByID(roomID);

        String basePath = request.getContextPath() + "/image/";
        String imagePath = "";
        if(room.getType().equalsIgnoreCase("VIP")){
            imagePath = basePath + "vip-room.png";
        } else if(room.getType().equalsIgnoreCase("Standard")){
            imagePath = basePath + "standard-room.png";
        } else if(room.getType().equalsIgnoreCase("Family")){
            imagePath = basePath + "family-room.png";
        }

        String bookingDate = room.getDate() != null ? room.getDate().toString() : "";
        String timeSlot = room.getTimeSlot() != null ? room.getTimeSlot() : "";
    %>

    <div class="room-card">
        <!-- LEFT: IMAGE -->
        <img src="<%= imagePath %>" class="room-img">

        <!-- RIGHT: DETAILS -->
        <div class="card-body">
            <h2><%= room.getName() %> (<%= room.getType() %>)</h2>
            <p><strong>Capacity:</strong> <%= room.getCapacity() %> pax</p>
            <p><strong>Price:</strong> RM <%= room.getPrice() %></p>
            <p><strong>Status:</strong> 
                <span class="<%= room.isAvailability() ? "text-success" : "text-danger" %>">
                    <%= room.isAvailability() ? "Available" : "Not Available" %>
                </span>
            </p>

            <!-- ✅ This is the Booking Date and Time Slot shown from room table -->
            <p><strong>Booking Date:</strong> <%= bookingDate.isEmpty() ? "-" : bookingDate %></p>
            <p><strong>Time Slot:</strong> <%= timeSlot.isEmpty() ? "-" : timeSlot %></p>

            <!-- ✅ This is the form that submits the room's current date/timeSlot -->
            <form action="<%= request.getContextPath() %>/Booking/BookingServlet" method="post" class="mt-4">
                <input type="hidden" name="action" value="bookRoom">
                <input type="hidden" name="roomID" value="<%= roomID %>">
                <input type="hidden" name="date" value="<%= bookingDate %>">
                <input type="hidden" name="timeSlot" value="<%= timeSlot %>">
                <button type="submit" class="btn btn-primary">Book Now</button>
            </form>

        </div>
    </div>
</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>
