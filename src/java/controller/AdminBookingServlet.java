/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BookingDao;
import com.model.Booking;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Admin/AdminBookingServlet")
public class AdminBookingServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dateStr = request.getParameter("date");
        List<Booking> bookings = new ArrayList<>();  // Initialize to avoid null

        try {
            BookingDao dao = new BookingDao();

            if (dateStr != null && !dateStr.isEmpty()) {
                Date date = Date.valueOf(dateStr);
                bookings = dao.getBookingsByDate(date);
                request.setAttribute("selectedDate", dateStr);
            }

            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/Admin/adminBookingList.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error loading admin bookings: " + e.getMessage());
        }
    }
}
