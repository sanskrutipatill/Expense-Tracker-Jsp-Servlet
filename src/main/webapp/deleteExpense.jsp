<%@ page import="dao.ExpenseDAO" %>
<%
    // 1. Get the expense ID from the URL parameter
    String idParam = request.getParameter("id");

    if (idParam != null) {
        try {
            int expenseId = Integer.parseInt(idParam);
            
            // 2. Call your DAO to delete the record
            boolean success = ExpenseDAO.deleteExpense(expenseId);
            
            if (success) {
                session.setAttribute("successMsg", "Transaction deleted successfully.");
            } else {
                session.setAttribute("errorMsg", "Failed to delete transaction.");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    // 3. Redirect the user back to the page they came from (Dashboard or View All)
    String referer = request.getHeader("referer");
    if (referer != null && referer.contains("viewAll.jsp")) {
        response.sendRedirect("viewAll.jsp");
    } else {
        response.sendRedirect("dashboard.jsp");
    }
%>