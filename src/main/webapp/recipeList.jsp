<%@ page import="java.sql.*, utils.DBUtil" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
    .recipe-table-container {
        margin-top: 20px;
        overflow-x: auto;
    }

    .recipe-table th {
        background-color: #1c1c1c;
        color: white;
        text-align: center;
        vertical-align: middle;
    }

    .recipe-table td {
        vertical-align: middle;
        text-align: center;
    }

    .recipe-table img {
        max-width: 100px;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .status-label {
        font-weight: bold;
        padding: 6px 12px;
        border-radius: 5px;
        display: inline-block;
    }

    .status-pending {
        background-color: orange;
        color: white;
    }

    .status-approved {
        background-color: green;
        color: white;
    }

    .status-rejected {
        background-color: red;
        color: white;
    }

    .action-btn {
        margin: 3px;
    }

    .comment-input {
        width: 100%;
        padding: 5px 8px;
        border: 1px solid #ced4da;
        border-radius: 5px;
    }

    form {
        margin: 0;
    }
</style>

<div class="recipe-table-container">
    <table class="table table-bordered table-hover recipe-table">
        <thead>
        <tr>
            <th>Name</th>
            <th>Category</th>
            <th>Image</th>
            <th>Status</th>
            <th>Action</th>
            <th>Comment</th>
        </tr>
        </thead>
        <tbody>
        <%
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement ps = conn.prepareStatement("SELECT * FROM recipes");
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    String status = rs.getString("status");
        %>
        <form action="RecipeStatusServlet" method="post">
            <tr>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("category") %></td>
                <td><img src="<%= rs.getString("image") %>" alt="Recipe Image"></td>
                <td>
                    <span class="status-label
                        <%= "approved".equals(status) ? "status-approved" :
                             "rejected".equals(status) ? "status-rejected" :
                             "status-pending" %>">
                        <%= status.substring(0,1).toUpperCase() + status.substring(1) %>
                    </span>
                </td>
                <td>
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <% if (!"approved".equals(status)) { %>
                        <input type="submit" name="action" value="Approve" class="btn btn-success btn-sm action-btn">
                    <% } %>
                    <% if (!"rejected".equals(status)) { %>
                        <input type="submit" name="action" value="Reject" class="btn btn-danger btn-sm action-btn">
                    <% } %>
                </td>
                <td>
                    <input type="text" name="comment" placeholder="Reason (if rejected)" class="comment-input">
                </td>
            </tr>
        </form>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>
</div>
