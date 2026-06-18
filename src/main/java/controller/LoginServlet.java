 package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import dao.UserDAO;
import model.User;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User u = UserDAO.login(email, password);

        if (u != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", u);
            res.sendRedirect("dashboard.jsp");
        } else {
            res.sendRedirect("error.jsp");
        }
    }
}