package utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/RecipeSubmitServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,    // 2MB
        maxFileSize = 1024 * 1024 * 10,         // 10MB
        maxRequestSize = 1024 * 1024 * 50       // 50MB
)
public class RecipeSubmitServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String ingredients = request.getParameter("ingredients");
        String method = request.getParameter("method");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp?message=Please login to submit a recipe.");
            return;
        }

        String submittedBy = ((String) session.getAttribute("email")).toLowerCase();

        Part imagePart = request.getPart("image");
        String fileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();  // safer
        }

        String imagePath = "uploads/" + fileName;
        imagePart.write(uploadPath + File.separator + fileName);

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO recipes (name, category, ingredients, method, image, submitted_by, status) " +
                            "VALUES (?, ?, ?, ?, ?, ?, 'pending')"
            );
            ps.setString(1, name);
            ps.setString(2, category);
            ps.setString(3, ingredients);
            ps.setString(4, method);
            ps.setString(5, imagePath);
            ps.setString(6, submittedBy);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=1");
            return;
        }

        response.sendRedirect("index.jsp?success=1");
    }
}
