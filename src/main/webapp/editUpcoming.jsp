<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Upcoming - Expense Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --bg-color: #f1f5f9;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --blue-main: #2563eb;
            --yellow-main: #eab308;
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
            max-width: 420px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04), 0 1px 3px rgba(0,0,0,0.02);
            position: relative;
        }

        .back-link {
            position: absolute;
            top: 25px;
            left: 25px;
            text-decoration: none;
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 500;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: var(--text-main);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
            font-size: 24px;
            color: var(--text-main);
            margin-top: 10px;
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

        input, select {
            width: 100%;
            padding: 12px 16px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            background-color: var(--input-bg);
            font-size: 14px;
            color: var(--text-main);
            transition: all 0.2s ease;
            appearance: none;
        }

        select {
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2364748b' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 1rem center;
            background-size: 1em;
            padding-right: 2.5rem;
        }

        input:focus, select:focus {
            outline: none;
            border-color: var(--blue-main);
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }

        button[type="submit"] {
            width: 100%;
            margin-top: 10px;
            background: var(--yellow-main);
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
            background: #ca8a04;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(234, 179, 8, 0.2);
        }

        button[type="submit"]:active {
            transform: translateY(0);
        }
    </style>
</head>
<body>

<div class="container">

    <a href="dashboard.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back</a>

    <h2>Edit Upcoming</h2>

    <form action="UpcomingServlet" method="post">

        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= request.getParameter("id") %>">

        <div class="form-group">
            <label>Title</label>
            <input type="text" name="title" value="Subscription" required>
        </div>

        <div class="form-group">
            <label>Amount (Rs.)</label>
            <input type="number" name="amount" step="0.01" value="300" required>
        </div>

        <div class="form-group">
            <label>Category</label>
            <select name="category" required>
                <option value="Bills" selected>Bills & Utilities</option>
                <option value="Job">Job</option>
                <option value="Medical">Medical</option>
                <option value="Education">Education</option>
                <option value="Work">Work</option>
                <option value="Food">Food</option>
                <option value="Travel">Travel</option>
                <option value="Shopping">Shopping</option>
                <option value="Other">Other</option>
            </select>
        </div>

        <div class="form-group">
            <label>Expected Date</label>
            <input type="date" name="date" required>
        </div>

        <button type="submit">
            <i class="fas fa-save"></i> Update Upcoming
        </button>

    </form>

</div>

</body>
</html>