<%-- 
    Document   : adminBookingList
    Created on : 15 Jun 2025, 10:16:02 am
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Booking" %>
<%@ include file="/include/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin - Booking List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>

<div class="container mt-5">
    <h2>Admin Booking Management</h2>

    <form method="get" action="AdminBookingServlet">
        <div class="mb-3">
            <label>Select Date:</label>
            <input type="date" name="date" value="<%= request.getAttribute("selectedDate") != null ? request.getAttribute("selectedDate") : "" %>" required>
            <button type="submit" class="btn btn-primary btn-sm">View</button>
        </div>
    </form>

    <%
        List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
        if (bookings != null && !bookings.isEmpty()) {
    %>
        <table class="table table-bordered">
            <thead class="table-light">
                <tr>
                    <th>#</th>
                    <th>Room</th>
                    <th>User</th>
                    <th>Date</th>
                    <th>Time Slot</th>
                </tr>
            </thead>
            <tbody>
            <% int i=1; for (Booking b : bookings) { %>
                <tr>
                    <td><%= i++ %></td>
                    <td><%= b.getRoomName() %></td>
                    <td><%= b.getUserName() %></td>
                    <td><%= b.getDate() %></td>
                    <td><%= b.getTimeSlot() %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <% } else { %>
        <div class="alert alert-warning">No bookings found for this date.</div>
    <% } %>

</div>

</body>
</html>
