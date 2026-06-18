<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dao.ExpenseDAO, model.Expense, model.User, java.text.SimpleDateFormat" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>

<%
User u = (User) session.getAttribute("user");

if (u == null) {
    response.sendRedirect("login.jsp");
    return;
}

List<Expense> list = ExpenseDAO.getExpenses(u.getId());

double income = 0;
double expense = 0;

Map<String, Double> categoryData = new LinkedHashMap<>();

for (Expense e : list) {
    if ("Income".equalsIgnoreCase(e.getType())) {
        income += e.getAmount();
    } else {
        expense += e.getAmount();
        categoryData.put(e.getCategory(),
            categoryData.getOrDefault(e.getCategory(), 0.0) + e.getAmount());
    }
}

// Calculate the remaining balance
double balance = income - expense;

// --- DYNAMIC DATE CALCULATIONS ---
LocalDate today = LocalDate.now();
DateTimeFormatter headerFormatter = DateTimeFormatter.ofPattern("dd MMMM, EEEE");
String formattedToday = today.format(headerFormatter);

DateTimeFormatter monthFormatter = DateTimeFormatter.ofPattern("MMMM");
String currentMonthName = today.format(monthFormatter);
int currentDay = today.getDayOfMonth();

SimpleDateFormat txDateFormatter = new SimpleDateFormat("dd MMM");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Expense Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        :root {
            --bg-color: #f1f5f9;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --blue-main: #0ea5e9;
            --blue-light: #e0f2fe;
            --green-main: #10b981;
            --green-light: #d1fae5;
            --red-main: #ef4444;
            --red-light: #fee2e2;
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
            padding: 20px 40px; 
            display: flex;
            justify-content: center;
            overflow-x: hidden; 
        }

        .dashboard-container {
            width: 100%;
            max-width: 1800px; 
            display: flex;
            flex-direction: column;
            gap: 20px; 
        }

        /* --- TOP BAR --- */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .small-greeting {
            font-size: 14px;
            color: var(--text-muted);
            font-weight: 500;
            letter-spacing: 0.3px;
        }
        .small-greeting strong {
            color: var(--text-main);
            font-weight: 700;
        }
        .header-actions {
            display: flex;
            gap: 12px;
        }
        .btn {
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            color: white;
            font-size: 14px;
            font-weight: 600;
            transition: opacity 0.2s;
        }
        .btn:hover { opacity: 0.9; }
        .add { background: var(--green-main); }
        .export { background: var(--blue-main); }
        .logout { background: #0f172a; }

        /* --- CARDS BASE --- */
        .card {
            background: var(--card-bg);
            border-radius: 14px;
            padding: 20px; 
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .section-title {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 4px;
        }
        .section-subtitle {
            font-size: 13px;
            color: var(--text-muted);
            margin-bottom: 15px; 
        }
        
        .section-header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .view-all-link {
            font-size: 13px;
            color: var(--blue-main);
            text-decoration: none;
            font-weight: 600;
        }
        .view-all-link:hover { text-decoration: underline; }

        /* --- TOP ROW --- */
        .top-row {
            display: grid;
            grid-template-columns: 1.3fr 1fr 1fr;
            gap: 20px;
        }

        .chart-box {
            position: relative;
            flex: 1;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 140px; 
        }

        .gauge-center-text {
            position: absolute;
            top: 70%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
        }
        .gauge-center-text h3 { font-size: 28px; font-weight: 700; color: var(--text-main); margin: 0; }
        .gauge-center-text p { font-size: 14px; color: var(--text-muted); margin: 0; }

        .budget-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: var(--input-bg);
            padding: 10px 16px; 
            border-radius: 10px;
            margin-top: 10px;
            border: 1px solid var(--border-color);
        }
        .bf-left span { display: block; font-size: 11px; color: var(--text-muted); font-weight: 500; margin-bottom: 2px;}
        .bf-left strong { font-size: 18px; font-weight: 700; }
        .text-green { color: var(--green-main); }
        .text-red { color: var(--red-main); }
        
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .bg-green { background: var(--green-light); color: var(--green-main); }
        .bg-red { background: var(--red-light); color: var(--red-main); }

        /* --- RECENT TRANSACTIONS ROWS --- */
        .list-row {
            display: grid;
            grid-template-columns: 60px 1fr auto auto 80px; 
            align-items: center;
            padding: 10px 0; 
            border-bottom: 1px solid #f1f5f9;
            gap: 12px;
        }
        .list-row:last-child { border-bottom: none; padding-bottom: 0; }
        
        .lr-date { font-size: 12px; color: var(--text-muted); text-align: left; }
        .lr-title { font-size: 14px; font-weight: 600; color: var(--text-main); }
        .lr-cat { font-size: 11px; color: var(--text-muted); margin-top: 2px; }
        .lr-amt { font-size: 14px; font-weight: 600; }
        
        .tag {
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
        }
        .tag-cash { background: var(--green-light); color: var(--green-main); }
        .tag-card { background: var(--blue-light); color: var(--blue-main); }

        .action-btns {
            display: flex;
            gap: 5px;
            justify-content: flex-end;
        }
        .btn-action {
            padding: 5px 8px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 600;
            color: white;
            text-decoration: none;
            text-align: center;
        }
        .btn-edit { background-color: #eab308; } 
        .btn-delete { background-color: var(--red-main); } 
        .btn-action:hover { opacity: 0.8; }

        /* --- BOTTOM ROW --- */
        .bottom-row {
            display: grid;
            grid-template-columns: 1.8fr 1fr;
            gap: 20px; 
            align-items: start;
        }

        .cat-grid, .upcoming-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px; 
            margin-top: 10px;
        }

        .upcoming-grid {
            grid-template-columns: 1fr 1fr; 
        }

        .cat-card, .up-card {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 16px; 
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.03);
            display: flex;
            flex-direction: column;
            position: relative; /* Added for edit button positioning */
        }

        /* --- MINIMAL UPCOMING EDIT BUTTON --- */
        .edit-up-btn {
            position: absolute;
            top: 16px;
            right: 16px;
            color: #cbd5e1;
            font-size: 12px;
            transition: all 0.2s ease;
        }
        .edit-up-btn:hover {
            color: var(--blue-main);
            transform: scale(1.1);
        }

        .cat-icon-wrapper {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            margin-bottom: 12px;
        }
        
        .ic-bills { background: #fee2e2; color: #ef4444; }
        .ic-food { background: #e0f2fe; color: #0ea5e9; }
        .ic-personal { background: #fef3c7; color: #f59e0b; }
        .ic-health { background: #f3f4f6; color: #10b981; }

        .cat-title { font-size: 14px; font-weight: 600; color: var(--text-main); margin-bottom: 4px; }
        .cat-amounts { font-size: 13px; font-weight: 700; color: var(--text-main); margin-bottom: 12px; }
        .cat-amounts span { font-weight: 400; color: var(--text-muted); font-size: 11px; margin-left: 4px; }

        .cat-bar-bg { height: 5px; background: #f1f5f9; border-radius: 3px; width: 100%; overflow: hidden; }
        .cat-bar-fill { height: 100%; background: var(--blue-main); border-radius: 3px; }

    </style>
</head>
<body>

<div class="dashboard-container">

    <div class="top-bar">
        <div class="small-greeting">Hello !, <strong><%= u.getName() %></strong> &nbsp;|&nbsp; <%= formattedToday %></div>
        <div class="header-actions">
            <a class="btn add" href="addExpense.jsp">+ Add Entry</a>
            <a class="btn export" href="export.jsp">Export CSV</a>
            <a class="btn logout" href="LogoutServlet">Logout</a>
        </div>
    </div>

    <div class="top-row">
        
        <div class="card">
            <div class="section-header-flex" style="margin-bottom: 16px;">
                <h3 class="section-title" style="margin-bottom: 0;">Recent Transactions</h3>
                <a href="viewAll.jsp" class="view-all-link">View All <i class="fas fa-arrow-right" style="margin-left: 4px;"></i></a>
            </div>
            
            <div style="display: flex; flex-direction: column;">
                <% 
                int topCount = 0; 
                for (Expense e : list) { 
                    if(topCount >= 6) break; 
                    boolean isIncome = "Income".equalsIgnoreCase(e.getType());
                %>
                <div class="list-row">
                    <div class="lr-date"><%= txDateFormatter.format(e.getDate()) %></div>
                    <div>
                        <div class="lr-title"><%= e.getTitle() %></div>
                        <div class="lr-cat"><%= e.getCategory() %></div>
                    </div>
                    <div class="lr-amt" style="color: <%= isIncome ? "var(--green-main)" : "var(--text-main)" %>">
                        Rs.<%= e.getAmount() %>
                    </div>
                    <div class="tag <%= isIncome ? "tag-cash" : "tag-card" %>">
                        <%= isIncome ? "INCOME" : "EXPENSE" %>
                    </div>
                    
                    <div class="action-btns">
                        <a href="editExpense.jsp?id=<%= e.getId() %>" class="btn-action btn-edit">Edit</a>
                        <a href="deleteExpense.jsp?id=<%= e.getId() %>" class="btn-action btn-delete">Del</a>
                    </div>
                </div>
                <% topCount++; } %>
            </div>
        </div>

        <div class="card">
            <div>
                <div class="section-title">Budget Vs Expense</div>
                <div class="section-subtitle">From 01 - <%= String.format("%02d", currentDay) %> <%= currentMonthName %></div>
            </div>
            
            <div class="chart-box">
                <canvas id="gaugeChart"></canvas>
                <div class="gauge-center-text">
                    <h3>Rs.<%= String.format("%.0f", expense) %></h3>
                    <p>of Rs.<%= String.format("%.0f", income == 0 ? expense : income) %></p>
                </div>
            </div>

            <div class="budget-footer">
                <div class="bf-left">
                    <span>Remaining Budget</span>
                    <strong class="<%= balance >= 0 ? "text-green" : "text-red" %>">
                        Rs.<%= String.format("%.0f", balance) %>
                    </strong>
                </div>
                <div class="bf-right">
                    <div class="status-badge <%= balance >= 0 ? "bg-green" : "bg-red" %>">
                        <%= balance >= 0 ? "On Track" : "Over Budget" %>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div>
                <div class="section-title">Expense Distribution</div>
                <div class="section-subtitle">From 01 - <%= String.format("%02d", currentDay) %> <%= currentMonthName %></div>
            </div>
            <div class="chart-box">
                <canvas id="donutChart"></canvas>
            </div>
        </div>
    </div>

    <div class="bottom-row">
        
        <div>
            <h3 class="section-title" style="margin-bottom: 12px;">Category wise Expenses</h3>
            <div class="cat-grid">
                <%
                String[] icons = {"fa-home ic-bills", "fa-utensils ic-food", "fa-user ic-personal", "fa-pills ic-health", "fa-graduation-cap ic-bills", "fa-bus ic-personal", "fa-chart-pie ic-food", "fa-box ic-health"};
                int i = 0;
                for (String key : categoryData.keySet()) {
                    double val = categoryData.get(key);
                    double pct = (val / (expense == 0 ? 1 : expense)) * 100;
                    String iconClasses = icons[i % icons.length];
                    i++;
                %>
                <div class="cat-card">
                    <div class="cat-icon-wrapper <%= iconClasses.split(" ")[1] %>">
                        <i class="fas <%= iconClasses.split(" ")[0] %>"></i>
                    </div>
                    <div class="cat-title"><%= key %></div>
                    <div class="cat-amounts">Rs.<%= String.format("%.0f", val) %> <span>of Rs.<%= String.format("%.0f", expense) %></span></div>
                    <div class="cat-bar-bg">
                        <div class="cat-bar-fill" style="width: <%= pct %>%;"></div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>

        <div class="right-col">
            <div>
                <h3 class="section-title" style="margin-bottom: 12px;">Upcoming Expenses</h3>
                <div class="upcoming-grid">
                    
                    <div class="up-card">
                        <a href="editUpcoming.jsp?id=1" class="edit-up-btn"><i class="fas fa-pen"></i></a>
                        
                        <div class="cat-icon-wrapper" style="background: #e0f2fe; color: #0077b5;">
                            <i class="fab fa-linkedin"></i>
                        </div>
                        <div class="cat-title">LinkedIn Sub</div>
                        <div class="cat-amounts">Rs.300 <span>28 <%= currentMonthName %></span></div>
                        <div class="cat-bar-bg">
                            <div class="cat-bar-fill" style="width: 100%; background: #0077b5;"></div>
                        </div>
                    </div>

                    <div class="up-card">
                        <a href="editUpcoming.jsp?id=2" class="edit-up-btn"><i class="fas fa-pen"></i></a>

                        <div class="cat-icon-wrapper" style="background: #fee2e2; color: #e23237;">
                            <i class="fab fa-microsoft"></i>
                        </div>
                        <div class="cat-title">Office 365</div>
                        <div class="cat-amounts">Rs.1200 <span>31 <%= currentMonthName %></span></div>
                        <div class="cat-bar-bg">
                            <div class="cat-bar-fill" style="width: 100%; background: #e23237;"></div>
                        </div>
                    </div>

                    <div class="up-card">
                        <a href="editUpcoming.jsp?id=3" class="edit-up-btn"><i class="fas fa-pen"></i></a>

                        <div class="cat-icon-wrapper" style="background: #ffedd5; color: #ea580c;">
                            <i class="fas fa-gamepad"></i>
                        </div>
                        <div class="cat-title">Electricity Bill</div>
                        <div class="cat-amounts">Rs.800 <span>02 Next Month</span></div>
                        <div class="cat-bar-bg">
                            <div class="cat-bar-fill" style="width: 100%; background: #ea580c;"></div>
                        </div>
                    </div>

                    <div class="up-card">
                        <a href="editUpcoming.jsp?id=4" class="edit-up-btn"><i class="fas fa-pen"></i></a>

                        <div class="cat-icon-wrapper" style="background: #e0f2fe; color: #0284c7;">
                            <i class="fas fa-trash-alt"></i>
                        </div>
                        <div class="cat-title">Water Bill</div>
                        <div class="cat-amounts">Rs.200 <span>07 Next Month</span></div>
                        <div class="cat-bar-bg">
                            <div class="cat-bar-fill" style="width: 100%; background: #0284c7;"></div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script>
    Chart.defaults.font.family = 'Inter';
    
    // --- 1. Gauge Chart ---
    const ctxGauge = document.getElementById("gaugeChart").getContext('2d');
    const totalIncome = <%= income == 0 ? expense : income %>; 
    const totalExpense = <%= expense %>;
    const chartRemaining = totalIncome > totalExpense ? (totalIncome - totalExpense) : 0;

    new Chart(ctxGauge, {
        type: 'doughnut',
        data: {
            datasets: [{
                data: [totalExpense, chartRemaining],
                backgroundColor: ['#0ea5e9', '#f1f5f9'],
                borderWidth: 0,
                borderRadius: 20
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            circumference: 180,
            rotation: -90,
            cutout: '88%', 
            plugins: { tooltip: { enabled: false } },
            layout: { padding: 0 }
        }
    });

    // --- 2. Donut Chart ---
    const catLabels = [<% for(String k : categoryData.keySet()){ %>"<%=k%>",<% } %>];
    const catValues = [<% for(Double v : categoryData.values()){ %><%=v%>,<% } %>];
    const donutColors = ['#0ea5e9', '#eab308', '#22c55e', '#ef4444', '#8b5cf6', '#14b8a6', '#f43f5e'];

    const ctxDonut = document.getElementById("donutChart").getContext('2d');
    new Chart(ctxDonut, {
        type: 'doughnut',
        data: {
            labels: catLabels,
            datasets: [{
                data: catValues,
                backgroundColor: donutColors,
                borderWidth: 2,
                borderColor: '#ffffff',
                hoverOffset: 4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '65%', 
            plugins: {
                legend: {
                    position: 'left', 
                    labels: {
                        usePointStyle: true,
                        pointStyle: 'circle',
                        boxWidth: 8,
                        boxHeight: 8,
                        font: { size: 12, family: 'Inter' },
                        color: '#64748b'
                    }
                }
            },
            layout: { padding: 0 }
        }
    });
</script>

</body>
</html>