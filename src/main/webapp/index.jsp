<%@ page import="java.sql.*, utils.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <title>Recipe Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .card-text-scroll {
            max-height: 100px;
            overflow-y: auto;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<!-- Success Message -->
<%
    String success = request.getParameter("success");
    if ("1".equals(success)) {
%>
<div style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; border: 1px solid #c3e6cb; margin: 10px 20px;">
    ✅ Your recipe was submitted and is pending admin approval!
</div>
<%
    }
%>

<!-- Main Content -->
<div class="container mt-5 text-center">
    <h1 class="display-4">Welcome to CookConnect</h1>
    <p class="lead">Share your culinary creativity or explore delicious recipes!</p></div>

<!-- Public Approved Recipes -->
<div class="container mt-5">
    <h2 class="text-center mb-4">Featured Recipes</h2>
    <div class="row">
        <%
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement ps = conn.prepareStatement(
                     "SELECT image, name, category, ingredients, method, submitted_by FROM recipes WHERE status = 'approved' AND is_public = true");
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    String imagePath = rs.getString("image");
        %>
        <div class="col-md-4 mb-4">
            <div class="card h-100 shadow-sm">
                <% if (imagePath != null && !imagePath.isEmpty()) { %>
                    <img src="<%= imagePath %>" class="card-img-top" alt="Recipe Image">
                <% } else { %>
                    <img src="images/default.jpg" class="card-img-top" alt="Default Recipe Image">
                <% } %>
                <div class="card-body">
                    <h5 class="card-title"><%= rs.getString("name") %></h5>
                    <p class="text-muted mb-1">Category: <%= rs.getString("category") %></p>
                    <p class="text-muted mb-1">Submitted by: <%= rs.getString("submitted_by") %></p>
                    <hr>
                    <p class="fw-bold mb-1">Ingredients:</p>
                    <p class="card-text card-text-scroll"><%= rs.getString("ingredients") %></p>
                    <p class="fw-bold mt-3 mb-1">Method:</p>
                    <p class="card-text card-text-scroll"><%= rs.getString("method") %></p>
                </div>
            </div>
        </div>
        <%
                }
            } catch (Exception e) {
                out.println("<p class='text-danger text-center'>Error fetching public recipes.</p>");
                e.printStackTrace();
            }
        %>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    setTimeout(function () {
        const alertBox = document.querySelector("div[style*='background-color: #d4edda']");
        if (alertBox) alertBox.style.display = 'none';
    }, 5000);
</script>

</body>
</html>
