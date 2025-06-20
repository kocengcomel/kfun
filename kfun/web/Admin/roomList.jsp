<%-- 
    Document   : roomList
    Created on : 11 Jun 2025, 5:53:13 pm
    Author     : LENOVO
--%>


<%@ page import="java.util.List" %>
<%@ page import="com.model.Room" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/navbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Manage Rooms</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Booking/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>

<body>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="section-title">Manage Rooms</h2>
    <a href="<%= request.getContextPath() %>/Admin/addRoom.jsp" class="btn btn-purple">
        <i class="bi bi-plus-circle"></i> Add New Room
    </a>
</div>


    <div class="row">
        <%
            List<Room> rooms = (List<Room>) request.getAttribute("rooms");
            if (rooms != null && !rooms.isEmpty()) {
                for (Room r : rooms) {

                    String imagePath = "";
                    if(r.getType().equalsIgnoreCase("VIP")){
                        imagePath = "image/vip-room.png";
                    } else if(r.getType().equalsIgnoreCase("Standard")){
                        imagePath = "image/standard-room.png";
                    } else if(r.getType().equalsIgnoreCase("Family")){
                        imagePath = "image/family-room.png";
                    }

                    String badgeClass = "";
                    if(r.getType().equalsIgnoreCase("VIP")){
                        badgeClass = "bg-danger";
                    } else if(r.getType().equalsIgnoreCase("Standard")){
                        badgeClass = "bg-primary";
                    } else if(r.getType().equalsIgnoreCase("Family")){
                        badgeClass = "bg-success";
                    }
        %>

        <div class="col-md-4 mb-4">
    <div class="card h-100">
        <img src="<%= imagePath %>" class="room-img w-100">
        <div class="card-body">
            <h5 class="card-title"><%= r.getName() %></h5>
            <span class="badge <%= badgeClass %>"><%= r.getType() %></span>
            <p class="mt-3"><strong>Capacity:</strong> <%= r.getCapacity() %> pax</p>
            <p><strong>Price:</strong> RM <%= String.format("%.2f", r.getPrice()) %></p>
            <p><strong>Status:</strong> 
                <span class="text-<%= r.isAvailability() ? "success" : "danger" %>">
                    <%= r.isAvailability() ? "Available" : "Not Available" %>
                </span>
            </p>
        </div>
        <div class="card-footer d-flex justify-content-between" style="background-color: transparent; border: none;">
            <a href="RoomServlet?action=edit&id=<%= r.getRoomID() %>" class="btn-edit">
                <i class="bi bi-pencil-square"></i> Edit
            </a>
            <a href="RoomServlet?action=delete&id=<%= r.getRoomID() %>" 
               class="btn-cancel delete-btn" 
               data-id="<%= r.getRoomID() %>">
                <i class="bi bi-trash3"></i> Delete
            </a>
        </div>
    </div>
</div>


        <% }} else { %>
        <p class="text-center text-muted">No rooms available.</p>
        <% } %>
    </div>
</div>

<%@ include file="/include/footer.jsp" %>

<script>
  document.addEventListener("DOMContentLoaded", function() {
    const deleteButtons = document.querySelectorAll(".delete-btn");
    deleteButtons.forEach(button => {
      button.addEventListener("click", function(event) {
        event.preventDefault();
        const deleteUrl = this.getAttribute("href");
       Swal.fire({
  title: "Are you sure?",
  text: "This room will be permanently deleted.",
  icon: "warning",
  background: "#1a1a2e",     // dark background
  color: "#ffffff",          // white text
  showCancelButton: true,
  confirmButtonColor: "#9333ea",  // purple (theme matching)
  cancelButtonColor: "#d33",      // red cancel
  confirmButtonText: "Yes, delete it!",
  cancelButtonText: "Cancel",
  reverseButtons: true
}).then((result) => {
  if (result.isConfirmed) {
    window.location.href = deleteUrl;
  }
});

      });
    });
  });
</script>

</body>
</html>
