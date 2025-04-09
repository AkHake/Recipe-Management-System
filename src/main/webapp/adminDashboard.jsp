<%@ page session="true" %>
<%@ include file="adminNavbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
        }

        .dashboard-container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            border-left: 6px solid #1c1c1c; /* dark */
            animation: fadeIn 0.6s ease-in-out;
        }

        .dashboard-title {
            color: #1c1c1c;
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
        }

        .tab-buttons {
            text-align: center;
            margin-bottom: 25px;
        }

        .tab-buttons button {
            background-color: #20c997; /* 30% teal */
            color: #fff;
            font-weight: 600;
            border: none;
            padding: 10px 22px;
            margin: 0 12px;
            border-radius: 50px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .tab-buttons button:hover {
            background-color: #1aa179;
            transform: scale(1.05);
        }

        .tab-content {
            display: none;
            animation: fadeIn 0.4s ease-in-out;
        }

        /* Modal Styling */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            background: rgba(0, 0, 0, 0.5);
            width: 100%;
            height: 100%;
            z-index: 1000;
        }

        .modal-box {
            position: fixed;
            top: 30%;
            left: 50%;
            transform: translate(-50%, -30%);
            background: #ffffff;
            padding: 30px;
            z-index: 1001;
            border-radius: 10px;
            border-left: 6px solid #fd7e14; /* 10% orange */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
            max-width: 400px;
            text-align: center;
        }

        .modal-box button {
            background-color: #fd7e14;
            color: white;
            border: none;
            padding: 10px 18px;
            border-radius: 6px;
            font-weight: 600;
            margin-top: 15px;
        }

        .modal-box button:hover {
            background-color: #e76e00;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive fix for small screens */
        @media (max-width: 768px) {
            .tab-buttons button {
                display: block;
                margin: 10px auto;
                width: 80%;
            }

            .dashboard-container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<%
    String statusMessage = (String) session.getAttribute("statusMessage");
    if (statusMessage != null) {
%>
<div class="modal-overlay" onclick="closeModal()"></div>
<div class="modal-box" id="statusModal">
    <i class="bi bi-info-circle-fill" style="font-size: 1.8rem; color: #fd7e14;"></i>
    <p class="mt-3"><strong>Status:</strong> <%= statusMessage %></p>
    <button onclick="closeModal()">Close</button>
</div>
<%
        session.removeAttribute("statusMessage");
    }
%>

<div class="dashboard-container">
    <h2 class="dashboard-title"><i class="bi bi-speedometer2 me-2"></i>Admin Dashboard</h2>

    <div class="tab-buttons">
        <button onclick="showTab('users')"><i class="bi bi-people-fill me-1"></i>Manage Users</button>
        <button onclick="showTab('recipes')"><i class="bi bi-journal-bookmark-fill me-1"></i>Manage Recipes</button>
    </div>

    <div id="users" class="tab-content">
        <jsp:include page="userList.jsp" />
    </div>

    <div id="recipes" class="tab-content">
        <jsp:include page="recipeList.jsp" />
    </div>
</div>

<script>
    function showTab(tab) {
        document.querySelectorAll('.tab-content').forEach(function (el) {
            el.style.display = 'none';
        });
        document.getElementById(tab).style.display = 'block';
    }

    // Show default tab on load
    document.addEventListener("DOMContentLoaded", function () {
        showTab('users');
    });

    function closeModal() {
        document.getElementById('statusModal').style.display = 'none';
        const overlay = document.querySelector('.modal-overlay');
        if (overlay) overlay.style.display = 'none';
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
