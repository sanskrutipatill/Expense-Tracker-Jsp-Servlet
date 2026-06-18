package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import dao.UserDAO;
import model.User;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User u = new User();
        u.setName(req.getParameter("name"));
        u.setEmail(req.getParameter("email"));
        u.setPassword(req.getParameter("password"));

        if (UserDAO.register(u)) {
            res.sendRedirect("login.jsp");
        } else {
            res.sendRedirect("error.jsp");
        }
    }
}