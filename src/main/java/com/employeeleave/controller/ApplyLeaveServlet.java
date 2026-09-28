package com.employeeleave.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.employeeleave.dao.DBConnection;

@WebServlet("/ApplyLeaveServlet")
public class ApplyLeaveServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String leaveType = request.getParameter("leaveType");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String reason = request.getParameter("reason");
        String handoverName = request.getParameter("handoverName");
        String handoverNotes = request.getParameter("handoverNotes");

        Integer employeeId =
                (Integer) request.getSession().getAttribute("employeeId");

        try {
            LocalDate from = LocalDate.parse(fromDate);
            LocalDate to = LocalDate.parse(toDate);

            int numberOfDays = (int) (ChronoUnit.DAYS.between(from, to) + 1);

            Connection con = DBConnection.getConnection();

            // Find handover employee ID using their name
            Integer handoverEmployeeId = null;

            if (handoverName != null && !handoverName.trim().isEmpty()) {

                String handoverSql =
                        "SELECT employee_id FROM employees WHERE name = ?";

                PreparedStatement handoverPs =
                        con.prepareStatement(handoverSql);

                handoverPs.setString(1, handoverName);

                ResultSet handoverRs = handoverPs.executeQuery();

                if (handoverRs.next()) {
                    handoverEmployeeId =
                            handoverRs.getInt("employee_id");
                }

                handoverRs.close();
                handoverPs.close();
            }

            // Insert leave application
            String sql = "INSERT INTO leave_applications "
                    + "(employee_id, leave_type_id, from_date, to_date, "
                    + "number_of_days, reason, handover_employee_id, "
                    + "handover_notes, status) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'PENDING_HOD')";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, employeeId);
            ps.setInt(2, Integer.parseInt(leaveType));
            ps.setDate(3, Date.valueOf(from));
            ps.setDate(4, Date.valueOf(to));
            ps.setInt(5, numberOfDays);
            ps.setString(6, reason);

            if (handoverEmployeeId != null) {
                ps.setInt(7, handoverEmployeeId);
            } else {
                ps.setNull(7, java.sql.Types.INTEGER);
            }

            ps.setString(8, handoverNotes);

            ps.executeUpdate();

            ps.close();
            con.close();

            response.getWriter().println(
                    "Leave application submitted successfully!"
            );

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println(
                    "Error: " + e.getMessage()
            );
        }
    }
}