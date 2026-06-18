<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error - Expense Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --bg-color: #f1f5f9;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --red-main: #ef4444;
            --red-light: #fee2e2;
            --blue-main: #2563eb;
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
            padding: 45px 40px;
            width: 100%;
            max-width: 400px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04), 0 1px 3px rgba(0,0,0,0.02);
            text-align: center;
        }

        .icon-circle {
            width: 70px;
            height: 70px;
            background-color: var(--red-light);
            color: var(--red-main);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            margin: 0 auto 20px auto;
        }

        h2 {
            font-weight: 700;
            font-size: 22px;
            color: var(--text-main);
            margin-bottom: 8px;
        }

        p {
            font-size: 14px;
            color: var(--text-muted);
            margin-bottom: 30px;
            line-height: 1.5;
        }

        .btn-back {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            background: var(--blue-main);
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
            width: 100%;
        }

        .btn-back:hover {
            background: #1d4ed8; /* Darker blue */
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
        }

        .btn-back:active {
            transform: translateY(0);
        }

    </style>
</head>
<body>

<div class="container">

    <div class="icon-circle">
        <i class="fas fa-exclamation-triangle"></i>
    </div>

    <h2>Oops! Something went wrong.</h2>
    <p>We encountered an unexpected error while processing your request. Please try again.</p>

    <a href="login.jsp" class="btn-back">
        <i class="fas fa-arrow-left"></i> Go Back
    </a>

</div>

</body>
</html>