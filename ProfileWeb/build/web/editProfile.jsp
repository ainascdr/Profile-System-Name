<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.profile.bean.ProfileBean" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student Profile</title>
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
            background: white;
            border-radius: 20px;
            box-shadow: 0 30px 80px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 800px;
            padding: 50px;
            margin: 0 auto;
            animation: slideIn 0.6s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        h1 {
            color: #C71585;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
        }
        
        .form-group {
            margin-bottom: 28px;
        }
        
        label {
            display: block;
            margin-bottom: 10px;
            color: #333;
            font-weight: 600;
            font-size: 1.05em;
        }
        
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1em;
            font-family: inherit;
            transition: all 0.3s;
        }
        
        input:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #FF69B4;
            box-shadow: 0 0 15px rgba(255, 105, 180, 0.2);
            background: #fff5f8;
        }
        
        select {
            cursor: pointer;
        }
        
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        
        .section-title {
            color: #FF1493;
            font-size: 1.3em;
            font-weight: 600;
            margin-top: 35px;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .btn-container {
            display: flex;
            gap: 15px;
            margin-top: 45px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        button, a.btn {
            flex: 1;
            padding: 16px 40px;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            max-width: 200px;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #FF69B4 0%, #FFB6D9 100%);
            color: white;
        }
        
        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(255, 105, 180, 0.4);
        }
        
        .btn-cancel {
            background: #f0f0f0;
            color: #333;
        }
        
        .btn-cancel:hover {
            background: #e0e0e0;
        }
        
        .required {
            color: #e74c3c;
        }

        .form-hint {
            font-size: 0.9em;
            color: #999;
            margin-top: 6px;
            font-style: italic;
        }

        @media (max-width: 600px) {
            .container {
                padding: 30px 20px;
            }

            h1 {
                font-size: 1.8em;
            }

            .btn-container {
                flex-direction: column;
            }

            button, a.btn {
                max-width: 100% !important;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>✏️ Edit Student Profile</h1>
        
        <% 
            ProfileBean profile = (ProfileBean) request.getAttribute("profile");
            if (profile != null) {
        %>
        
        <form action="ProfileServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= profile.getId() %>">
            
            <!-- Personal Information Section -->
            <div class="section-title">👤 Personal Information</div>
            
            <div class="form-group">
                <label for="studentId">Student ID <span class="required">*</span></label>
                <input type="text" id="studentId" name="studentId" required 
                       value="<%= profile.getStudentId() %>">
                <div class="form-hint">Your unique student identifier</div>
            </div>
            
            <div class="form-group">
                <label for="fullName">Full Name <span class="required">*</span></label>
                <input type="text" id="fullName" name="fullName" required 
                       value="<%= profile.getFullName() %>">
                <div class="form-hint">Please enter your complete full name</div>
            </div>
            
            <div class="form-group">
                <label for="email">Email Address <span class="required">*</span></label>
                <input type="email" id="email" name="email" required 
                       value="<%= profile.getEmail() %>">
                <div class="form-hint">We'll use this to contact you</div>
            </div>
            
            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone" 
                       value="<%= profile.getPhone() != null ? profile.getPhone() : "" %>">
                <div class="form-hint">Optional: Your contact number</div>
            </div>
            
            <!-- Academic Information Section -->
            <div class="section-title">📚 Academic Information</div>
            
            <div class="form-group">
                <label for="programme">Programme/Course <span class="required">*</span></label>
                <select id="programme" name="programme" required>
                    <option value="">Select Programme</option>
                    <option value="Computer Science" <%= "Computer Science".equals(profile.getProgramme()) ? "selected" : "" %>>Computer Science</option>
                    <option value="Information Technology" <%= "Information Technology".equals(profile.getProgramme()) ? "selected" : "" %>>Information Technology</option>
                    <option value="Software Engineering" <%= "Software Engineering".equals(profile.getProgramme()) ? "selected" : "" %>>Software Engineering</option>
                    <option value="Data Science" <%= "Data Science".equals(profile.getProgramme()) ? "selected" : "" %>>Data Science</option>
                    <option value="Cybersecurity" <%= "Cybersecurity".equals(profile.getProgramme()) ? "selected" : "" %>>Cybersecurity</option>
                    <option value="Business Administration" <%= "Business Administration".equals(profile.getProgramme()) ? "selected" : "" %>>Business Administration</option>
                    <option value="Engineering" <%= "Engineering".equals(profile.getProgramme()) ? "selected" : "" %>>Engineering</option>
                </select>
                <div class="form-hint">Your study program or major</div>
            </div>
            
            <div class="form-group">
                <label for="yearOfStudy">Year of Study <span class="required">*</span></label>
                <select id="yearOfStudy" name="yearOfStudy" required>
                    <option value="">Select Year</option>
                    <option value="1" <%= profile.getYearOfStudy() == 1 ? "selected" : "" %>>Year 1</option>
                    <option value="2" <%= profile.getYearOfStudy() == 2 ? "selected" : "" %>>Year 2</option>
                    <option value="3" <%= profile.getYearOfStudy() == 3 ? "selected" : "" %>>Year 3</option>
                    <option value="4" <%= profile.getYearOfStudy() == 4 ? "selected" : "" %>>Year 4</option>
                    <option value="5" <%= profile.getYearOfStudy() == 5 ? "selected" : "" %>>Year 5</option>
                </select>
                <div class="form-hint">Your current year of study</div>
            </div>
            
            <!-- Interests & Hobbies Section -->
            <div class="section-title">🎯 Interests & Hobbies</div>
            
            <div class="form-group">
                <label for="hobby">Your Hobbies & Interests</label>
                <input type="text" id="hobby" name="hobby" 
                       value="<%= profile.getHobby() != null ? profile.getHobby() : "" %>"
                       placeholder="e.g., Programming, Gaming, Reading, Sports">
                <div class="form-hint">Optional: Separate multiple hobbies with commas</div>
            </div>
            
            <!-- Additional Information Section -->
            <div class="section-title">📍 Additional Information</div>
            
            <div class="form-group">
                <label for="address">Address</label>
                <textarea id="address" name="address" 
                    placeholder="Enter your address here..."><%= profile.getAddress() != null ? profile.getAddress() : "" %></textarea>
                <div class="form-hint">Optional: Your residential address</div>
            </div>
            
            <!-- Buttons -->
            <div class="btn-container">
                <a href="ProfileServlet?action=list" class="btn btn-cancel">Cancel</a>
                <button type="submit" class="btn btn-submit">Update Profile</button>
            </div>
        </form>
        
        <% } else { %>
            <p style="text-align: center; color: #e74c3c;">Profile not found!</p>
            <div style="text-align: center; margin-top: 20px;">
                <a href="ProfileServlet?action=list" class="btn btn-cancel">Back to Profiles</a>
            </div>
        <% } %>
    </div>
</body>
</html>