<%@ page import="java.util.*, java.time.*, com.model.Room, dao.RoomDAO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Available Rooms</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Booking/style.css" />
</head>
<body>

<div class="container mt-5">
    <h2 class="mb-4 text-center">Available Rooms</h2>
    <div class="row justify-content-center">

        <%
            List<Room> rooms = RoomDAO.getAllRooms();
            LocalDate today = LocalDate.now();
            boolean hasRoom = false;

            for (Room room : rooms) {
                hasRoom = true;

                String basePath = request.getContextPath() + "/image/";
                String imagePath = "";

                if (room.getType().equalsIgnoreCase("VIP")) {
                    imagePath = basePath + "vip-room.png";
                } else if (room.getType().equalsIgnoreCase("Standard")) {
                    imagePath = basePath + "standard-room.png";
                } else if (room.getType().equalsIgnoreCase("Family")) {
                    imagePath = basePath + "family-room.png";
                }

                String badgeClass = "";
                if (room.getType().equalsIgnoreCase("VIP")) {
                    badgeClass = "badge-vip";
                } else if (room.getType().equalsIgnoreCase("Standard")) {
                    badgeClass = "badge-standard";
                } else if (room.getType().equalsIgnoreCase("Family")) {
                    badgeClass = "badge-family";
                }

                // ✅ Check if room is expired
                boolean isExpired = false;
                if (room.getDate() != null) {
                    LocalDate roomDate = room.getDate().toLocalDate();
                    isExpired = roomDate.isBefore(today);
                }
        %>

        <div class="col-md-4 mb-4">
            <a href="roomDetails.jsp?roomID=<%= room.getRoomID() %>" style="text-decoration:none; color:inherit;">
                <div class="card shadow-sm">
                    <img src="<%= imagePath %>" class="room-img w-100">
                    <div class="card-body">
                        <h5 class="card-title"><%= room.getName() %></h5>
                        <p><span class="badge <%= badgeClass %>"><%= room.getType() %></span></p>
                        <p><strong>Capacity:</strong> <%= room.getCapacity() %> pax</p>
                        <p><strong>Price:</strong> RM <%= room.getPrice() %></p>
                        <p><strong>Date:</strong> <%= room.getDate() != null ? room.getDate() : "-" %></p>
                        <p><strong>Status:</strong> 
                            <% if (isExpired) { %>
                                <span class="text-danger">Expired</span>
                            <% } else { %>
                                <span class="<%= room.isAvailability() ? "text-success" : "text-danger" %>">
                                    <%= room.isAvailability() ? "Available" : "Not Available" %>
                                </span>
                            <% } %>
                        </p>
                    </div>
                </div>
            </a>
        </div>

        <%
            }
            if (!hasRoom) {
        %>
            <div class="alert alert-warning">
                No rooms found.
            </div>
        <%
            }
        %>

    </div>
</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>
