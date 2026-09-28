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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        String sql = "SELECT * FROM employees WHERE email = ? AND password = ?";

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                int employeeId = rs.getInt("employee_id");
                String role = rs.getString("role");

                request.getSession().setAttribute("employeeId", employeeId);
                request.getSession().setAttribute("role", role);
                
                String department = rs.getString("department");
                request.getSession().setAttribute("department", department);

                if (role.equals("EMPLOYEE")) {
                    response.sendRedirect("employeeDashboard.jsp");

                } else if (role.equals("HOD")) {
                    response.sendRedirect("hodDashboard.jsp");

                } else if (role.equals("PRINCIPAL")) {
                    response.sendRedirect("principalDashboard.jsp");
                }

            } else {
                response.getWriter().println("Invalid email or password.");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }
}