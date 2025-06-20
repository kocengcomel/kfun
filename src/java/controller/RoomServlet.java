/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RoomDAO;
import com.model.Room;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;
import java.time.*;

public class RoomServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            listRooms(request, response);
        } else if (action.equals("edit")) {
            showEditForm(request, response);
        } else if (action.equals("delete")) {
            deleteRoom(request, response);
        } else {
            // default action: list rooms
            listRooms(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("roomID");
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        double price = Double.parseDouble(request.getParameter("price"));
        boolean availability = request.getParameter("availability") != null;

        // ✅ ✅ ✅ NEW PART to handle date & timeSlot
        String dateStr = request.getParameter("date");
        String timeSlot = request.getParameter("timeSlot");

        Room room = new Room();
        room.setName(name);
        room.setType(type);
        room.setCapacity(capacity);
        room.setPrice(price);
        room.setAvailability(availability);

        // ✅ Set date and timeSlot into Room object
        try {
            java.sql.Date sqlDate = java.sql.Date.valueOf(dateStr);
            room.setDate(sqlDate);
        } catch (Exception e) {
            e.printStackTrace();
            room.setDate(null);  // or handle default value if needed
        }

        room.setTimeSlot(timeSlot);

        if (id == null || id.isEmpty()) {
            RoomDAO.addRoom(room);
        } else {
            room.setRoomID(Integer.parseInt(id));
            RoomDAO.updateRoom(room);
        }

        response.sendRedirect("RoomServlet?action=list");
    }

    private void listRooms(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        List<Room> rooms;

        if ("admin".equalsIgnoreCase(role)) {
            rooms = RoomDAO.getAllRooms();
        } else {
            // Filter: show only rooms that are not expired
            List<Room> allRooms = RoomDAO.getAvailableRoomsOnly();
            LocalDate today = LocalDate.now();
            rooms = new ArrayList<>();
            for (Room r : allRooms) {
                java.sql.Date date = r.getDate();
                if (date != null && !date.toLocalDate().isBefore(today)) {
                    rooms.add(r);
                }
            }
        }

        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("/Admin/roomList.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Room room = RoomDAO.getRoomByID(id);
        request.setAttribute("room", room);
        request.getRequestDispatcher("/Admin/editRoom.jsp").forward(request, response);
    }

    private void deleteRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        RoomDAO.deleteRoom(id);
        response.sendRedirect("RoomServlet?action=list");
    }
}
