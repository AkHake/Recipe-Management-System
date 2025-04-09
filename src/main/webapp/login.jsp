<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <title>Login</title>
    <style>
        body {
            background-color: #f8f9fa; /* light background */
            font-family: 'Segoe UI', sans-serif;
        }

        .login-container {
            max-width: 500px;
            margin: auto;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.08);
            padding: 30px;
            margin-top: 50px;
            border-top: 6px solid #1c1c1c; /* 60% dark top border */
        }

        .login-container h2 {
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
            border-color: #20c997; /* teal */
            box-shadow: 0 0 5px rgba(32, 201, 151, 0.4);
        }

        .btn-login {
            background-color: #fd7e14; /* 10% orange */
            color: white;
            font-weight: 600;
            border: none;
            transition: background-color 0.3s ease;
        }

        .btn-login:hover {
            background-color: #e76e00;
        }

        .alert-danger {
            background-color: #ffe5e5;
            color: #a10000;
            border: 1px solid #ffcccc;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="login-container">
    <h2>Login</h2>
    <form action="login" method="post">
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required />
        </div>
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required />
        </div>
        <button type="submit" class="btn btn-login w-100">Login</button>
    </form>

    <%
        String message = request.getParameter("message");
        if (message != null) {
    %>
        <div class="alert alert-danger mt-3 text-center"><%= message %></div>
    <%
        }
    %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
