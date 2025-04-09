package utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?message=Passwords do not match");
            return;
        }

        try (Connection conn = DBUtil.getConnection()) {
            // Check if user already exists
            PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                response.sendRedirect("register.jsp?message=Email already registered");
                return;
            }

            // Insert user with name
            PreparedStatement insertStmt = conn.prepareStatement(
                    "INSERT INTO users (name, email, password, role, status) VALUES (?, ?, ?, 'user', 'active')");
            insertStmt.setString(1, name);
            insertStmt.setString(2, email);
            insertStmt.setString(3, password); // Note: hash in real apps

            int result = insertStmt.executeUpdate();

            if (result > 0) {
                response.sendRedirect("login.jsp?message=Registration successful, please login.");
            } else {
                response.sendRedirect("register.jsp?message=Registration failed.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?message=An error occurred.");
        }
    }
}

