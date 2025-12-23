package com.profile.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class TestConnection {
    public static void main(String[] args) {
        try {
            // Test connection
            Connection conn = ProfileDatabase.getConnection();
            System.out.println("✅ Database connected successfully!");
            
            // Test query
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM profile");
            
            System.out.println("\n📊 Sample data from database:");
            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("id") + 
                                 " | Name: " + rs.getString("full_name") + 
                                 " | Student ID: " + rs.getString("student_id"));
            }
            
            conn.close();
            System.out.println("\n✅ Connection test completed!");
            
        } catch (Exception e) {
            System.err.println("❌ Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}