<%@ page contentType="text/csv;charset=UTF-8" %>
<%@ page import="java.util.*, dao.ExpenseDAO, model.Expense, model.User" %>

<%
User u = (User) session.getAttribute("user");

// 🔒 Session check
if (u == null) {
    response.sendRedirect("login.jsp");
    return;
}

// 📥 Set download file name
response.setHeader("Content-Disposition", "attachment; filename=expenses.csv");

// 📊 Fetch data
List<Expense> list = ExpenseDAO.getExpenses(u.getId());

// 🧾 CSV HEADER
out.println("Title,Amount,Type,Category,Date");

// 🧾 DATA
for (Expense e : list) {
    out.println(
        e.getTitle() + "," +
        e.getAmount() + "," +
        e.getType() + "," +
        e.getCategory() + "," +
        e.getDate()
    );
}
%>