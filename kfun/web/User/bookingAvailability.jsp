<%-- 
    Document   : bookingAvailability
    Created on : 15 Jun 2025, 10:02:22 am
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/navbar.jsp" %>

<html>
<head>
    <title>Booking Availability</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h2>Booking Availability</h2>

    <div class="alert alert-info">
        Total Rooms: <%= request.getAttribute("totalRooms") %><br>
        Booked Rooms: <%= request.getAttribute("bookedRooms") %><br>
        Remaining Rooms: <%= request.getAttribute("remaining") %>
    </div>

    <a href="myBooking.jsp" class="btn btn-primary">Back</a>
</div>

</body>
</html>


