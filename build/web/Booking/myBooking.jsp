<%-- 
    Document   : myBooking
    Created on : 13 Jun 2025, 1:03:28 am
    Author     : END USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ include file="/include/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Bookings - K-Fun</title>
    <link href="style.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="hero-section">
        <h1 class="hero-title">My Booking History</h1>
        <p class="hero-subtitle">Sing your heart out in the coolest karaoke rooms</p>

        <div class="container mt-4">

        <%
            if (user == null) {
                response.sendRedirect("../User/login.jsp");
                return;
            }

            int userID = user.getUserID();

            Connection conn = com.util.DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "SELECT b.bookingID, b.date, b.created_date, b.timeSlot, r.name AS roomName, r.type AS roomType " +
                "FROM bookings b JOIN rooms r ON b.roomID = r.roomID WHERE b.userID = ?"
            );
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            if (!rs.isBeforeFirst()) {
        %>
            <div class="alert alert-info text-center mt-4">
                You have no booking history.
            </div>
        <%
            } else {
        %>
            <div class="booking-card-container">
            <%
                while (rs.next()) {
            %>
                <div class="booking-card">
                    <h5><%= rs.getString("roomName") %> (<%= rs.getString("roomType") %>)</h5>
                    <p><strong>Booking Date:</strong> <%= rs.getDate("date") %></p>
                    <p><strong>Booked On:</strong> <%= rs.getDate("created_date") %></p>
                    <p><strong>Time Slot:</strong> <%= rs.getString("timeSlot") %></p>

                    <a href="#" 
                       class="btn btn-cancel btn-sm btn-danger cancel-btn" 
                       data-url="BookingServlet?action=cancel&bookingID=<%= rs.getInt("bookingID") %>">
                       Cancel
                    </a>
                </div>
            <%
                }
            %>
            </div>
        <%
            }
            rs.close();
            ps.close();
            conn.close();
        %>
        </div>
    </div>

    <%@ include file="/include/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
    document.querySelectorAll('.cancel-btn').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const url = this.getAttribute('data-url');

            Swal.fire({
                title: 'Are you sure?',
                text: "Do you want to cancel this booking?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Yes, cancel it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = url;
                }
            });
        });
    });
    </script>

</body>
</html>
