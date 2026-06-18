<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dao.ExpenseDAO, model.Expense, model.User" %>

<%
    User u = (User) session.getAttribute("user");

    // Redirect to login if session is null
    if (u == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Fetch all expenses for the logged-in user
    List<Expense> list = ExpenseDAO.getExpenses(u.getId());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Transactions</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --bg-color: #f1f5f9;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --blue-main: #2563eb;
            --blue-light: #bfdbfe;
            --green-main: #10b981;
            --green-light: #d1fae5;
            --border-color: #e2e8f0;
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
            padding: 40px 20px;
            display: flex;
            justify-content: center;
        }

        .container {
            width: 100%;
            max-width: 1000px; 
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* --- HEADER & NAVIGATION --- */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .page-title {
            font-size: 24px;
            font-weight: 700;
            color: var(--text-main);
        }

        .btn-back {
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            color: var(--text-main);
            background: white;
            font-size: 14px;
            font-weight: 600;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
            border: 1px solid var(--border-color);
            transition: 0.2s ease;
        }

        .btn-back:hover {
            background: #f8fafc;
            color: var(--blue-main);
        }

        /* --- LIST CONTAINER --- */
        .card {
            background: var(--card-bg);
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        /* List Layout Elements */
        .list-row {
            display: grid;
            grid-template-columns: 100px 2fr 1.5fr 150px 100px 120px;
            align-items: center;
            padding: 16px 24px;
            border-bottom: 1px solid var(--border-color);
            gap: 15px;
            transition: background 0.15s ease;
        }

        .list-row:hover:not(.list-header) {
            background-color: #f8fafc;
        }

        .list-row:last-child {
            border-bottom: none;
        }

        /* Header Row specific styling */
        .list-header {
            background-color: #f8fafc;
            border-bottom: 2px solid var(--border-color);
            font-weight: 700;
            color: var(--text-muted);
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Cell Data Styling */
        .lr-date { font-size: 13px; color: var(--text-muted); font-weight: 500; }
        .lr-title { font-size: 14px; font-weight: 600; color: var(--text-main); }
        .lr-cat { font-size: 13px; color: var(--text-muted); }
        .lr-amt { font-size: 14px; font-weight: 600; }
        
        /* Tags */
        .tag {
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            text-align: center;
            display: inline-block;
        }
        .tag-cash { background: var(--green-light); color: var(--green-main); }
        .tag-card { background: var(--blue-light); color: var(--blue-main); }

        /* Actions Buttons */
        .action-btns {
            display: flex;
            gap: 8px;
            justify-content: flex-end;
        }
        .btn-action {
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 600;
            color: white;
            text-decoration: none;
            text-align: center;
            transition: opacity 0.2s;
        }
        .btn-edit { background-color: #eab308; } /* Yellow */
        .btn-delete { background-color: #ef4444; } /* Red */
        .btn-action:hover { opacity: 0.8; }

        /* Empty State */
        .empty-state {
            padding: 40px;
            text-align: center;
            color: var(--text-muted);
        }
        .empty-state i {
            font-size: 40px;
            color: #cbd5e1;
            margin-bottom: 10px;
        }

    </style>
</head>
<body>

<div class="container">

    <div class="page-header">
        <h1 class="page-title">Transaction History</h1>
        <a href="dashboard.jsp" class="btn-back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    </div>

    <div class="card">
        
        <div class="list-row list-header">
            <div>Date</div>
            <div>Title</div>
            <div>Category</div>
            <div>Amount</div>
            <div style="text-align: center;">Type</div>
            <div style="text-align: right;">Actions</div>
        </div>

        <% 
            if (list != null && !list.isEmpty()) {
                for (Expense e : list) { 
                    boolean isIncome = "Income".equalsIgnoreCase(e.getType());
        %>
        <div class="list-row">
            <div class="lr-date"><%= e.getDate() %></div>
            <div class="lr-title"><%= e.getTitle() %></div>
            <div class="lr-cat"><i class="fas fa-tag" style="font-size: 10px; margin-right: 4px; color: #cbd5e1;"></i> <%= e.getCategory() %></div>
            
            <div class="lr-amt" style="color: <%= isIncome ? "var(--green-main)" : "var(--text-main)" %>">
                <%= isIncome ? "+" : "" %>Rs. <%= String.format("%.2f", e.getAmount()) %>
            </div>
            
            <div style="text-align: center;">
                <div class="tag <%= isIncome ? "tag-cash" : "tag-card" %>">
                    <%= isIncome ? "INCOME" : "EXPENSE" %>
                </div>
            </div>
            
            <div class="action-btns">
                <a href="editExpense.jsp?id=<%= e.getId() %>" class="btn-action btn-edit"><i class="fas fa-pen"></i></a>
                <a href="deleteExpense.jsp?id=<%= e.getId() %>" class="btn-action btn-delete" onclick="return confirm('Are you sure you want to delete this transaction?');"><i class="fas fa-trash"></i></a>
            </div>
        </div>
        <% 
                } 
            } else { 
        %>
        <div class="empty-state">
            <i class="fas fa-receipt"></i>
            <h3>No transactions found.</h3>
            <p>Go to the dashboard to add a new entry.</p>
        </div>
        <% } %>

    </div>

</div>

</body>
</html>