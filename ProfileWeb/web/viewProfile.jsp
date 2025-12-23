<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.profile.bean.ProfileBean" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Student Profiles</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #FFB6D9 0%, #FFC0CB 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        
        h1 {
            color: #C71585;
            margin-bottom: 20px;
            font-size: 28px;
        }
        
        .controls {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            align-items: center;
        }
        
        .search-box {
            flex: 1;
            min-width: 250px;
            position: relative;
        }
        
        .search-box input {
            width: 100%;
            padding: 12px 15px 12px 40px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
        }

        .search-box input:focus {
            outline: none;
            border-color: #FF69B4;
        }
        
        .search-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }
        
        .filter-box select {
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            background: white;
            cursor: pointer;
        }

        .filter-box select:focus {
            outline: none;
            border-color: #FF69B4;
        }
        
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #FF69B4 0%, #FFB6D9 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(255, 105, 180, 0.4);
        }
        
        .message {
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        
        .message.success {
            background: #d4edda;
            color: #155724;
        }
        
        .message.error {
            background: #f8d7da;
            color: #721c24;
        }
        
        .profiles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
        }
        
        .profile-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .profile-card:hover {
            transform: translateY(-5px);
        }
        
        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .profile-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #FF69B4 0%, #FFB6D9 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: bold;
            margin-right: 15px;
        }
        
        .profile-title {
            flex: 1;
        }
        
        .profile-name {
            font-size: 18px;
            font-weight: 700;
            color: #333;
            margin-bottom: 3px;
        }
        
        .profile-id {
            font-size: 13px;
            color: #999;
        }
        
        .profile-details {
            margin-bottom: 15px;
        }
        
        .detail-row {
            display: flex;
            padding: 8px 0;
            font-size: 14px;
        }
        
        .detail-label {
            font-weight: 600;
            color: #666;
            width: 100px;
            flex-shrink: 0;
        }
        
        .detail-value {
            color: #333;
            flex: 1;
        }
        
        .profile-actions {
            display: flex;
            gap: 10px;
        }
        
        .btn-small {
            flex: 1;
            padding: 8px 15px;
            font-size: 13px;
            text-align: center;
        }
        
        .btn-edit {
            background: #FF69B4;
            color: white;
        }
        
        .btn-edit:hover {
            background: #FF1493;
        }
        
        .btn-delete {
            background: #e74c3c;
            color: white;
        }
        
        .btn-delete:hover {
            background: #c0392b;
        }
        
        .no-profiles {
            background: white;
            border-radius: 12px;
            padding: 50px;
            text-align: center;
            color: #999;
        }
        
        .no-profiles-icon {
            font-size: 60px;
            margin-bottom: 15px;
        }

        @media (max-width: 768px) {
            .profiles-grid {
                grid-template-columns: 1fr;
            }

            .controls {
                flex-direction: column;
            }

            .search-box, .filter-box, .btn {
                width: 100%;
            }
        }
    </style>
    <script>
        function confirmDelete(id, name) {
            if (confirm('Are you sure you want to delete the profile of ' + name + '?')) {
                window.location.href = 'ProfileServlet?action=delete&id=' + id;
            }
        }
        
        function searchProfiles() {
            const searchTerm = document.getElementById('searchInput').value;
            if (searchTerm.trim() !== '') {
                window.location.href = 'ProfileServlet?action=search&searchTerm=' + encodeURIComponent(searchTerm);
            } else {
                window.location.href = 'ProfileServlet?action=list';
            }
        }
        
        function filterByProgramme() {
            const programme = document.getElementById('programmeFilter').value;
            if (programme !== '') {
                window.location.href = 'ProfileServlet?action=filter&programme=' + encodeURIComponent(programme);
            } else {
                window.location.href = 'ProfileServlet?action=list';
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>👥 Student Profiles Database</h1>
            
            <% 
                String message = (String) request.getAttribute("message");
                String error = (String) request.getAttribute("error");
                
                if (message != null) {
            %>
                <div class="message success"><%= message %></div>
            <% } %>
            
            <% if (error != null) { %>
                <div class="message error"><%= error %></div>
            <% } %>
            
            <div class="controls">
                <div class="search-box">
                    <span class="search-icon">🔍</span>
                    <input type="text" id="searchInput" placeholder="Search by name or student ID..." 
                           value="<%= request.getAttribute("searchTerm") != null ? request.getAttribute("searchTerm") : "" %>"
                           onkeypress="if(event.keyCode==13) searchProfiles()">
                </div>
                
                <button onclick="searchProfiles()" class="btn btn-primary">Search</button>
                
                <div class="filter-box">
                    <select id="programmeFilter" onchange="filterByProgramme()">
                        <option value="">Filter by Programme</option>
                        <option value="Computer Science">Computer Science</option>
                        <option value="Information Technology">Information Technology</option>
                        <option value="Software Engineering">Software Engineering</option>
                        <option value="Data Science">Data Science</option>
                        <option value="Cybersecurity">Cybersecurity</option>
                        <option value="Business Administration">Business Administration</option>
                        <option value="Engineering">Engineering</option>
                    </select>
                </div>
                
                <a href="profilejsp.jsp" class="btn btn-primary">+ Add New Profile</a>
                <a href="homepage.html" class="btn btn-primary">🏠 Home</a>
            </div>
        </div>
        
        <%
            @SuppressWarnings("unchecked")
            List<ProfileBean> profiles = (List<ProfileBean>) request.getAttribute("profiles");
            
            if (profiles != null && !profiles.isEmpty()) {
        %>
            <div class="profiles-grid">
                <% for (ProfileBean profile : profiles) { %>
                    <div class="profile-card">
                        <div class="profile-header">
                            <div class="profile-avatar">
                                <%= profile.getFullName().substring(0, 1).toUpperCase() %>
                            </div>
                            <div class="profile-title">
                                <div class="profile-name"><%= profile.getFullName() %></div>
                                <div class="profile-id"><%= profile.getStudentId() %></div>
                            </div>
                        </div>
                        
                        <div class="profile-details">
                            <div class="detail-row">
                                <div class="detail-label">📧 Email:</div>
                                <div class="detail-value"><%= profile.getEmail() %></div>
                            </div>
                            <div class="detail-row">
                                <div class="detail-label">📱 Phone:</div>
                                <div class="detail-value"><%= profile.getPhone() != null && !profile.getPhone().isEmpty() ? profile.getPhone() : "N/A" %></div>
                            </div>
                            <div class="detail-row">
                                <div class="detail-label">🎓 Programme:</div>
                                <div class="detail-value"><%= profile.getProgramme() %></div>
                            </div>
                            <div class="detail-row">
                                <div class="detail-label">📚 Year:</div>
                                <div class="detail-value">Year <%= profile.getYearOfStudy() %></div>
                            </div>
                            <div class="detail-row">
                                <div class="detail-label">🎨 Hobbies:</div>
                                <div class="detail-value"><%= profile.getHobby() != null && !profile.getHobby().isEmpty() ? profile.getHobby() : "N/A" %></div>
                            </div>
                        </div>
                        
                        <div class="profile-actions">
                            <a href="ProfileServlet?action=edit&id=<%= profile.getId() %>" class="btn btn-small btn-edit">✏️ Edit</a>
                            <button onclick="confirmDelete(<%= profile.getId() %>, '<%= profile.getFullName() %>')" 
                                    class="btn btn-small btn-delete">🗑️ Delete</button>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <div class="no-profiles">
                <div class="no-profiles-icon">📭</div>
                <h2>No Profiles Found</h2>
                <p>There are no student profiles in the database yet.</p>
                <br>
                <a href="profilejsp.jsp" class="btn btn-primary">Add First Profile</a>
            </div>
        <% } %>
    </div>
</body>
</html>