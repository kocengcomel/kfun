<%-- 
    Document   : addRoom
    Created on : 11 Jun 2025, 5:53:30 pm
    Author     : LENOVO
--%>

<%@ include file="/include/navbar.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Add New Room</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Booking/style.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet"/>
</head>

<body>

<div class="form-container">
    <h2 class="text-center text-purple mb-4">Add New Room</h2>

    <form action="<%=request.getContextPath()%>/RoomServlet" method="post">
        <input type="hidden" name="action" value="add" />

        <!-- Room Name -->
        <div class="mb-3">
            <label for="name" class="form-label">Room Name</label>
            <input type="text" id="name" name="name" class="form-control" placeholder="Enter room name" required />
        </div>

        <!-- Room Type -->
        <div class="mb-3">
            <label for="type" class="form-label">Room Type</label>
            <select id="type" name="type" class="form-select" required>
                <option value="">-- Select Type --</option>
                <option value="VIP">VIP</option>
                <option value="Standard">Standard</option>
                <option value="Family">Family</option>
            </select>
        </div>

        <!-- Capacity -->
        <div class="mb-3">
            <label for="capacity" class="form-label">Capacity (pax)</label>
            <input type="number" id="capacity" name="capacity" min="1" class="form-control" placeholder="Enter capacity" required />
        </div>

        <!-- Price -->
        <div class="mb-3">
            <label for="price" class="form-label">Price (RM)</label>
            <input type="number" id="price" name="price" step="0.01" min="1" class="form-control" placeholder="Enter price" required />
        </div>

        <!-- Booking Date -->
        <div class="mb-3">
            <label for="date" class="form-label">Booking Date</label>
            <input type="date" id="date" name="date" class="form-control" 
                   min="<%= java.time.LocalDate.now() %>"
                   max="<%= java.time.LocalDate.now().plusDays(5) %>" required />
        </div>

        <!-- Time Slot -->
        <div class="mb-3">
            <label for="timeSlot" class="form-label">Time Slot</label>
            <select name="timeSlot" id="timeSlot" class="form-select" required>
                <option value="">-- Select Time --</option>
                <option value="10AM-12PM">10AM-12PM</option>
                <option value="12PM-2PM">12PM-2PM</option>
                <option value="2PM-4PM">2PM-4PM</option>
                <option value="4PM-6PM">4PM-6PM</option>
            </select>
        </div>

        <!-- Availability -->
        <div class="form-check form-switch mb-4">
            <input type="checkbox" id="availability" name="availability" class="form-check-input" checked />
            <label class="form-check-label" for="availability">Available</label>
        </div>

        <!-- ✅ Matched button layout to editRoom.jsp -->
        <div class="d-flex justify-content-center gap-3">
            <button type="submit" class="btn btn-primary px-4">
                <i class="bi bi-plus-circle"></i> Save Room
            </button>
            <a href="RoomServlet?action=list" class="btn btn-secondary px-4">Cancel</a>
        </div>

    </form>
</div>

<%@ include file="/include/footer.jsp" %>

</body>
</html>
