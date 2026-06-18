# Expense Tracker – JSP Servlet Web Application

A web-based Expense Tracker developed using JSP, Servlets, JDBC, and MySQL for managing personal expenses, income records, and financial tracking.

## Features

- User Registration & Login Authentication
- Add, Update, Delete Expenses
- Income Management
- Expense Categorization
- Dashboard for Financial Overview
- MySQL Database Integration
- Session-Based User Management
- Responsive User Interface

## Tech Stack

- Java
- JSP
- Servlets
- JDBC
- MySQL
- Apache Tomcat
- HTML
- CSS

## Setup Instructions

### Prerequisites

- Java JDK 8+
- Apache Tomcat 9+
- MySQL Server
- Eclipse IDE / VS Code

### 1. Database Setup

Create a MySQL database and import the required tables.

Update database credentials in your DAO classes:

```java
String url = "jdbc:mysql://localhost:3306/expense_tracker";
String username = "root";
String password = "your_password";
```

### 2. Configure Tomcat

- Install Apache Tomcat
- Add Tomcat Server in Eclipse
- Deploy the project to the server

### 3. Run the Project

Start Tomcat Server and open:

```text
http://localhost:8080/ExpenseTracker
```

## Main Modules

- User Authentication
- Expense Management
- Income Management
- Dashboard
- Transaction History
- Profile Management

## Future Enhancements

- Expense Analytics & Charts
- Budget Planning
- Export Reports (PDF/Excel)
- Email Notifications

## Author

**Sanskruti Patil**  
B.Tech Computer Science Engineering | Minor in Cybersecurity
