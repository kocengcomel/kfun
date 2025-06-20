<%-- 
    Document   : navigation
    Created on : 13 Jun 2025, 1:34:46 am
    Author     : END USER
--%>

<%@ page import="com.model.User" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="style.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<%
    String currentPage = request.getRequestURI();
    User user = (User) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
    boolean loggedIn = user != null;

    // Page indicators for active class
    String homeActive = currentPage.contains("dashboard.jsp") ? "active" : "";
    String roomActive = currentPage.contains("roomSelection.jsp") ? "active" : "";
    String bookingActive = currentPage.contains("myBooking.jsp") ? "active" : "";
    String profileActive = currentPage.contains("profile.jsp") ? "active" : "";
    String manageRoomActive = currentPage.contains("RoomServlet") ? "active-link" : "";
%>

<% if (loggedIn && "admin".equalsIgnoreCase(role)) { %>
<!-- Admin Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom sticky-top">
  <div class="container-fluid">
    <a class="navbar-brand logo-purple fw-bold" href="home.jsp">K-Fun Admin</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link <%= manageRoomActive %>" href="${pageContext.request.contextPath}/RoomServlet">Manage Room</a>
        </li>
        <li class="nav-item">
          <a class="nav-link <%= profileActive %>" href="${pageContext.request.contextPath}/User/profile.jsp">Profile Admin</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-danger" href="#" id="logoutBtnAdmin">Logout</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<% } else { %>
<!-- Regular User Navbar -->
<nav class="navbar navbar-expand-lg custom-navbar">
  <div class="container-fluid">
    <a class="navbar-brand logo-purple fw-bold" href="${pageContext.request.contextPath}/Booking/home.jsp">? K-Fun</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
      <ul class="navbar-nav">
        <% if (loggedIn) { %>
        <li class="nav-item">
          <a class="nav-link <%= homeActive %>" href="${pageContext.request.contextPath}/Booking/home.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link <%= roomActive %>" href="${pageContext.request.contextPath}/Booking/roomSelection.jsp">Room</a>
        </li>
        <li class="nav-item">
          <a class="nav-link <%= bookingActive %>" href="${pageContext.request.contextPath}/Booking/myBooking.jsp">My Booking</a>
        </li>
        <li class="nav-item">
          <a class="nav-link <%= profileActive %>" href="${pageContext.request.contextPath}/User/profile.jsp">Profile</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-danger" href="#" id="logoutBtnUser">Logout</a>
        </li>
        <% } else { %>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/User/login.jsp">Login</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/User/register.jsp">Register</a>
        </li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>
<% } %>

<!-- ? SweetAlert2 Logout Script -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const adminLogout = document.getElementById("logoutBtnAdmin");
        const userLogout = document.getElementById("logoutBtnUser");

        function showLogoutConfirm() {
            Swal.fire({
                title: 'Are you sure?',
                text: "You will be logged out.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#a259ff',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, logout!',
                background: '#1a1a2e',
                color: '#fff'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = '${pageContext.request.contextPath}/User/logout.jsp';
                }
            });
        }

        if (adminLogout) {
            adminLogout.addEventListener("click", function(e) {
                e.preventDefault();
                showLogoutConfirm();
            });
        }

        if (userLogout) {
            userLogout.addEventListener("click", function(e) {
                e.preventDefault();
                showLogoutConfirm();
            });
        }
    });
</script>
