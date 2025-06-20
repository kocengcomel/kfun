<%-- 
    Document   : editRoom
    Created on : 11 Jun 2025, 5:53:44 pm
    Author     : LENOVO
--%>

<%@ include file="/include/navbar.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.model.Room" %>

<%
    Room room = (Room) request.getAttribute("room");
    if (room == null) {
        response.sendRedirect("RoomServlet?action=list");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Edit Room</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Booking/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container">
    <div class="form-container">
        <h2 class="section-title">Edit Room</h2>

        <form action="RoomServlet" method="post">
            <input type="hidden" name="action" value="update"/>
            <input type="hidden" name="roomID" value="<%= room.getRoomID() %>" />

            <div class="mb-3">
                <label for="name" class="form-label">Room Name</label>
                <input id="name" type="text" name="name" class="form-control" value="<%= room.getName() %>" required/>
            </div>

            <div class="mb-3">
                <label for="type" class="form-label">Room Type</label>
                <select id="type" name="type" class="form-select" required>
                    <option value="VIP" <%= "VIP".equals(room.getType()) ? "selected" : "" %>>VIP</option>
                    <option value="Standard" <%= "Standard".equals(room.getType()) ? "selected" : "" %>>Standard</option>
                    <option value="Family" <%= "Family".equals(room.getType()) ? "selected" : "" %>>Family</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="capacity" class="form-label">Capacity (pax)</label>
                <input id="capacity" type="number" name="capacity" min="1" class="form-control" value="<%= room.getCapacity() %>" required/>
            </div>

            <div class="mb-3">
                <label for="price" class="form-label">Price (RM)</label>
                <input id="price" type="number" name="price" step="0.01" min="1" class="form-control" value="<%= room.getPrice() %>" required/>
            </div>

            <div class="mb-4 form-check form-switch">
                <input id="availability" class="form-check-input" type="checkbox" name="availability" <%= room.isAvailability() ? "checked" : "" %> />
                <label for="availability" class="form-check-label">Available</label>
            </div>

            <!-- ✅ Adjusted button spacing -->
            <div class="d-flex justify-content-center gap-3">
                <button type="submit" class="btn btn-primary px-4">
                    <i class="bi bi-save"></i> Update Room
                </button>
                <a href="RoomServlet?action=list" class="btn btn-secondary px-4">Cancel</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="/include/footer.jsp" %>

</body>
</html>
