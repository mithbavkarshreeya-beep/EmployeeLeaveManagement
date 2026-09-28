# Employee Leave Management System

A web-based Employee Leave Management System developed using Java, JSP, Servlets, MySQL, and JDBC.

## Features

- Employee login
- Employee dashboard
- Leave balance management
- Apply for leave
- Charge handover details
- Leave history
- HOD leave approval/rejection
- Principal final approval/rejection
- Automatic leave balance update after final approval
- Role-based dashboards

## Technologies Used

- Java
- JSP
- Servlets
- HTML
- CSS
- MySQL
- JDBC
- Apache Tomcat
- Eclipse IDE

## User Roles

### Employee
- View leave balance
- Apply for leave
- View leave history

### HOD
- View leave requests from the department
- Approve or reject leave requests

### Principal
- Review HOD-approved requests
- Give final approval or rejection
- Approving a leave updates the employee's leave balance

## Project Structure

```text
EmployeeLeaveManagement
├── src/main/java
│   ├── com.employeeleave.controller
│   └── com.employeeleave.dao
│
├── src/main/webapp
│   ├── css
│   ├── login.jsp
│   ├── employeeDashboard.jsp
│   ├── applyLeave.jsp
│   ├── leaveHistory.jsp
│   ├── hodDashboard.jsp
│   └── principalDashboard.jsp
│
└── README.md