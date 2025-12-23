package com.profile.servlet;

import com.profile.bean.ProfileBean;
import com.profile.dao.ProfileDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

//@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProfileDAO profileDAO;
    
    @Override
public void init() throws ServletException {
    profileDAO = new ProfileDAO();
    System.out.println("ProfileServlet initialized successfully");
    System.out.println("ProfileDAO created: " + (profileDAO != null));
}

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    System.out.println("========================================");
    System.out.println("=== doGet() CALLED ===");
    System.out.println("========================================");
    
    String action = request.getParameter("action");
    System.out.println("doGet - Action parameter: " + action);
    
    if (action == null) {
        action = "list";
    }
    
    switch (action) {
        case "edit":
            showEditForm(request, response);
            break;
        case "delete":
            deleteProfile(request, response);
            break;
        case "search":
            searchProfiles(request, response);
            break;
        case "filter":
            filterProfiles(request, response);
            break;
        case "list":
        default:
            listProfiles(request, response);
            break;
    }
}

@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    System.out.println("========================================");
    System.out.println("=== doPost() CALLED ===");
    System.out.println("========================================");
    
    String action = request.getParameter("action");
    System.out.println("doPost - Action parameter: " + action);
    
    if (action == null) {
        action = "add";
    }
    
    switch (action) {
        case "add":
            addProfile(request, response);
            break;
        case "update":
            updateProfile(request, response);
            break;
        default:
            listProfiles(request, response);
            break;
    }
}
    
    /**
     * Add a new profile
     */
    private void addProfile(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    System.out.println("=== addProfile method called ===");
    
    // Get form parameters
    String studentId = request.getParameter("studentId");
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String programme = request.getParameter("programme");
    String yearStr = request.getParameter("yearOfStudy");
    String hobby = request.getParameter("hobby");
    String address = request.getParameter("address");
    
    System.out.println("Student ID: " + studentId);
    System.out.println("Full Name: " + fullName);
    System.out.println("Email: " + email);
    
    // Create ProfileBean object
    ProfileBean profile = new ProfileBean();
    profile.setStudentId(studentId);
    profile.setFullName(fullName);
    profile.setEmail(email);
    profile.setPhone(phone);
    profile.setProgramme(programme);
    profile.setYearOfStudy(yearStr != null && !yearStr.isEmpty() ? Integer.parseInt(yearStr) : 1);
    profile.setHobby(hobby);
    profile.setAddress(address);
    
    System.out.println("ProfileBean created: " + profile);
    System.out.println("Attempting to insert into database...");
    
    // Insert into database
    boolean success = false;
    try {
        success = profileDAO.insertProfile(profile);
        System.out.println("Insert result: " + success);
    } catch (Exception e) {
        System.err.println("Error inserting profile: " + e.getMessage());
        e.printStackTrace();
    }
    
    if (success) {
        System.out.println("Forwarding to result.jsp");
        request.setAttribute("profile", profile);
        request.setAttribute("message", "Profile added successfully!");
        request.getRequestDispatcher("result.jsp").forward(request, response);  // ← Changed to result.jsp
    } else {
        System.out.println("Insert failed, forwarding back to profilejsp.jsp");
        request.setAttribute("error", "Failed to add profile. Student ID might already exist.");
        request.getRequestDispatcher("profilejsp.jsp").forward(request, response);
    }

    
    System.out.println("=== addProfile method completed ===");
}
    
    /**
     * List all profiles
     */
  private void listProfiles(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    List<ProfileBean> profiles = profileDAO.getAllProfiles();
    request.setAttribute("profiles", profiles);
   request.getRequestDispatcher("/viewProfile.jsp").forward(request, response);

}

    /**
     * Show edit form for a profile
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ProfileBean profile = profileDAO.getProfileById(id);
        request.setAttribute("profile", profile);
        request.getRequestDispatcher("editProfile.jsp").forward(request, response);
    }
    
    /**
     * Update an existing profile
     */
    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ProfileBean profile = new ProfileBean();
        profile.setId(Integer.parseInt(request.getParameter("id")));
        profile.setStudentId(request.getParameter("studentId"));
        profile.setFullName(request.getParameter("fullName"));
        profile.setEmail(request.getParameter("email"));
        profile.setPhone(request.getParameter("phone"));
        profile.setProgramme(request.getParameter("programme"));
        
        String yearStr = request.getParameter("yearOfStudy");
        profile.setYearOfStudy(yearStr != null && !yearStr.isEmpty() ? Integer.parseInt(yearStr) : 1);
        
        profile.setHobby(request.getParameter("hobby"));
        profile.setAddress(request.getParameter("address"));
        
        boolean success = profileDAO.updateProfile(profile);
        
        if (success) {
            request.setAttribute("message", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile.");
        }
        
        listProfiles(request, response);
    }
    
    /**
     * Delete a profile
     */
    private void deleteProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = profileDAO.deleteProfile(id);
        
        if (success) {
            request.setAttribute("message", "Profile deleted successfully!");
        } else {
            request.setAttribute("error", "Failed to delete profile.");
        }
        
        listProfiles(request, response);
    }
    
    /**
     * Search profiles by name or student ID
     */
  private void searchProfiles(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    System.out.println("=== searchProfiles() CALLED ===");
    String searchTerm = request.getParameter("searchTerm");
    System.out.println("Search term: " + searchTerm);
    
    if (searchTerm == null || searchTerm.trim().isEmpty()) {
        System.out.println("Empty search term, redirecting to list");
        response.sendRedirect("ProfileServlet?action=list");
        return;
    }
    
    List<ProfileBean> profiles = profileDAO.searchProfiles(searchTerm);
    System.out.println("Found " + profiles.size() + " profiles");
    
    request.setAttribute("profiles", profiles);
    request.setAttribute("searchTerm", searchTerm);
    
    System.out.println("Forwarding to viewProfiles.jsp");  // Add this log
    request.getRequestDispatcher("viewProfile.jsp").forward(request, response);  // Make sure this line is correct
    System.out.println("Forward completed");  // Add this log
}

    /**
     * Filter profiles by programme
     */
    private void filterProfiles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         System.out.println("=== filterProfiles() CALLED ===");
    String programme = request.getParameter("programme");
    System.out.println("Filter programme: " + programme);
    
    if (programme == null || programme.trim().isEmpty()) {
        System.out.println("Empty programme filter, redirecting to list");
        response.sendRedirect("ProfileServlet?action=list");
        return;
    }
    
    List<ProfileBean> profiles = profileDAO.filterByProgramme(programme);
    System.out.println("Found " + profiles.size() + " profiles");
    
    request.setAttribute("profiles", profiles);
    request.setAttribute("filterProgramme", programme);
    
    System.out.println("Forwarding to viewProfiles.jsp");
    request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
    System.out.println("Forward completed");
    }
}