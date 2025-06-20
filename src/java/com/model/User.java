/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author LENOVO
 */








public class User {
    private int userID;
    private String username;
    private String email;
    private String password;
    private String fullName;
    private String phone;
    private String role;

    // ✅ Default constructor
    public User() {}

    // ✅ Full constructor (THIS ONE IS THE IMPORTANT FIX)
    public User(int userID, String username, String email, String password, String fullName, String phone, String role) {
        this.userID = userID;
        this.username = username;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.phone = phone;
        this.role = role;
    }

    // Getters and setters
    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}
