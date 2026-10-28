
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.ritesh.hospital.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Today's Appointments | CarePlus</title>

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f3f7fb;
            color: #1e293b;
        }

        header {
            background: #087f8c;
            color: white;
            padding: 22px 8%;
        }

        header h1 { margin: 0; }

        main {
            max-width: 1000px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 20px #0000000d;
            overflow-x: auto;
        }

        .success {
            background: #dcfce7;
            color: #166534;
            padding: 14px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 14px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        th {
            background: #e6f7f7;
            color: #075985;
        }

        .button {
            display: inline-block;
            margin-top: 22px;
            padding: 12px 18px;
            background: #087f8c;
            color: white;
            text-decoration: none;
            border-radius: 7px;
        }

        .empty { color: #64748b; padding: 20px 0; }

        .error { color: #b91c1c; }

        @media (max-width: 600px) {
            th, td { padding: 10px; font-size: 13px; }
        }
    </style>
</head>

<body>
<header>
    <h1>CarePlus Hospital</h1>
    <p>Today's Patient Appointments</p>
</header>

<main>
    <section class="card">
        <% if ("1".equals(request.getParameter("booked"))) { %>
            <div class="success">
                Appointment booked successfully!
            </div>
        <% } %>

        <h2>Today's Appointments</h2>
        <p>Appointments scheduled for the current database date.</p>

        <%
            String sql = "SELECT id, patient, doctor, appt_date "
                       + "FROM appointment "
                       + "WHERE appt_date = CURDATE() "
                       + "ORDER BY id DESC";

            boolean hasRecords = false;

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
        %>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Patient Name</th>
                    <th>Doctor</th>
                    <th>Appointment Date</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) {
                       hasRecords = true;
                %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("patient") %></td>
                        <td><%= rs.getString("doctor") %></td>
                        <td><%= rs.getDate("appt_date") %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <% if (!hasRecords) { %>
            <p class="empty">No appointments scheduled for today.</p>
        <% } %>

        <%
            } catch (Exception e) {
                application.log("Unable to load today's appointments.", e);
        %>
            <p class="error">
                Unable to load appointments. Check the database connection
                and server logs.
            </p>
        <% } %>

        <a class="button" href="index.jsp">+ Book Appointment</a>
    </section>
</main>
</body>
</html>
