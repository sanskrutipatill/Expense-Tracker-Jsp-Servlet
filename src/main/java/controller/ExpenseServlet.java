package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import model.Expense;
import dao.ExpenseDAO;
import java.sql.Date;

public class ExpenseServlet extends HttpServlet {

    // ✅ ADD + UPDATE
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        // 🔒 Session check
        if (session.getAttribute("user") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");

        // =========================
        // ✅ UPDATE EXPENSE
        // =========================
        if ("update".equals(action)) {

            Expense e = new Expense();

            e.setId(Integer.parseInt(req.getParameter("id")));
            e.setTitle(req.getParameter("title"));
            e.setAmount(Double.parseDouble(req.getParameter("amount")));
            e.setCategory(req.getParameter("category"));
            e.setType(req.getParameter("type"));
            e.setDate(Date.valueOf(req.getParameter("date")));

            if (ExpenseDAO.updateExpense(e)) {
                res.sendRedirect("dashboard.jsp");
            } else {
                res.sendRedirect("error.jsp");
            }

            return;
        }

        // =========================
        // ✅ ADD EXPENSE / INCOME
        // =========================
        int userId = ((model.User) session.getAttribute("user")).getId();

        Expense e = new Expense();

        e.setUserId(userId);
        e.setTitle(req.getParameter("title"));
        e.setAmount(Double.parseDouble(req.getParameter("amount")));
        e.setCategory(req.getParameter("category"));
        e.setType(req.getParameter("type"));   // Income / Expense
        e.setDate(Date.valueOf(req.getParameter("date")));

        if (ExpenseDAO.addExpense(e)) {
            res.sendRedirect("dashboard.jsp");
        } else {
            res.sendRedirect("error.jsp");
        }
    }

    // =========================
    // ✅ DELETE
    // =========================
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        // 🔒 Session check
        if (session.getAttribute("user") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));

            ExpenseDAO.deleteExpense(id);
        }

        res.sendRedirect("dashboard.jsp");
    }
}