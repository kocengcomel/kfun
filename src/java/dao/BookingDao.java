
package dao;

import java.sql.*;

import com.model.Booking;
import com.util.DBConnection;
import java.util.ArrayList;
import java.util.List;

public class BookingDao {
    private Connection conn;

    public BookingDao() throws ClassNotFoundException {
        conn = DBConnection.getConnection();
    }

    public void insertBooking(Booking b) throws SQLException {
        String sql = "INSERT INTO bookings (userID, roomID, date, timeSlot) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, b.getUserID());
        ps.setInt(2, b.getRoomID());
        ps.setDate(3, b.getDate());
        ps.setString(4, b.getTimeSlot());
        ps.executeUpdate();
    }

    public void updateBooking(Booking b) throws SQLException {
        String sql = "UPDATE bookings SET date = ?, timeSlot = ? WHERE bookingID = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setDate(1, b.getDate());
        ps.setString(2, b.getTimeSlot());
        ps.setInt(3, b.getBookingID());
        ps.executeUpdate();
    }

    public void cancelBooking(int bookingID) throws SQLException {
        String sql = "DELETE FROM bookings WHERE bookingID = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, bookingID);
        ps.executeUpdate();
    }
    public int countBookingsByDate(Date bookingDate) {
    int count = 0;
    try {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM bookings WHERE date = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setDate(1, bookingDate);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            count = rs.getInt(1);
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}
    public boolean isAlreadyBooked(int roomID, Date date, String timeSlot) {
    boolean booked = false;
    try {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM bookings WHERE roomID = ? AND date = ? AND timeSlot = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, roomID);
        ps.setDate(2, date);
        ps.setString(3, timeSlot);
        ResultSet rs = ps.executeQuery();
        if (rs.next() && rs.getInt(1) > 0) {
            booked = true;
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return booked;
}
public List<Booking> getBookingsByDate(Date date) {
    List<Booking> list = new ArrayList<>();
    try {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT b.bookingID, b.date, b.timeSlot, r.name AS roomName, u.username " +
                     "FROM bookings b " +
                     "JOIN rooms r ON b.roomID = r.roomID " +
                     "JOIN users u ON b.userID = u.userID " +
                     "WHERE b.date = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setDate(1, date);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Booking b = new Booking();
            b.setBookingID(rs.getInt("bookingID"));
            b.setDate(rs.getDate("date"));
            b.setTimeSlot(rs.getString("timeSlot"));
            b.setRoomName(rs.getString("roomName"));  // add to Booking model
            b.setUserName(rs.getString("username"));  // add to Booking model
            list.add(b);
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
public List<Booking> getBookingsByRoomID(int roomID) {
    List<Booking> bookings = new ArrayList<>();
    try {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM bookings WHERE roomID = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, roomID);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Booking b = new Booking();
            b.setBookingID(rs.getInt("bookingID"));
            b.setUserID(rs.getInt("userID"));
            b.setRoomID(rs.getInt("roomID"));
            b.setDate(rs.getDate("date"));
            b.setTimeSlot(rs.getString("timeSlot"));
            b.setCreatedDate(rs.getDate("created_date"));

            bookings.add(b);
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return bookings;
}
public void insertBookingWithCreatedDate(Booking b) throws SQLException {
    String sql = "INSERT INTO bookings (userID, roomID, date, created_date, timeSlot) VALUES (?, ?, ?, ?, ?)";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setInt(1, b.getUserID());
    ps.setInt(2, b.getRoomID());
    ps.setDate(3, b.getDate());           // booking date
    ps.setDate(4, b.getCreatedDate());    // created_date = today
    ps.setString(5, b.getTimeSlot());
    ps.executeUpdate();
}

}

