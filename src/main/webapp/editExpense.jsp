<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="dao.ExpenseDAO, model.Expense" %>

<%
    // Safely parse the ID from the URL
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.trim().isEmpty()) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    
    int id = Integer.parseInt(idParam);
    Expense e = ExpenseDAO.getExpenseById(id);
    
    if (e == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Entry</title>
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
            max-width: 420px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04), 0 1px 3px rgba(0,0,0,0.02);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
            font-size: 24px;
            color: var(--text-main);
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

        /* Custom dropdown arrow for select */
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
            background: var(--green-main);
            color: white;
            border: none;
            padding: 14px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        button[type="submit"]:hover {
            background: #059669;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.2);
        }

        button[type="submit"]:active {
            transform: translateY(0);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: var(--blue-main);
            font-size: 13px;
            font-weight: 500;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">

    <h2>Edit Entry</h2>

    <form action="ExpenseServlet" method="post">

        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= e.getId() %>">

        <div class="form-group">
            <label>Title:</label>
            <input type="text" name="title" value="<%= e.getTitle() %>" required>
        </div>

        <div class="form-group">
            <label>Amount:</label>
            <input type="number" name="amount" step="0.01" value="<%= e.getAmount() %>" required>
        </div>

        <div class="form-group">
            <label>Type:</label>
            <select name="type" required>
                <option value="Expense" <%= "Expense".equalsIgnoreCase(e.getType()) ? "selected" : "" %>>Expense</option>
                <option value="Income" <%= "Income".equalsIgnoreCase(e.getType()) ? "selected" : "" %>>Income</option>
            </select>
        </div>

        <div class="form-group">
            <label>Category:</label>
            <select name="category" required>
                <option value="Job" <%= "Job".equalsIgnoreCase(e.getCategory()) ? "selected" : "" %>>Job</option>
                <option value="Medical" <%= "Medical".equalsIgnoreCase(e.getCategory()) ? "selected" : "" %>>Medical</option>
                <option value="Education" <%= "Education".equalsIgnoreCase(e.getCategory()) ? "selected" : "" %>>Education</option>
                <option value="Work" <%= "Work".equalsIgnoreCase(e.getCategory()) ? "selected" : "" %>>Work</option>
                <option value="Food" <%= "Food".equalsIgnoreCase(e.getCategory()) ? "selected" : "" %>>Food</option>
                <option value="Travel" <%= "Travel".equalsIgnoreCase(e.getCategory()) ? "selected" : "" %>>Travel</option>
                <option value="Bills" <%= "Bills".equalsIgnoreCase(e.getCategory()) ? "selected" : "" %>>Bills</option>
                <option value="Shopping" <%= "Shopping".equalsIgnoreCase(e.getCategory()) ? "selected" : "" %>>Shopping</option>
                <option value="Other" <%= "Other".equalsIgnoreCase(e.getCategory()) ? "selected" : "" %>>Other</option>
            </select>
        </div>

        <div class="form-group">
            <label>Date:</label>
            <input type="date" name="date" value="<%= e.getDate() %>" required>
        </div>

        <button type="submit">Update Entry</button>

    </form>

    <a href="dashboard.jsp" class="back-link"><i class="fas fa-arrow-left" style="margin-right: 4px; font-size: 11px;"></i> Back to Dashboard</a>

</div>

</body>
</html>