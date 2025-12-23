<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Your Profile - Fill Your Details</title>
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
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 30px 80px rgba(0, 0, 0, 0.3);
            padding: 50px;
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

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .header h1 {
            color: #C71585;
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        .header p {
            color: #666;
            font-size: 1.1em;
        }

        .breadcrumb {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 30px;
            font-size: 0.9em;
            color: #999;
        }

        .breadcrumb .step {
            padding: 8px 15px;
            border-radius: 20px;
        }

        .breadcrumb .step.active {
            background: #FF69B4;
            color: white;
            font-weight: 600;
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

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="tel"]:focus,
        input[type="number"]:focus,
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
            min-height: 120px;
        }

        .required {
            color: #e74c3c;
            font-weight: bold;
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

        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 45px;
            justify-content: center;
        }

        button, a.btn {
            padding: 16px 40px;
            font-size: 1.1em;
            font-weight: 600;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-submit {
            background: linear-gradient(135deg, #FF69B4 0%, #FFB6D9 100%);
            color: white;
            flex: 1;
            max-width: 250px;
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(255, 105, 180, 0.4);
        }

        .btn-reset {
            background: #f0f0f0;
            color: #333;
            flex: 1;
            max-width: 250px;
        }

        .btn-reset:hover {
            background: #e0e0e0;
        }

        .btn-back {
            background: #e0e0e0;
            color: #333;
        }

        .btn-back:hover {
            background: #d0d0d0;
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

            .header h1 {
                font-size: 1.8em;
            }

            .btn-group {
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
        <div class="header">
            <h1>📝 Create Your Profile</h1>
            <p>Tell us about yourself</p>
        </div>

        <div class="breadcrumb">
            <span class="step">1. Home</span>
            <span class="step active">2. Form</span>
            <span class="step">3. View Profile</span>
        </div>

       <form action="${pageContext.request.contextPath}/ProfileServlet" method="POST" onsubmit="return validateForm()">

            <input type="hidden" name="action" value="add">
            
            <!-- Personal Information Section -->
            <div class="section-title">👤 Personal Information</div>

            <div class="form-group">
                <label for="studentId">Student ID <span class="required">*</span></label>
                <input type="text" id="studentId" name="studentId" required 
                    placeholder="e.g., S001 or TP123456">
                <div class="form-hint">Your unique student identifier</div>
            </div>

            <div class="form-group">
                <label for="fullName">Full Name <span class="required">*</span></label>
                <input type="text" id="fullName" name="fullName" required 
                    placeholder="e.g., John Doe" minlength="2">
                <div class="form-hint">Please enter your complete full name</div>
            </div>

            <div class="form-group">
                <label for="email">Email Address <span class="required">*</span></label>
                <input type="email" id="email" name="email" required 
                    placeholder="your.email@example.com">
                <div class="form-hint">We'll use this to contact you</div>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone" 
                    placeholder="e.g., 012-3456789">
                <div class="form-hint">Optional: Your contact number</div>
            </div>

            <!-- Academic Information Section -->
            <div class="section-title">📚 Academic Information</div>

            <div class="form-group">
                <label for="programme">Programme/Course <span class="required">*</span></label>
                <select id="programme" name="programme" required>
                    <option value="">Select Programme</option>
                    <option value="Computer Science">Computer Science</option>
                    <option value="Information Technology">Information Technology</option>
                    <option value="Software Engineering">Software Engineering</option>
                    <option value="Data Science">Data Science</option>
                    <option value="Cybersecurity">Cybersecurity</option>
                    <option value="Business Administration">Business Administration</option>
                    <option value="Engineering">Engineering</option>
                </select>
                <div class="form-hint">Your study program or major</div>
            </div>

            <div class="form-group">
                <label for="yearOfStudy">Year of Study <span class="required">*</span></label>
                <select id="yearOfStudy" name="yearOfStudy" required>
                    <option value="">Select Year</option>
                    <option value="1">Year 1</option>
                    <option value="2">Year 2</option>
                    <option value="3">Year 3</option>
                    <option value="4">Year 4</option>
                    <option value="5">Year 5</option>
                </select>
                <div class="form-hint">Your current year of study</div>
            </div>

            <!-- Interests & Hobbies Section -->
            <div class="section-title">🎯 Interests & Hobbies</div>

            <div class="form-group">
                <label for="hobby">Your Hobbies & Interests</label>
                <input type="text" id="hobby" name="hobby" 
                    placeholder="e.g., Programming, Gaming, Reading, Sports">
                <div class="form-hint">Optional: Separate multiple hobbies with commas</div>
            </div>

            <!-- Additional Information Section -->
            <div class="section-title">📍 Additional Information</div>

            <div class="form-group">
                <label for="address">Address</label>
                <textarea id="address" name="address" 
                    placeholder="Enter your address here..."></textarea>
                <div class="form-hint">Optional: Your residential address</div>
            </div>

            <!-- Buttons -->
            <div class="btn-group">
                <a href="homepage.html" class="btn btn-back">← Back to Home</a>
                <button type="reset" class="btn btn-reset">🔄 Clear Form</button>
                <button type="submit" class="btn btn-submit">Submit Profile →</button>
            </div>
        </form>
    </div>

    <script>
        function validateForm() {
            const fullName = document.getElementById("fullName").value.trim();
            const studentId = document.getElementById("studentId").value.trim();
            const email = document.getElementById("email").value.trim();
            
            if (fullName.length < 2) {
                alert("Please enter a valid full name (at least 2 characters)");
                return false;
            }
            
            if (studentId.length < 3) {
                alert("Please enter a valid student ID");
                return false;
            }
            
            if (!email.includes("@")) {
                alert("Please enter a valid email address");
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>