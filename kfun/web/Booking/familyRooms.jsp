<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.time.LocalDate" %>
<%@ include file="/include/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Family Rooms - K-Fun</title>
    <link href="style.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="hero-section">
    <h1 class="hero-title">Family Room</h1>
    <p class="hero-subtitle">Enjoy fun karaoke time with the whole family</p>

    <div class="container mt-4">

        <!-- 🔍 Search Form -->
        <form method="get" class="mb-4">
            <div class="row justify-content-center">
                <div class="col-md-4">
                    <input type="date" name="searchDate" class="form-control" 
                        min="<%= LocalDate.now() %>" 
                        max="<%= LocalDate.now().plusDays(5) %>"
                        value="<%= request.getParameter("searchDate") != null ? request.getParameter("searchDate") : "" %>"
                        required>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-purple w-100">Search</button>
                </div>
            </div>
        </form>

        <div class="row">
            <%
                String selectedDate = request.getParameter("searchDate");
                Connection conn = com.util.DBConnection.getConnection();
                PreparedStatement ps;

                if (selectedDate != null) {
                    ps = conn.prepareStatement("SELECT * FROM rooms WHERE type='Family' AND availability = 1 AND date = ?");
                    ps.setDate(1, Date.valueOf(selectedDate));
                } else {
                    ps = conn.prepareStatement("SELECT * FROM rooms WHERE type='Family' AND availability = 1");
                }

                ResultSet rs = ps.executeQuery();
                boolean found = false;
                LocalDate today = LocalDate.now();
                boolean isAdmin = "admin".equalsIgnoreCase(role);

                while (rs.next()) {
                    java.sql.Date roomDate = rs.getDate("date");
                    boolean isExpired = false;

                    if (roomDate != null) {
                        LocalDate roomLocal = roomDate.toLocalDate();
                        isExpired = roomLocal.isBefore(today);
                    }

                    if (!isAdmin && isExpired) {
                        continue;
                    }

                    found = true;
            %>

            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body text-center">
                        <a href="roomDetails.jsp?roomID=<%= rs.getInt("roomID") %>">
                            <img src="${pageContext.request.contextPath}/image/family-room.png" class="room-thumb" alt="Family Room">
                        </a>
                        <p class="room-label mt-2">Family</p>
                        <h5 class="card-title text-purple"><%= rs.getString("name") %></h5>
                        <p class="card-text">
                            Capacity: <%= rs.getInt("capacity") %><br>
                            Price: RM <%= rs.getBigDecimal("price") %><br>
                            Date: <%= roomDate != null ? roomDate.toString() : "-" %>
                            <% if (isExpired && isAdmin) { %>
                                <span class="badge bg-danger ms-2">Expired</span>
                            <% } %><br>
                            Time Slot: <%= rs.getString("timeSlot") != null ? rs.getString("timeSlot") : "-" %>
                        </p>
                        <a href="roomDetails.jsp?roomID=<%= rs.getInt("roomID") %>" class="btn btn-purple">View Details</a>
                    </div>
                </div>
            </div>

            <%
                }
                if (!found) {
            %>
            <div class="alert alert-warning text-center">
                No family room available for the selected date.
            </div>
            <%
                }
                rs.close();
                ps.close();
                conn.close();
            %>
        </div>
    </div>
</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>
