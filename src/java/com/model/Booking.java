
package com.model;

import java.sql.Date;

public class Booking {
    private int bookingID;
    private int userID;
    private int roomID;
    private Date date;
    private String timeSlot;
private String roomName;
private String userName;
private Date createdDate;

// getter
public Date getCreatedDate() {
    return createdDate;
}

// setter
public void setCreatedDate(Date createdDate) {
    this.createdDate = createdDate;
}

// add getters & setters
public String getRoomName() { return roomName; }
public void setRoomName(String roomName) { this.roomName = roomName; }
public String getUserName() { return userName; }
public void setUserName(String userName) { this.userName = userName; }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getTimeSlot() {
        return timeSlot;
    }

    public void setTimeSlot(String timeSlot) {
        this.timeSlot = timeSlot;
    }
}

