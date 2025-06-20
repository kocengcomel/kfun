<%-- 
    Document   : logout
    Created on : 14 Jun 2025, 1:02:35 pm
    Author     : END USER
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Remove specific session attributes
    session.removeAttribute("user");
    session.removeAttribute("role");

    // Invalidate the session
    session.invalidate();

    // Redirect to login page
// ✅ Instead of redirecting immediately, we add a query parameter
    response.sendRedirect("login.jsp?logout=success");
%>
