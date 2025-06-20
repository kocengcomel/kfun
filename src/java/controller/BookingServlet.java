
package controller;

import dao.BookingDao;
import dao.RoomDAO;
import com.model.Booking;
import com.model.User;
import com.util.DBConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;

@WebServlet("/Booking/BookingServlet")
public class BookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            BookingDao dao = new BookingDao();

            if ("bookRoom".equals(action)) {
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user");

                if (user == null) {
                    response.sendRedirect("../User/login.jsp");
                    return;
                }

                String roomIDStr = request.getParameter("roomID");
                String dateStr = request.getParameter("date");
                String timeSlot = request.getParameter("timeSlot");

                if (roomIDStr == null || dateStr == null || timeSlot == null ||
                        roomIDStr.isEmpty() || dateStr.isEmpty() || timeSlot.isEmpty()) {
                    throw new ServletException("Missing booking form data");
                }

                Booking b = new Booking();
                int roomID = Integer.parseInt(roomIDStr);
                b.setUserID(user.getUserID());
                b.setRoomID(roomID);
                b.setDate(Date.valueOf(dateStr)); // Booking Date (selected)
                b.setCreatedDate(Date.valueOf(java.time.LocalDate.now())); // Created On (today)
                b.setTimeSlot(timeSlot);

                boolean alreadyBooked = isRoomAlreadyBooked(roomID, b.getDate(), timeSlot);
                if (alreadyBooked) {
                    request.setAttribute("error", "This room is already booked for the selected date & timeslot.");
                    request.getRequestDispatcher("../User/booking.jsp").forward(request, response);
                    return;
                }

                dao.insertBookingWithCreatedDate(b); // ✅ Inserting both booking date + created date

                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(
                        "UPDATE rooms SET availability = FALSE WHERE roomID = ?");
                ps.setInt(1, roomID);
                ps.executeUpdate();
                conn.close();

                response.sendRedirect("myBooking.jsp");

            } else if ("updateBooking".equals(action)) {
                String bookingIDStr = request.getParameter("bookingID");
                String dateStr = request.getParameter("date");
                String timeSlot = request.getParameter("timeSlot");

                if (bookingIDStr == null || dateStr == null || timeSlot == null ||
                        bookingIDStr.isEmpty() || dateStr.isEmpty() || timeSlot.isEmpty()) {
                    throw new ServletException("Missing update booking data");
                }

                Booking b = new Booking();
                b.setBookingID(Integer.parseInt(bookingIDStr));
                b.setDate(Date.valueOf(dateStr)); // booking date (selected by user)
                b.setCreatedDate(Date.valueOf(java.time.LocalDate.now())); // today's date
                b.setTimeSlot(timeSlot);

                dao.updateBooking(b);
                response.sendRedirect("myBooking.jsp");

            } else if ("checkAvailability".equals(action)) {
                String dateStr = request.getParameter("date");
                Date selectedDate = Date.valueOf(dateStr);

                int totalRooms = RoomDAO.countAvailableRooms();
                int bookedRooms = dao.countBookingsByDate(selectedDate);
                int remaining = totalRooms - bookedRooms;

                request.setAttribute("totalRooms", totalRooms);
                request.setAttribute("bookedRooms", bookedRooms);
                request.setAttribute("remaining", remaining);
                request.setAttribute("selectedDate", selectedDate);

                request.getRequestDispatcher("bookingAvailability.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error processing booking: " + e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("cancel".equals(action)) {
                String bookingIDStr = request.getParameter("bookingID");
                if (bookingIDStr == null || bookingIDStr.isEmpty()) {
                    throw new ServletException("Missing bookingID for cancel");
                }

                int bookingID = Integer.parseInt(bookingIDStr);
                BookingDao dao = new BookingDao();

                Connection conn = DBConnection.getConnection();
                PreparedStatement ps1 = conn.prepareStatement(
                        "SELECT roomID FROM bookings WHERE bookingID = ?");
                ps1.setInt(1, bookingID);
                ResultSet rs = ps1.executeQuery();

                int roomID = -1;
                if (rs.next()) {
                    roomID = rs.getInt("roomID");
                }

                dao.cancelBooking(bookingID);

                if (roomID != -1) {
                    PreparedStatement ps2 = conn.prepareStatement(
                            "UPDATE rooms SET availability = TRUE WHERE roomID = ?");
                    ps2.setInt(1, roomID);
                    ps2.executeUpdate();
                }

                conn.close();

                response.sendRedirect("myBooking.jsp?cancelSuccess=true");
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error canceling booking: " + e.getMessage());
        }
    }

    private boolean isRoomAlreadyBooked(int roomID, Date date, String timeSlot) {
        boolean booked = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM bookings WHERE roomID = ? AND date = ? AND timeSlot = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, roomID);
            ps.setDate(2, date);
            ps.setString(3, timeSlot);
            ResultSet rs = ps.executeQuery();
            ps.executeUpdate();
            if (rs.next() && rs.getInt(1) > 0) {
                booked = true;
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return booked;
    }
}
