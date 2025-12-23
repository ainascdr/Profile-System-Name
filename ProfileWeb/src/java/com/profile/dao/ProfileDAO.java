package com.profile.dao;

import com.profile.bean.ProfileBean;
import com.profile.util.ProfileDatabase;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// Data Access Object for Profile operations
public class ProfileDAO {
    
    // Insert a new profile into the database
    public boolean insertProfile(ProfileBean profile) {
        String sql = "INSERT INTO profile (student_id, full_name, email, phone, programme, year_of_study, hobby, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = ProfileDatabase.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, profile.getStudentId());
            pstmt.setString(2, profile.getFullName());
            pstmt.setString(3, profile.getEmail());
            pstmt.setString(4, profile.getPhone());
            pstmt.setString(5, profile.getProgramme());
            pstmt.setInt(6, profile.getYearOfStudy());
            pstmt.setString(7, profile.getHobby());
            pstmt.setString(8, profile.getAddress());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get all profiles from the database
    public List<ProfileBean> getAllProfiles() {
        List<ProfileBean> profiles = new ArrayList<>();
        String sql = "SELECT * FROM profile ORDER BY date_created DESC";
        
        try (Connection conn = ProfileDatabase.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                ProfileBean profile = extractProfileFromResultSet(rs);
                profiles.add(profile);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return profiles;
    }
    
    // Search profiles by name or student ID
    public List<ProfileBean> searchProfiles(String searchTerm) {
    List<ProfileBean> profiles = new ArrayList<>();
    String sql = "SELECT * FROM profile WHERE full_name LIKE ? OR student_id LIKE ? ORDER BY date_created DESC";
    
    try (Connection conn = ProfileDatabase.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        String searchPattern = "%" + searchTerm + "%";
        pstmt.setString(1, searchPattern);
        pstmt.setString(2, searchPattern);
        
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            ProfileBean profile = extractProfileFromResultSet(rs);
            profiles.add(profile);
        }
        
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return profiles;
}

    
    // Get a single profile by ID
    public ProfileBean getProfileById(int id) {
        String sql = "SELECT * FROM profile WHERE id = ?";
        
        try (Connection conn = ProfileDatabase.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractProfileFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Update an existing profile
    public boolean updateProfile(ProfileBean profile) {
        String sql = "UPDATE profile SET student_id = ?, full_name = ?, email = ?, phone = ?, programme = ?, year_of_study = ?, hobby = ?, address = ? WHERE id = ?";
        
        try (Connection conn = ProfileDatabase.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, profile.getStudentId());
            pstmt.setString(2, profile.getFullName());
            pstmt.setString(3, profile.getEmail());
            pstmt.setString(4, profile.getPhone());
            pstmt.setString(5, profile.getProgramme());
            pstmt.setInt(6, profile.getYearOfStudy());
            pstmt.setString(7, profile.getHobby());
            pstmt.setString(8, profile.getAddress());
            pstmt.setInt(9, profile.getId());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete a profile by ID
    public boolean deleteProfile(int id) {
        String sql = "DELETE FROM profile WHERE id = ?";
        
        try (Connection conn = ProfileDatabase.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    / Filter profiles by programme
    public List<ProfileBean> filterByProgramme(String programme) {
        List<ProfileBean> profiles = new ArrayList<>();
        String sql = "SELECT * FROM profile WHERE programme = ? ORDER BY date_created DESC";
        
        try (Connection conn = ProfileDatabase.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, programme);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ProfileBean profile = extractProfileFromResultSet(rs);
                profiles.add(profile);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return profiles;
    }
    
    // Helper method to extract ProfileBean from ResultSet
    private ProfileBean extractProfileFromResultSet(ResultSet rs) throws SQLException {
        ProfileBean profile = new ProfileBean();
        profile.setId(rs.getInt("id"));
        profile.setStudentId(rs.getString("student_id"));
        profile.setFullName(rs.getString("full_name"));
        profile.setEmail(rs.getString("email"));
        profile.setPhone(rs.getString("phone"));
        profile.setProgramme(rs.getString("programme"));
        profile.setYearOfStudy(rs.getInt("year_of_study"));
        profile.setHobby(rs.getString("hobby"));
        profile.setAddress(rs.getString("address"));
        profile.setDateCreated(rs.getTimestamp("date_created").toString());
        return profile;
    }

}
