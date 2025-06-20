<%-- 
    Document   : booking
    Created on : 15 Jun 2025, 10:12:06 am
    Author     : LENOVO
--%>

<%-- 
    Document   : booking
    Created on : 14 Jun 2025, 8:27:11 pm
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Room" %>
<%@ page import="dao.RoomDAO" %>
<%@ include file="/include/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Book A Room</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>

<div class="container mt-5">
    <h2>Book A Room</h2>

    <form action="../Booking/BookingServlet" method="post">
        <input type="hidden" name="action" value="bookRoom" />

        <div class="mb-3">
            <label>Select Room:</label>
            <select name="roomID" class="form-select" required>
                <%
                    List<Room> rooms = null;
                    try {
                        rooms = RoomDAO.getAllRooms();
                    } catch(Exception e) {
                        e.printStackTrace();
                    }
                    if (rooms != null) {
                        for (Room r : rooms) {
                %>
                    <option value="<%= r.getRoomID() %>"><%= r.getName() %> - <%= r.getType() %></option>
                <% }} %>
            </select>
        </div>

        <div class="mb-3">
            <label>Select Date:</label>
            <input type="date" name="date" class="form-control" required />
        </div>

        <div class="mb-3">
            <label>Select Time Slot:</label>
            <select name="timeSlot" class="form-select" required>
                <option value="Morning">Morning (10AM-12PM)</option>
                <option value="Afternoon">Afternoon (1PM-4PM)</option>
                <option value="Evening">Evening (5PM-8PM)</option>
                <option value="Night">Night (9PM-12AM)</option>
            </select>
        </div>

        <button type="submit" class="btn btn-success">Submit Booking</button>
    </form>

</div>

</body>
</html>
