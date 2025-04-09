<%@ page import="java.sql.*, utils.DBUtil" %>
<%@ page session="true" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Recipes</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Light background */
            color: #343a40; /* Dark text */
        }

        h3 {
            color: #20c997; /* Teal */
            margin-top: 30px;
        }

        .container {
            margin-top: 40px;
        }

        table {
            width: 100%;
            background-color: #ffffff;
            border-collapse: collapse;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            border-radius: 8px;
            overflow: hidden;
        }

        th {
            background-color: #20c997; /* Teal */
            color: white;
            padding: 12px;
            text-align: center;
        }

        td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #dee2e6;
        }

        .status-approved {
            color: green;
            font-weight: bold;
        }

        .status-rejected {
            color: red;
            font-weight: bold;
        }

        .status-pending {
            color: orange;
            font-weight: bold;
        }

        .btn-toggle {
            background-color: #fd7e14; /* Orange */
            border: none;
            color: white;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-toggle:hover {
            background-color: #e76e09;
        }

        .logged-in {
            font-size: 1rem;
            color: #6c757d;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h3>My Recipes</h3>
    <p class="logged-in">Logged in as: <%= session.getAttribute("email") %></p>

    <table>
        <tr>
            <th>Name</th>
            <th>Status</th>
            <th>Public</th>
            <th>Comment</th>
            <th>Action</th>
        </tr>

        <%
        String userEmail = (String) session.getAttribute("email");
        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        userEmail = userEmail.toLowerCase();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM recipes WHERE submitted_by = ?")) {
            ps.setString(1, userEmail);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String status = rs.getString("status");
                String comment = rs.getString("comment");
        %>
        <tr>
            <td><%= rs.getString("name") %></td>
            <td class="status-<%= status %>">
                <%= status.substring(0, 1).toUpperCase() + status.substring(1) %>
            </td>
            <td><%= rs.getBoolean("is_public") ? "Yes" : "No" %></td>
            <td><%= comment == null ? "-" : comment %></td>
            <td>
                <% if ("approved".equals(status)) { %>
                <form action="TogglePublicServlet" method="post">
                    <input type="hidden" name="id" value="<%= id %>">
                    <input type="submit" value="<%= rs.getBoolean("is_public") ? "Make Private" : "Make Public" %>" class="btn-toggle">
                </form>
                <% } %>
            </td>
        </tr>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </table>
</div>
</body>
</html>
