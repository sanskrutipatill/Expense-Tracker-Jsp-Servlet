package controller;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// IMPORTANT: This annotation maps the URL so the JSP can find it!
@WebServlet("/UpcomingServlet")
public class UpcomingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get the action from the hidden input field in editUpcoming.jsp
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            try {
                // 2. Retrieve the data submitted from the form
                int id = Integer.parseInt(request.getParameter("id"));
                String title = request.getParameter("title");
                double amount = Double.parseDouble(request.getParameter("amount"));
                String category = request.getParameter("category");
                String dateStr = request.getParameter("date");
                Date sqlDate = Date.valueOf(dateStr);

                // =================================================================
                // 3. TODO: UPDATE DATABASE HERE
                // =================================================================
                // Right now, your Upcoming expenses in dashboard.jsp are static HTML.
                // To make this work fully, you need an UpcomingExpenseDAO.
                // 
                // Example of what goes here once your database is ready:
                //
                // UpcomingExpense ue = new UpcomingExpense(id, title, amount, category, sqlDate);
                // boolean success = UpcomingExpenseDAO.update(ue);
                //
                // if(success) {
                //     request.getSession().setAttribute("msg", "Upcoming expense updated!");
                // }
                // =================================================================
                
                // For now, since it's just frontend UI, we will just redirect back 
                // to the dashboard so it doesn't show a 404 error.
                response.sendRedirect("dashboard.jsp");
                
            } catch (Exception e) {
                e.printStackTrace();
                // If something goes wrong (like a bad date format), redirect to error
                response.sendRedirect("error.jsp");
            }
        }
    }
}