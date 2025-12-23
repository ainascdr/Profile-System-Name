package com.profile.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ProfileDatabase {
    
    // Java DB (Derby) connection settings - NO DOWNLOAD NEEDED!
    private static final String URL = "jdbc:derby://localhost:1527/student_profile";
    private static final String USER = "root";
    private static final String PASSWORD = " ";
    
    static {
        try {
            // Derby driver is already included in NetBeans!
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException e) {
            System.err.println("Derby JDBC Driver not found!");
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
