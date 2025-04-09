<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Recipe</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Light background */
            font-family: 'Segoe UI', sans-serif;
        }

        .recipe-container {
            max-width: 700px;
            margin: auto;
            margin-top: 50px;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.07);
            border-left: 6px solid #1c1c1c; /* 60% dark primary */
        }

        .recipe-container h2 {
            color: #1c1c1c;
            text-align: center;
            margin-bottom: 25px;
        }

        .form-label {
            font-weight: 600;
            color: #1c1c1c;
        }

        .form-control, .form-select, textarea {
            border-radius: 5px;
            border: 1px solid #ced4da;
        }

        .form-control:focus, .form-select:focus, textarea:focus {
            border-color: #20c997; /* teal accent */
            box-shadow: 0 0 5px rgba(32, 201, 151, 0.4);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .btn-submit {
            background-color: #fd7e14; /* 10% orange */
            color: white;
            font-weight: 600;
            border: none;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #e76e00;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="recipe-container">
    <h2>Submit a New Recipe</h2>
    <form action="RecipeSubmitServlet" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">Recipe Name</label>
            <input type="text" name="name" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Category</label>
            <select name="category" class="form-select">
                <option value="veg">Veg</option>
                <option value="non-veg">Non-Veg</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Ingredients</label>
            <textarea name="ingredients" class="form-control" required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Method</label>
            <textarea name="method" class="form-control" required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Upload Dish Image</label>
            <input type="file" name="image" class="form-control" accept="image/*" required>
        </div>

        <button type="submit" class="btn btn-submit">Submit Recipe</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>