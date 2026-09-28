package com.employeeleave.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.employeeleave.dao.DBConnection;

@WebServlet("/PrincipalApprovalServlet")
public class PrincipalApprovalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int applicationId =
                Integer.parseInt(request.getParameter("id"));

        String action = request.getParameter("action");

        try {

            Connection con = DBConnection.getConnection();

            // If Principal rejects the application
            if ("REJECT".equals(action)) {

                String sql =
                        "UPDATE leave_applications " +
                        "SET status = 'REJECTED' " +
                        "WHERE application_id = ?";

                PreparedStatement ps = con.prepareStatement(sql);

                ps.setInt(1, applicationId);

                ps.executeUpdate();

                ps.close();

            }

            // If Principal approves the application
            else if ("APPROVE".equals(action)) {

                // First get employee, leave type and number of days
                String selectSql =
                        "SELECT employee_id, leave_type_id, number_of_days " +
                        "FROM leave_applications " +
                        "WHERE application_id = ?";

                PreparedStatement selectPs =
                        con.prepareStatement(selectSql);

                selectPs.setInt(1, applicationId);

                ResultSet rs = selectPs.executeQuery();

                if (rs.next()) {

                    int employeeId =
                            rs.getInt("employee_id");

                    int leaveTypeId =
                            rs.getInt("leave_type_id");

                    int numberOfDays =
                            rs.getInt("number_of_days");

                    // Update leave balance
                    String balanceSql =
                            "UPDATE leave_balances " +
                            "SET used = used + ? " +
                            "WHERE employee_id = ? " +
                            "AND leave_type_id = ?";

                    PreparedStatement balancePs =
                            con.prepareStatement(balanceSql);

                    balancePs.setInt(1, numberOfDays);
                    balancePs.setInt(2, employeeId);
                    balancePs.setInt(3, leaveTypeId);

                    balancePs.executeUpdate();

                    balancePs.close();

                    // Finally approve the application
                    String approvalSql =
                            "UPDATE leave_applications " +
                            "SET status = 'APPROVED' " +
                            "WHERE application_id = ?";

                    PreparedStatement approvalPs =
                            con.prepareStatement(approvalSql);

                    approvalPs.setInt(1, applicationId);

                    approvalPs.executeUpdate();

                    approvalPs.close();
                }

                rs.close();
                selectPs.close();
            }

            con.close();

            response.sendRedirect("principalDashboard.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error: " + e.getMessage()
            );
        }
    }
}