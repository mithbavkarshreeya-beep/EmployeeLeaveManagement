<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Apply for Leave</title>
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

        <!-- SIDEBAR -->

        <aside class="sidebar">

            <a href="employeeDashboard.jsp" class="sidebar-link">
                Dashboard
            </a>

            <a href="applyLeave.jsp" class="sidebar-link active">
                Apply Leave
            </a>

            <a href="leaveHistory.jsp" class="sidebar-link">
                Leave History
            </a>

        </aside>


        <!-- MAIN CONTENT -->

        <main class="dashboard-content">

            <div class="dashboard-welcome">

                <div>
                    <p class="eyebrow">LEAVE MANAGEMENT</p>

                    <h1>Apply for Leave</h1>

                    <p>
                        Submit your leave request and provide the required
                        handover details.
                    </p>
                </div>

            </div>


            <div class="dashboard-card leave-form-card">

                <div class="form-heading">
                    <h2>Leave Application</h2>

                    <p>
                        Please enter the details of your leave request.
                    </p>
                </div>


                <form action="ApplyLeaveServlet" method="post">


                    <!-- LEAVE TYPE -->

                    <div class="form-group">

                        <label>Leave Type</label>

                        <select name="leaveType" required>

                            <option value="">
                                -- Select Leave Type --
                            </option>

                            <option value="1">
                                Casual Leave
                            </option>

                            <option value="2">
                                Earned Leave
                            </option>

                            <option value="3">
                                Medical Leave
                            </option>

                        </select>

                    </div>


                    <!-- DATES -->

                    <div class="form-row">

                        <div class="form-group">

                            <label>From Date</label>

                            <input
                                type="date"
                                name="fromDate"
                                required
                            >

                        </div>


                        <div class="form-group">

                            <label>To Date</label>

                            <input
                                type="date"
                                name="toDate"
                                required
                            >

                        </div>

                    </div>


                    <!-- REASON -->

                    <div class="form-group">

                        <label>Reason for Leave</label>

                        <textarea
                            name="reason"
                            rows="4"
                            placeholder="Enter reason for leave"
                            required
                        ></textarea>

                    </div>


                    <!-- HANDOVER -->

                    <div class="handover-section">

                        <div class="form-heading">

                            <h2>Charge Handover</h2>

                            <p>
                                Provide the employee who will handle your
                                responsibilities during your absence.
                            </p>

                        </div>


                        <div class="form-group">

                            <label>Handover Employee Name</label>

                            <input
                                type="text"
                                name="handoverName"
                                placeholder="Enter employee name"
                            >

                        </div>


                        <div class="form-group">

                            <label>Handover Responsibilities</label>

                            <textarea
                                name="handoverNotes"
                                rows="4"
                                placeholder="Enter responsibilities to be handed over"
                            ></textarea>

                        </div>

                    </div>


                    <!-- SUBMIT -->

                    <div class="form-actions">

                        <a
                            href="employeeDashboard.jsp"
                            class="cancel-btn"
                        >
                            Cancel
                        </a>

                        <button
                            type="submit"
                            class="dashboard-action primary-action"
                        >
                            Submit Leave Application
                        </button>

                    </div>

                </form>

            </div>

        </main>

    </div>

</body>
</html>