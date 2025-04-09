<%@ page session="true" %>
<style>
    .navbar-custom {
        background-color: #1c1c1c; /* 60% dark */
        padding: 10px 20px;
    }

    .navbar-brand {
        color: #fd7e14 !important; /* 10% orange */
        font-weight: bold;
        font-size: 1.6rem;
        letter-spacing: 1px;
    }

    .navbar-nav .nav-link {
        color: #20c997 !important; /* 30% teal */
        margin-right: 15px;
        transition: color 0.3s ease;
        font-weight: 500;
    }

    .navbar-nav .nav-link:hover {
        color: #fd7e14 !important;
        text-decoration: underline;
    }

    .btn-outline-light {
        color: #20c997 !important;
        border-color: #20c997 !important;
        font-weight: 500;
    }

    .btn-outline-light:hover {
        background-color: #20c997 !important;
        color: #fff !important;
    }

    .user-welcome {
        color: #e0f7fa;
        margin-left: 15px;
        font-size: 1rem;
        font-weight: 500;
    }

    .navbar-toggler {
        border-color: rgba(255, 255, 255, 0.1);
    }

    .navbar-toggler-icon {
        background-image: url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba%28255,255,255,0.7%29' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
    }

    .logout-btn {
        margin-left: 15px;
        font-weight: 500;
        background-color: transparent;
        border: 1px solid #fd7e14;
        color: #fd7e14;
        padding: 5px 12px;
        border-radius: 5px;
        transition: all 0.3s ease;
    }

    .logout-btn:hover {
        background-color: #fd7e14;
        color: #fff;
    }
</style>

<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">CookConnect</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 d-flex align-items-center">
                <%
                    String role = (String) session.getAttribute("role");
                    String userName = (String) session.getAttribute("name");

                    if ("user".equalsIgnoreCase(role)) {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="submitRecipe.jsp">Submit Recipe</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="myRecipes.jsp">My Recipes</a>
                </li>
                <%
                    }
                    if (userName == null) {
                %>
                <li class="nav-item">
                    <a class="btn btn-outline-light me-2" href="register.jsp">Register</a>
                </li>
                <li class="nav-item">
                    <a class="btn btn-outline-light" href="login.jsp">Login</a>
                </li>
                <%
                    } else {
                %>
                <li class="nav-item d-flex align-items-center">
                    <p class="user-welcome mb-0">Welcome, <%= userName %>!</p>
                    <form action="logout.jsp" method="post" class="ms-3">
                        <button type="submit" class="logout-btn">Logout</button>
                    </form>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
</nav>
