<%-- 
    Document   : editBooking
    Created on : 13 Jun 2025, 2:14:39 am
    Author     : END USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="/include/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Booking - K-Fun</title>
    <link href="style.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
</head>
<body>
    <div class="hero-section">
        <h1 class="hero-title">Edit Booking</h1>
    <div class="container">

        <div class="edit-booking-container">
            <%
                int bookingID = Integer.parseInt(request.getParameter("bookingID"));
                Connection conn = com.util.DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM bookings WHERE bookingID = ?");
                ps.setInt(1, bookingID);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
            %>
            <form action="BookingServlet" method="post">
                <input type="hidden" name="action" value="updateBooking">
                <input type="hidden" name="bookingID" value="<%= bookingID %>">

                <div class="mb-3">
                    <label for="date" class="form-label">New Date:</label>
                    <input type="date" name="date" id="date" class="form-control" value="<%= rs.getDate("date") %>" required>
                </div>

                <div class="mb-3">
                    <label for="timeSlot" class="form-label">New Time Slot:</label>
                    <select name="timeSlot" id="timeSlot" class="form-select" required>
                        <option value="10AM-12PM" <%= rs.getString("timeSlot").equals("10AM-12PM") ? "selected" : "" %>>10AM - 12PM</option>
                        <option value="12PM-2PM" <%= rs.getString("timeSlot").equals("12PM-2PM") ? "selected" : "" %>>12PM - 2PM</option>
                        <option value="2PM-4PM" <%= rs.getString("timeSlot").equals("2PM-4PM") ? "selected" : "" %>>2PM - 4PM</option>
                        <option value="4PM-6PM" <%= rs.getString("timeSlot").equals("4PM-6PM") ? "selected" : "" %>>4PM - 6PM</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-purple">Update Booking</button>
            </form>
            <% } else { %>
            <div class="alert alert-danger">Booking not found.</div>
            <% } %>
        </div>
    </div>
        </div>

    <%@ include file="/include/footer.jsp" %>
</body>
</html>