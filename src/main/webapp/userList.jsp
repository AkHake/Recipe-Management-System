<%@ page import="java.sql.*, utils.DBUtil" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<style>
    .user-table-container {
        margin-top: 20px;
        overflow-x: auto;
    }

    .user-table th {
        background-color: #1c1c1c; /* 60% dark */
        color: white;
        text-align: center;
    }

    .user-table td {
        text-align: center;
        vertical-align: middle;
    }

    .delete-btn {
        background-color: #dc3545; /* 10% red */
        color: white;
        padding: 6px 12px;
        border: none;
        border-radius: 5px;
        font-weight: bold;
        transition: background-color 0.3s ease;
    }

    .delete-btn:hover {
        background-color: #c82333;
    }

    form {
        margin: 0;
    }
</style>

<div class="user-table-container">
    <table class="table table-bordered table-hover user-table">
        <thead>
            <tr>
                <th>Email</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM users");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("email") %></td>
            <td>
                <form action="DeleteUserServlet" method="post">
                    <input type="hidden" name="email" value="<%= rs.getString("email") %>">
                    <button type="submit" class="delete-btn">Delete</button>
                </form>
            </td>
        </tr>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
        </tbody>
    </table>
</div>
