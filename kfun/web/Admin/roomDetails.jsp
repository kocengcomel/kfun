<%@ page import="java.util.*, java.time.LocalDate, com.model.Room, com.model.Booking, dao.RoomDAO, dao.BookingDao" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Room Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Booking/style.css" />
</head>

<body>

<div class="container my-5">

    <div class="back-btn mb-3">
        <a href="home.jsp" class="btn btn-purple">&larr; Back</a>
    </div>

    <%
        int roomID = Integer.parseInt(request.getParameter("roomID"));
        Room room = RoomDAO.getRoomByID(roomID);

        String basePath = request.getContextPath() + "/image/";
        String imagePath = "";

        if (room.getType().equalsIgnoreCase("VIP")) {
            imagePath = basePath + "vip-room.png";
        } else if (room.getType().equalsIgnoreCase("Standard")) {
            imagePath = basePath + "standard-room.png";
        } else if (room.getType().equalsIgnoreCase("Family")) {
            imagePath = basePath + "family-room.png";
        }

        // ✅ Check expiry
        boolean isExpired = false;
        if (room.getDate() != null) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(room.getDate());
            LocalDate roomDate = LocalDate.of(
                cal.get(Calendar.YEAR),
                cal.get(Calendar.MONTH) + 1,
                cal.get(Calendar.DAY_OF_MONTH)
            );
            isExpired = roomDate.isBefore(LocalDate.now());
        }
    %>

    <div class="mx-auto room-card p-4" style="max-width: 600px;">
        <img src="<%= imagePath %>" class="room-img mb-4 w-100" style="max-height:300px; object-fit:cover;">

        <h3 class="room-name"><%= room.getName() %> (<%= room.getType() %>)</h3>

        <div class="mt-4">
            <p><strong>Capacity:</strong> <%= room.getCapacity() %> pax</p>
            <p><strong>Price:</strong> RM <%= room.getPrice() %></p>
            <p><strong>Date:</strong> <%= room.getDate() != null ? room.getDate().toString() : "-" %></p>
            <p><strong>Time Slot:</strong> <%= room.getTimeSlot() != null ? room.getTimeSlot() : "-" %></p>

            <p><strong>Status:</strong> 
                <span class="badge <%= isExpired ? "bg-danger" : (room.isAvailability() ? "bg-success" : "bg-danger") %>">
                    <%= isExpired ? "Expired" : (room.isAvailability() ? "Available" : "Not Available") %>
                </span>
            </p>
        </div>

        <h5 class="mt-4 section-title">Booking Records</h5>

        <%
            BookingDao bookingDao = new BookingDao();
            List<Booking> bookings = bookingDao.getBookingsByRoomID(roomID);
            if (bookings.isEmpty()) {
        %>
            <div class="alert alert-info mt-2">No bookings for this room.</div>
        <%
            } else {
                for (Booking b : bookings) {
        %>
            <div class="booking-item mb-2 p-2 bg-dark rounded">
                <strong>Booking Date:</strong> <%= b.getDate() %> <br>
                <strong>Created On:</strong> <%= b.getCreatedDate() %> <br>
                <strong>Time Slot:</strong> <%= b.getTimeSlot() %>
            </div>
        <%
                }
            }
        %>
    </div>

</div>

<%@ include file="/include/footer.jsp" %>

</body>
</html>
