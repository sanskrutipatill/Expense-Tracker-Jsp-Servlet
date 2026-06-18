package model;

import java.sql.Date;

public class Expense {

    private int id;
    private int userId;

    private String title;
    private String category;
    private String type;   // ✅ NEW FIELD (Income / Expense)

    private double amount;
    private Date date;

    // 🔹 ID
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // 🔹 USER ID
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    // 🔹 TITLE
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    // 🔹 CATEGORY
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    // 🔹 TYPE (Income / Expense)
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    // 🔹 AMOUNT
    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    // 🔹 DATE
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}