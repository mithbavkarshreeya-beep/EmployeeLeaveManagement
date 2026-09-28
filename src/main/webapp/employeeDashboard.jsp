<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.employeeleave.dao.DBConnection" %>

<%
    Integer employeeId =
        (Integer) session.getAttribute("employeeId");

    if (employeeId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Employee Dashboard</title>

    <link rel="stylesheet" href="css/style.css">

</head>

<body>

<div class="dashboard-page">

    <!-- Background decoration -->
    <div class="dashboard-circle circle-one"></div>
    <div class="dashboard-circle circle-two"></div>


    <!-- ================= HEADER ================= -->

    <header class="dashboard-header">

        <div class="dashboard-brand">
            <div class="brand-mark small">E</div>
            <span>ELMS</span>
        </div>

        <div class="user-info">

            <div class="user-avatar">
                R
            </div>

            <div>
                <strong>Rahul Sharma</strong>
                <small>Employee</small>
            </div>

        </div>

    </header>


    <!-- ================= MAIN AREA ================= -->

    <div class="dashboard-layout">


        <!-- ================= SIDEBAR ================= -->

        <aside class="sidebar">

            <a href="employeeDashboard.jsp"
               class="sidebar-link active">
                <span>⌂</span>
                Dashboard
            </a>

            <a href="applyLeave.jsp"
               class="sidebar-link">
                <span>＋</span>
                Apply Leave
            </a>

            <a href="leaveHistory.jsp"
               class="sidebar-link">
                <span>◷</span>
                Leave History
            </a>

        </aside>


        <!-- ================= CONTENT ================= -->

        <main class="dashboard-content">

            <div class="dashboard-welcome">

                <h1>Good morning, Rahul</h1>

                <p>
                    Manage your leave requests and balances.
                </p>

            </div>


            <!-- ================= LEAVE BALANCE ================= -->

            <section class="dashboard-card">

                <h2>Leave Balance</h2>

                <div class="leave-balance-new">

<%
    try {

        Connection con = DBConnection.getConnection();

        String sql =
            "SELECT lt.leave_name, " +
            "lb.allocated, " +
            "lb.used, " +
            "(lb.allocated - lb.used) AS remaining " +
            "FROM leave_balances lb " +
            "JOIN leave_types lt " +
            "ON lb.leave_type_id = lt.leave_type_id " +
            "WHERE lb.employee_id = ?";

        PreparedStatement ps =
            con.prepareStatement(sql);

        ps.setInt(1, employeeId);

        ResultSet rs =
            ps.executeQuery();

        while (rs.next()) {

%>

                    <div class="leave-balance-new-item">

                        <div class="leave-icon">
                            ✓
                        </div>

                        <h3>
                            <%= rs.getString("leave_name") %>
                        </h3>

                        <div class="remaining-number">
                            <%= rs.getInt("remaining") %>
                        </div>

                        <p>remaining</p>

                    </div>

<%
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {

        out.println(
            "Error: " + e.getMessage()
        );

    }
%>

                </div>

            </section>


            <!-- ================= ACTIONS ================= -->

            <section class="dashboard-actions">

                <h2>What would you like to do?</h2>

                <div class="action-buttons">

                    <a href="applyLeave.jsp"
                       class="dashboard-action primary">

                        <span>Apply for Leave</span>

                        <span class="arrow">→</span>

                    </a>


                    <a href="leaveHistory.jsp"
                       class="dashboard-action secondary">

                        <span>Leave History</span>

                        <span class="arrow">→</span>

                    </a>

                </div>

            </section>


        </main>

    </div>

</div>

</body>

</html>