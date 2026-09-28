<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Leave Management System</title>

    <link rel="stylesheet" href="css/style.css">
</head>

<body>

    <div class="login-page">

        <!-- Background decoration -->
        <div class="circle circle-one"></div>
        <div class="circle circle-two"></div>
        <div class="circle circle-three"></div>

        <!-- Left side -->
        <div class="login-intro">

            <div class="brand">
                <div class="brand-mark">E</div>
                <span>ELMS</span>
            </div>

            <div class="intro-content">
                <p class="eyebrow">WELCOME TO</p>

                <h1>
                    Employee Leave<br>
                    Management System
                </h1>

                <p class="intro-text">
                    Manage your leave requests, view balances
                    and stay connected all in one place.
                </p>

                <div class="features">
                    <span>Simple</span>
                    <span>•</span>
                    <span>Secure</span>
                    <span>•</span>
                    <span>Efficient</span>
                </div>
            </div>

        </div>


        <!-- Login card -->
        <div class="login-box">

            <div class="card-brand">
                <div class="brand-mark small">E</div>
                <span>ELMS</span>
            </div>

            <h2>Welcome Back</h2>

            <p class="subtitle">
                Sign in to access your leave portal.
            </p>

            <form action="LoginServlet" method="post">

                <div class="form-group">
                    <label>Email Address</label>
                    <input
                        type="email"
                        name="email"
                        placeholder="Enter your email"
                        required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input
                        type="password"
                        name="password"
                        placeholder="Enter your password"
                        required>
                </div>

                <button type="submit" class="btn">
                    Login <span>→</span>
                </button>

            </form>

        </div>

    </div>

</body>
</html>