package utils;
import utils.DBUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE email = ?");
            ps.setString(1, email);
            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("User deleted: " + email);
            } else {
                System.out.println("No user found with email: " + email);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to the admin dashboard to reflect changes
        response.sendRedirect("adminDashboard.jsp");
    }
}
