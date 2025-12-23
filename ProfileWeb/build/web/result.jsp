<%@ page import="com.profile.bean.ProfileBean" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Profile - Display</title>
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
            padding: 40px 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        .breadcrumb {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 30px;
            font-size: 0.9em;
            color: rgba(255,255,255,0.8);
        }

        .breadcrumb .step {
            padding: 8px 15px;
            border-radius: 20px;
            background: rgba(255,255,255,0.1);
        }

        .breadcrumb .step.active {
            background: white;
            color: #FF69B4;
            font-weight: 600;
        }

        .profile-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 30px 80px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.95);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .header-banner {
            background: linear-gradient(135deg, #FF69B4 0%, #FFB6D9 100%);
            color: white;
            padding: 60px 40px;
            text-align: center;
        }

        .header-banner h1 {
            font-size: 3em;
            margin-bottom: 10px;
        }

        .header-banner .subtitle {
            font-size: 1.2em;
            opacity: 0.9;
        }

        .profile-content {
            padding: 50px;
        }

        .section {
            margin-bottom: 45px;
        }

        .section:last-child {
            margin-bottom: 0;
        }

        .section-header {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 1.8em;
            color: #FF1493;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 3px solid #f0f0f0;
        }

        .section-icon {
            font-size: 1.5em;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .info-box {
            background: linear-gradient(135deg, #fff5f8 0%, #ffe6f0 100%);
            padding: 24px;
            border-radius: 12px;
            border-left: 5px solid #FF69B4;
            transition: all 0.3s;
        }

        .info-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(255, 105, 180, 0.15);
        }

        .info-label {
            color: #FF69B4;
            font-weight: 700;
            font-size: 0.85em;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }

        .info-value {
            color: #333;
            font-size: 1.2em;
            word-break: break-word;
            line-height: 1.5;
        }

        .bio-box {
            background: linear-gradient(135deg, #fff5f8 0%, #ffe6f0 100%);
            padding: 30px;
            border-radius: 12px;
            border-left: 5px solid #C71585;
            margin-top: 20px;
            line-height: 1.8;
        }

        .bio-box p {
            color: #333;
            font-size: 1.05em;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 50px;
            justify-content: center;
            padding-top: 30px;
            border-top: 2px solid #f0f0f0;
            flex-wrap: wrap;
        }

        .btn {
            padding: 16px 35px;
            font-size: 1.05em;
            font-weight: 600;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }

        .btn-primary {
            background: linear-gradient(135deg, #FF69B4 0%, #FFB6D9 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(255, 105, 180, 0.4);
        }

        .btn-secondary {
            background: #f0f0f0;
            color: #333;
        }

        .btn-secondary:hover {
            background: #e0e0e0;
        }

        .btn-info {
            background: #fff0f5;
            color: #FF69B4;
            border: 2px solid #FF69B4;
        }

        .btn-info:hover {
            background: #FF69B4;
            color: white;
        }

        .footer-info {
            text-align: center;
            color: #999;
            font-size: 0.95em;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 2px solid #f0f0f0;
        }

        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            border-left: 5px solid #28a745;
            animation: slideIn 0.5s ease-out;
        }

        .success-message::before {
            content: "✓ ";
            font-weight: bold;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @media (max-width: 768px) {
            .header-banner {
                padding: 40px 20px;
            }

            .header-banner h1 {
                font-size: 2em;
            }

            .profile-content {
                padding: 30px 20px;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

        @media print {
            body {
                background: white;
            }

            .breadcrumb, .action-buttons {
                display: none;
            }

            .profile-card {
                box-shadow: none;
            }
        }
    </style>
</head>
<body>
    <% 
        ProfileBean profile = (ProfileBean) request.getAttribute("profile");
        String message = (String) request.getAttribute("message");
    %>
    
    <div class="container">
        <div class="breadcrumb">
            <span class="step">1. Home</span>
            <span class="step">2. Form</span>
            <span class="step active">3. Your Profile</span>
        </div>

        <div class="profile-card">
            <div class="header-banner">
                <h1>🎉 Welcome, <%= profile != null ? profile.getFullName() : "User" %>!</h1>
                <p class="subtitle">Your Profile Has Been Created Successfully</p>
            </div>

            <div class="profile-content">
                <% if (message != null) { %>
                    <div class="success-message">
                        <%= message %>
                    </div>
                <% } %>

                <% if (profile != null) { %>
                    <!-- Personal Information Section -->
                    <div class="section">
                        <div class="section-header">
                            <span class="section-icon">👤</span>
                            <span>Personal Information</span>
                        </div>
                        <div class="info-grid">
                            <div class="info-box">
                                <div class="info-label">Student ID</div>
                                <div class="info-value"><%= profile.getStudentId() %></div>
                            </div>
                            <div class="info-box">
                                <div class="info-label">Full Name</div>
                                <div class="info-value"><%= profile.getFullName() %></div>
                            </div>
                            <div class="info-box">
                                <div class="info-label">Email Address</div>
                                <div class="info-value">
                                    <a href="mailto:<%= profile.getEmail() %>" 
                                       style="color: #FF69B4; text-decoration: none;">
                                        <%= profile.getEmail() %>
                                    </a>
                                </div>
                            </div>
                            <div class="info-box">
                                <div class="info-label">Phone Number</div>
                                <div class="info-value">
                                    <%= profile.getPhone() != null && !profile.getPhone().isEmpty() ? profile.getPhone() : "Not provided" %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Academic Information Section -->
                    <div class="section">
                        <div class="section-header">
                            <span class="section-icon">📚</span>
                            <span>Academic Information</span>
                        </div>
                        <div class="info-grid">
                            <div class="info-box">
                                <div class="info-label">Programme / Course</div>
                                <div class="info-value"><%= profile.getProgramme() %></div>
                            </div>
                            <div class="info-box">
                                <div class="info-label">Year of Study</div>
                                <div class="info-value">Year <%= profile.getYearOfStudy() %></div>
                            </div>
                        </div>
                    </div>

                    <!-- Hobbies Section -->
                    <div class="section">
                        <div class="section-header">
                            <span class="section-icon">🎯</span>
                            <span>Interests & Hobbies</span>
                        </div>
                        <div class="bio-box">
                            <p>
                                <%= profile.getHobby() != null && !profile.getHobby().isEmpty() ? profile.getHobby() : "No hobbies provided" %>
                            </p>
                        </div>
                    </div>

                    <!-- Address Section -->
                    <% if (profile.getAddress() != null && !profile.getAddress().isEmpty()) { %>
                    <div class="section">
                        <div class="section-header">
                            <span class="section-icon">📍</span>
                            <span>Address</span>
                        </div>
                        <div class="bio-box">
                            <p><%= profile.getAddress() %></p>
                        </div>
                    </div>
                    <% } %>

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <a href="profilejsp.jsp" class="btn btn-secondary">✏️ Add Another Profile</a>
                        <a href="ProfileServlet?action=list" class="btn btn-info">👥 View All Profiles</a>
                        <button class="btn btn-secondary" onclick="window.print()">🖨️ Print Profile</button>
                        <a href="homepage.html" class="btn btn-primary">🏠 Back to Home</a>
                    </div>

                    <!-- Footer Info -->
                    <div class="footer-info">
                        ✓ Profile saved to database successfully
                    </div>
                <% } else { %>
                    <div style="text-align: center; padding: 50px; color: #999;">
                        <h2>😕 No Profile Data Found</h2>
                        <p>Please create a profile first.</p>
                        <br>
                        <a href="profilejsp.jsp" class="btn btn-primary">Create Profile</a>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>