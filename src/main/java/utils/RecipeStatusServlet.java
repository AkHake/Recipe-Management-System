package utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/RecipeStatusServlet")
public class RecipeStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int recipeId = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action");
        String comment = request.getParameter("comment");

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps;
            if ("Approve".equals(action)) {
                ps = conn.prepareStatement("UPDATE recipes SET status = ?, admin_comment = NULL WHERE id = ?");
                ps.setString(1, "approved");
                ps.setInt(2, recipeId);
                ps.executeUpdate();
                response.sendRedirect("adminDashboard.jsp?msg=Recipe+approved+successfully");
            } else if ("Reject".equals(action)) {
                ps = conn.prepareStatement("UPDATE recipes SET status = ?, admin_comment = ? WHERE id = ?");
                ps.setString(1, "rejected");
                ps.setString(2, comment != null ? comment : "No comment provided");
                ps.setInt(3, recipeId);
                ps.executeUpdate();
                response.sendRedirect("adminDashboard.jsp?msg=Recipe+rejected+successfully");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("statusMessage", "Error: " + e.getMessage());
            response.sendRedirect("adminDashboard.jsp");
        }
    }
}
