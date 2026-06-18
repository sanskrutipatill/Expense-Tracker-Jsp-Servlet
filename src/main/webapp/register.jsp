<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - Expense Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --bg-color: #f1f5f9;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --blue-main: #2563eb;
            --green-main: #10b981;
            --border-color: #e2e8f0;
            --input-bg: #f8fafc;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-main);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }

        .container {
            background: var(--card-bg);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04), 0 1px 3px rgba(0,0,0,0.02);
        }

        .header-text {
            text-align: center;
            margin-bottom: 30px;
        }

        .header-text h2 {
            font-weight: 700;
            font-size: 26px;
            color: var(--text-main);
            margin-bottom: 8px;
        }

        .header-text p {
            font-size: 14px;
            color: var(--text-muted);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            font-size: 13px;
            color: var(--text-main);
        }

        input {
            width: 100%;
            padding: 12px 16px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            background-color: var(--input-bg);
            font-size: 14px;
            color: var(--text-main);
            transition: all 0.2s ease;
        }

        input:focus {
            outline: none;
            border-color: var(--green-main);
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.15);
        }

        input::placeholder {
            color: #94a3b8;
        }

        button[type="submit"] {
            width: 100%;
            margin-top: 10px;
            background: var(--green-main);
            color: white;
            border: none;
            padding: 14px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
        }

        button[type="submit"]:hover {
            background: #059669;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.2);
        }

        button[type="submit"]:active {
            transform: translateY(0);
        }

        .login-link {
            text-align: center;
            margin-top: 25px;
            font-size: 14px;
            color: var(--text-muted);
        }

        .login-link a {
            text-decoration: none;
            color: var(--blue-main);
            font-weight: 600;
            transition: color 0.2s;
        }

        .login-link a:hover {
            text-decoration: underline;
            color: #1d4ed8;
        }
        
        /* Optional: Adding a small icon wrapper inside inputs for a premium feel */
        .input-wrapper {
            position: relative;
        }
        .input-wrapper i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 14px;
        }
        .input-wrapper input {
            padding-left: 42px; /* Make room for the icon */
        }

    </style>
</head>
<body>

<div class="container">

    <div class="header-text">
        <h2>Create an Account</h2>
        <p>Sign up to start tracking your expenses.</p>
    </div>

    <form action="RegisterServlet" method="post">

        <div class="form-group">
            <label>Name</label>
            <div class="input-wrapper">
                <i class="fas fa-user"></i>
                <input type="text" name="name" placeholder="e.g. John Doe" required>
            </div>
        </div>

        <div class="form-group">
            <label>Email</label>
            <div class="input-wrapper">
                <i class="fas fa-envelope"></i>
                <input type="email" name="email" placeholder="name@example.com" required>
            </div>
        </div>

        <div class="form-group">
            <label>Password</label>
            <div class="input-wrapper">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" placeholder="••••••••" required>
            </div>
        </div>

        <button type="submit">
            Register <i class="fas fa-user-plus" style="margin-left: 4px;"></i>
        </button>

    </form>

    <div class="login-link">
        Already have an account? <a href="login.jsp">Login here</a>
    </div>

</div>

</body>
</html>