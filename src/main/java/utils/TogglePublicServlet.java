package utils;

import utils.DBUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;


    @WebServlet("/TogglePublicServlet")
    public class TogglePublicServlet extends HttpServlet {
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            int id = Integer.parseInt(request.getParameter("id"));
            try (Connection conn = DBUtil.getConnection()) {
                PreparedStatement ps = conn.prepareStatement("UPDATE recipes SET is_public = NOT is_public WHERE id = ?");
                ps.setInt(1, id);
                ps.executeUpdate();
            } catch (Exception e) { e.printStackTrace(); }
            response.sendRedirect("myRecipes.jsp");
        }
    }