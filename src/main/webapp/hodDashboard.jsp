<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.employeeleave.dao.DBConnection" %>

<%
    Integer employeeId =
        (Integer) session.getAttribute("employeeId");

    String department =
        (String) session.getAttribute("department");

    if (employeeId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HOD Dashboard</title>
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
            <div class="user-avatar">H</div>

            <div>
                <strong>HOD</strong>
                <span><%= department %></span>
            </div>
        </div>

    </header>


    <div class="dashboard-layout">

        <aside class="sidebar">

            <a href="hodDashboard.jsp" class="sidebar-link active">
                Pending Requests
            </a>

        </aside>


        <main class="dashboard-content">

            <div class="dashboard-welcome">

                <div>
                    <p class="eyebrow">APPROVAL MANAGEMENT</p>

                    <h1>HOD Dashboard</h1>

                    <p>
                        Review and manage leave applications from your department.
                    </p>
                </div>

            </div>


            <div class="dashboard-card approval-card">

                <div class="form-heading">

                    <h2>Pending Leave Applications</h2>

                    <p>
                        Review the following requests before sending them
                        for final approval.
                    </p>

                </div>


                <div class="approval-table-wrapper">

                    <table class="approval-table">

                        <thead>

                            <tr>
                                <th>ID</th>
                                <th>Employee</th>
                                <th>Leave Type</th>
                                <th>From</th>
                                <th>To</th>
                                <th>Days</th>
                                <th>Reason</th>
                                <th>Handover</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>

                        </thead>

                        <tbody>

<%
    try {

        Connection con = DBConnection.getConnection();

        String sql =
            "SELECT la.application_id, e.name AS employee_name, " +
            "lt.leave_name, la.from_date, la.to_date, " +
            "la.number_of_days, la.reason, " +
            "h.name AS handover_name, la.status " +
            "FROM leave_applications la " +
            "JOIN employees e ON la.employee_id = e.employee_id " +
            "JOIN leave_types lt ON la.leave_type_id = lt.leave_type_id " +
            "LEFT JOIN employees h ON la.handover_employee_id = h.employee_id " +
            "WHERE la.status = 'PENDING_HOD' " +
            "AND e.department = ?";

        PreparedStatement ps =
            con.prepareStatement(sql);

        ps.setString(1, department);

        ResultSet rs =
            ps.executeQuery();

        while (rs.next()) {
%>

                            <tr>

                                <td>
                                    #<%= rs.getInt("application_id") %>
                                </td>

                                <td>
                                    <strong>
                                        <%= rs.getString("employee_name") %>
                                    </strong>
                                </td>

                                <td>
                                    <%= rs.getString("leave_name") %>
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

                                <td class="approval-reason">
                                    <%= rs.getString("reason") %>
                                </td>

                                <td>
                                    <%= rs.getString("handover_name") %>
                                </td>

                                <td>
                                    <span class="status-badge">
                                        <%= rs.getString("status") %>
                                    </span>
                                </td>

                                <td>

                                    <div class="approval-actions">

                                        <a
                                            class="approve-btn"
                                            href="HODApprovalServlet?id=<%= rs.getInt("application_id") %>&action=APPROVE"
                                        >
                                            Approve
                                        </a>

                                        <a
                                            class="reject-btn"
                                            href="HODApprovalServlet?id=<%= rs.getInt("application_id") %>&action=REJECT"
                                        >
                                            Reject
                                        </a>

                                    </div>

                                </td>

                            </tr>

<%
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {

        out.println(
            "<tr><td colspan='10'>Error loading applications.</td></tr>"
        );

    }
%>

                        </tbody>

                    </table>

                </div>

            </div>

        </main>

    </div>

</body>
</html>