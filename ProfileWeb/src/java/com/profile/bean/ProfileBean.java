package com.profile.bean;

import java.io.Serializable;

/**
 * JavaBean class to represent Profile data
 */
public class ProfileBean implements Serializable {
    private static final long serialVersionUID = 1L;
    
    // Private attributes
    private int id;
    private String studentId;
    private String fullName;
    private String email;
    private String phone;
    private String programme;
    private int yearOfStudy;
    private String hobby;
    private String address;
    private String dateCreated;
    
    // Default constructor
    public ProfileBean() {
    }
    
    // Parameterized constructor
    public ProfileBean(String studentId, String fullName, String email, String phone, 
                      String programme, int yearOfStudy, String hobby, String address) {
        this.studentId = studentId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.programme = programme;
        this.yearOfStudy = yearOfStudy;
        this.hobby = hobby;
        this.address = address;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getStudentId() {
        return studentId;
    }
    
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getProgramme() {
        return programme;
    }
    
    public void setProgramme(String programme) {
        this.programme = programme;
    }
    
    public int getYearOfStudy() {
        return yearOfStudy;
    }
    
    public void setYearOfStudy(int yearOfStudy) {
        this.yearOfStudy = yearOfStudy;
    }
    
    public String getHobby() {
        return hobby;
    }
    
    public void setHobby(String hobby) {
        this.hobby = hobby;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getDateCreated() {
        return dateCreated;
    }
    
    public void setDateCreated(String dateCreated) {
        this.dateCreated = dateCreated;
    }
    
    @Override
    public String toString() {
        return "ProfileBean{" +
                "id=" + id +
                ", studentId='" + studentId + '\'' +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", programme='" + programme + '\'' +
                ", yearOfStudy=" + yearOfStudy +
                ", hobby='" + hobby + '\'' +
                ", address='" + address + '\'' +
                ", dateCreated='" + dateCreated + '\'' +
                '}';
    }
}
