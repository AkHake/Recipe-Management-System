<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* light background */
            font-family: 'Segoe UI', sans-serif;
        }

        .registration-container {
            max-width: 500px;
            margin: auto;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.08);
            padding: 30px;
            margin-top: 50px;
            border-top: 6px solid #1c1c1c; /* 60% dark top border */
        }

        .registration-container h2 {
            color: #1c1c1c;
            text-align: center;
            margin-bottom: 25px;
        }

        .form-label {
            font-weight: 600;
            color: #1c1c1c;
        }

        .form-control {
            border-radius: 5px;
            border: 1px solid #ced4da;
        }

        .form-control:focus {
            border-color: #20c997;
            box-shadow: 0 0 5px rgba(32, 201, 151, 0.4);
        }

        .btn-register {
            background-color: #fd7e14; /* 10% orange */
            color: white;
            font-weight: 600;
            border: none;
            transition: background-color 0.3s ease;
        }

        .btn-register:hover {
            background-color: #e76e00;
        }

        .alert-info {
            background-color: #e0f7fa;
            color: #00796b;
            border: 1px solid #b2ebf2;
        }

        .form-footer {
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="registration-container">
    <h2>User Registration</h2>
    <form action="register" method="post">
        <div class="mb-3">
            <label class="form-label">Name</label>
            <input type="text" name="name" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Email ID</label>
            <input type="email" name="email" class="form-control" required/>
        </div>
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required/>
        </div>
        <div class="mb-3">
            <label class="form-label">Confirm Password</label>
            <input type="password" name="confirmPassword" class="form-control" required/>
        </div>
        <button type="submit" class="btn btn-register w-100">Register</button>
    </form>

    <div class="form-footer">
        <%
            String message = request.getParameter("message");
            if (message != null) {
        %>
        <div class="alert alert-info mt-3"><%= message %></div>
        <%
            }
        %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
