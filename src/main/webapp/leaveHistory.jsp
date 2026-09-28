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
    <title>Leave History</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body class="dashboard-page">

    <div class="dashboard-circle dashboard-circle-one"></div>
    <div class="dashboard-circle dashboard-circle-two"></div>

    <header class="dashboard-header">

        <div class="dashboard-brand">
            <div class="brand-mark">EL</div>
            <div>
                <h2>Employee Leave</h2>
                <span>Management System</span>
            </div>
        </div>

        <div class="user-info">
            <div class="user-avatar">R</div>
            <div>
                <strong>Employee</strong>
                <span>Leave Portal</span>
            </div>
        </div>

    </header>

    <div class="dashboard-layout">

        <aside class="sidebar">

            <a href="employeeDashboard.jsp" class="sidebar-link">
                Dashboard
            </a>

            <a href="applyLeave.jsp" class="sidebar-link">
                Apply Leave
            </a>

            <a href="leaveHistory.jsp" class="sidebar-link active">
                Leave History
            </a>

        </aside>

        <main class="dashboard-content">

            <div class="dashboard-welcome">

                <div>
                    <p class="eyebrow">LEAVE MANAGEMENT</p>

                    <h1>Leave History</h1>

                    <p>
                        View your previous leave applications and their current status.
                    </p>
                </div>

            </div>

            <div class="dashboard-card history-card">

                <div class="form-heading">
                    <h2>Your Applications</h2>
                    <p>All your submitted leave requests are shown below.</p>
                </div>

                <div class="history-table-wrapper">

                    <table class="history-table">

                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Leave Type</th>
                                <th>From</th>
                                <th>To</th>
                                <th>Days</th>
                                <th>Reason</th>
                                <th>Status</th>
                            </tr>
                        </thead>

                        <tbody>

<%
    try {

        Connection con = DBConnection.getConnection();

        String sql =
            "SELECT la.application_id, " +
            "lt.leave_name, " +
            "la.from_date, " +
            "la.to_date, " +
            "la.number_of_days, " +
            "la.reason, " +
            "la.status " +
            "FROM leave_applications la " +
            "JOIN leave_types lt " +
            "ON la.leave_type_id = lt.leave_type_id " +
            "WHERE la.employee_id = ? " +
            "ORDER BY la.application_id DESC";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, employeeId);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
%>

                            <tr>

                                <td>
                                    #<%= rs.getInt("application_id") %>
                                </td>

                                <td>
                                    <strong>
                                        <%= rs.getString("leave_name") %>
                                    </strong>
                                </td>

                                <td>
                                    <%= rs.getDate("from_date") %>
                                </td>

                                <td>
                                    <%= rs.getDate("to_date") %>
                                </td>

                                <td>
                                    <%= rs.getInt("number_of_days") %>
                                </td>

                                <td class="reason-cell">
                                    <%= rs.getString("reason") %>
                                </td>

                                <td>
                                    <span class="status-badge">
                                        <%= rs.getString("status") %>
                                    </span>
                                </td>

                            </tr>

<%
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {

        out.println(
            "<tr><td colspan='7'>Error loading leave history.</td></tr>"
        );

    }
%>

                        </tbody>

                    </table>

                </div>

                <div class="history-footer">

                    <a href="employeeDashboard.jsp" class="cancel-btn">
                        Back to Dashboard
                    </a>

                    <a href="applyLeave.jsp" class="dashboard-action primary-action">
                        Apply for Leave
                    </a>

                </div>

            </div>

        </main>

    </div>

</body>
</html>