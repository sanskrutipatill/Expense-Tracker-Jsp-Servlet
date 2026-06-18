package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;   
import java.util.ArrayList;
import java.util.List;

import model.Expense;
import util.DBConnection;

public class ExpenseDAO {

    // ✅ ADD NEW EXPENSE OR INCOME
    public static boolean addExpense(Expense e) {
        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO expenses(user_id, title, amount, category, date, type) VALUES(?, ?, ?, ?, ?, ?)"
            );

            ps.setInt(1, e.getUserId());
            ps.setString(2, e.getTitle());
            ps.setDouble(3, e.getAmount());
            ps.setString(4, e.getCategory());
            ps.setDate(5, e.getDate());
            ps.setString(6, e.getType());

            return ps.executeUpdate() > 0;

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // ✅ GET ALL EXPENSES FOR A SPECIFIC USER
    public static List<Expense> getExpenses(int userId) {
        List<Expense> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            // Order by date descending to show newest transactions first
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM expenses WHERE user_id=? ORDER BY date DESC"
            );

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Expense e = new Expense();

                e.setId(rs.getInt("id"));
                e.setUserId(rs.getInt("user_id"));
                e.setTitle(rs.getString("title"));
                e.setAmount(rs.getDouble("amount"));
                e.setCategory(rs.getString("category"));
                e.setDate(rs.getDate("date"));
                e.setType(rs.getString("type"));

                list.add(e);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return list;
    }

    // ✅ GET A SINGLE EXPENSE BY ITS ID (Used for Editing)
    public static Expense getExpenseById(int id) {
        Expense e = null;

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM expenses WHERE id=?"
            );

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                e = new Expense();

                e.setId(rs.getInt("id"));
                e.setUserId(rs.getInt("user_id"));
                e.setTitle(rs.getString("title"));
                e.setAmount(rs.getDouble("amount"));
                e.setCategory(rs.getString("category"));
                e.setDate(rs.getDate("date"));
                e.setType(rs.getString("type"));
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return e;
    }

    // ✅ UPDATE AN EXISTING EXPENSE
    public static boolean updateExpense(Expense e) {
        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE expenses SET title=?, amount=?, category=?, date=?, type=? WHERE id=?"
            );

            ps.setString(1, e.getTitle());
            ps.setDouble(2, e.getAmount());
            ps.setString(3, e.getCategory());
            ps.setDate(4, e.getDate());
            ps.setString(5, e.getType());
            ps.setInt(6, e.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return false;
    }

    // ✅ DELETE AN EXPENSE BY ID
    public static boolean deleteExpense(int id) {
        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM expenses WHERE id=?"
            );

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return false;
    }

    // ✅ FILTER EXPENSES BY DATE RANGE
    public static List<Expense> getExpensesByDate(int userId, String from, String to) {
        List<Expense> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps;

            // If a valid date range is provided
            if (from != null && to != null && !from.isEmpty() && !to.isEmpty()) {
                ps = con.prepareStatement(
                    "SELECT * FROM expenses WHERE user_id=? AND date BETWEEN ? AND ? ORDER BY date DESC"
                );
                ps.setInt(1, userId);
                ps.setDate(2, Date.valueOf(from));  
                ps.setDate(3, Date.valueOf(to));    
            } else {
                // If no filter is applied, return all expenses for the user
                ps = con.prepareStatement(
                    "SELECT * FROM expenses WHERE user_id=? ORDER BY date DESC"
                );
                ps.setInt(1, userId);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Expense e = new Expense();

                e.setId(rs.getInt("id"));
                e.setUserId(rs.getInt("user_id"));
                e.setTitle(rs.getString("title"));
                e.setAmount(rs.getDouble("amount"));
                e.setCategory(rs.getString("category"));
                e.setDate(rs.getDate("date"));
                e.setType(rs.getString("type"));

                list.add(e);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return list;
    }
}