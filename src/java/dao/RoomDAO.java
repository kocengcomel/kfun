
package dao;

import com.util.DBConnection;
import java.sql.*;
import java.util.*;
import com.model.Room;

public class RoomDAO {

    public static List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM rooms";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("roomID"));
                room.setName(rs.getString("name"));
                room.setType(rs.getString("type"));
                room.setCapacity(rs.getInt("capacity"));
                room.setPrice(rs.getDouble("price"));
                room.setDescription(rs.getString("description"));
                room.setAvailability(rs.getBoolean("availability"));

                // ✅ ADDED MISSING PART
                room.setDate(rs.getDate("date"));
                room.setTimeSlot(rs.getString("timeSlot"));

                rooms.add(room);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rooms;
    }
    public static List<Room> getAvailableRoomsOnly() {
    List<Room> list = new ArrayList<>();

   try (Connection conn = DBConnection.getConnection()) {

        // Only get rooms where date is today or future
        String sql = "SELECT * FROM rooms WHERE date >= ?";
        PreparedStatement ps = conn.prepareStatement(sql);

        // Set the current date for filtering
        ps.setDate(1, java.sql.Date.valueOf(java.time.LocalDate.now()));

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Room r = new Room();
            r.setRoomID(rs.getInt("roomID"));
            r.setName(rs.getString("name"));
            r.setType(rs.getString("type"));
            r.setCapacity(rs.getInt("capacity"));
            r.setPrice(rs.getDouble("price"));
            r.setAvailability(rs.getBoolean("availability"));
            r.setDate(rs.getDate("date"));
            r.setTimeSlot(rs.getString("timeSlot"));
            list.add(r);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}


    public static void addRoom(Room room) {
    try {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO rooms (name, type, capacity, price, availability, date, timeSlot) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, room.getName());
        ps.setString(2, room.getType());
        ps.setInt(3, room.getCapacity());
        ps.setDouble(4, room.getPrice());
        ps.setBoolean(5, room.isAvailability());
        ps.setDate(6, room.getDate());  // ✅ insert date
        ps.setString(7, room.getTimeSlot()); // ✅ insert timeSlot
        ps.executeUpdate();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
}


    public static Room getRoomByID(int roomID) {
    Room room = null;
    try {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM rooms WHERE roomID=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, roomID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            room = new Room();
            room.setRoomID(rs.getInt("roomID"));
            room.setName(rs.getString("name"));
            room.setType(rs.getString("type"));
            room.setCapacity(rs.getInt("capacity"));
            room.setPrice(rs.getDouble("price"));
            room.setDescription(rs.getString("description"));
            room.setAvailability(rs.getBoolean("availability"));
            // ✅ ADD this 2 important lines:
            room.setDate(rs.getDate("date"));
            room.setTimeSlot(rs.getString("timeSlot"));
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return room;
}

    public static void updateRoom(Room room) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE rooms SET name=?, type=?, capacity=?, price=?, description=?, availability=?, date=?, timeSlot=? WHERE roomID=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, room.getName());
            ps.setString(2, room.getType());
            ps.setInt(3, room.getCapacity());
            ps.setDouble(4, room.getPrice());
            ps.setString(5, room.getDescription());
            ps.setBoolean(6, room.isAvailability());
            ps.setDate(7, room.getDate());
            ps.setString(8, room.getTimeSlot());
            ps.setInt(9, room.getRoomID());
            ps.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void deleteRoom(int id) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM rooms WHERE roomID=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<Room> getAvailableRooms() {
        List<Room> rooms = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM rooms WHERE availability = TRUE";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("roomID"));
                room.setName(rs.getString("name"));
                room.setType(rs.getString("type"));
                room.setCapacity(rs.getInt("capacity"));
                room.setPrice(rs.getDouble("price"));
                room.setDescription(rs.getString("description"));
                room.setAvailability(rs.getBoolean("availability"));

                // ✅ ADDED MISSING PART
                room.setDate(rs.getDate("date"));
                room.setTimeSlot(rs.getString("timeSlot"));

                rooms.add(room);
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rooms;
    }

    public static int countAvailableRooms() {
        int count = 0;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM rooms WHERE availability = 1";
            PreparedStatement ps = conn.prepareStatement(sql);
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
}
