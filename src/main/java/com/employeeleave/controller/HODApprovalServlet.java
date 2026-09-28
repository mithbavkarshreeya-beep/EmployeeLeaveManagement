package com.employeeleave.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.employeeleave.dao.DBConnection;

@WebServlet("/HODApprovalServlet")
public class HODApprovalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int applicationId =
                Integer.parseInt(request.getParameter("id"));

        String action = request.getParameter("action");

        try {

            Connection con = DBConnection.getConnection();

            String newStatus;

            if ("APPROVE".equals(action)) {
                newStatus = "PENDING_PRINCIPAL";
            } else {
                newStatus = "REJECTED";
            }

            String sql =
                    "UPDATE leave_applications " +
                    "SET status = ? " +
                    "WHERE application_id = ?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, newStatus);
            ps.setInt(2, applicationId);

            ps.executeUpdate();

            ps.close();
            con.close();

            response.sendRedirect("hodDashboard.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error: " + e.getMessage()
            );
        }
    }
}