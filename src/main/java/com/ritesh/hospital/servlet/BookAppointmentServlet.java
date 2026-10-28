
package com.ritesh.hospital.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.time.ZoneId;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ritesh.hospital.DBConnection;

@WebServlet("/book-appointment")
public class BookAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String patient = request.getParameter("patient");
        String doctor = request.getParameter("doctor");
        String apptDate = request.getParameter("appt_date");

        // Validate form fields
        if (patient == null || patient.trim().isEmpty()
                || doctor == null || doctor.trim().isEmpty()
                || apptDate == null || apptDate.trim().isEmpty()) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Please enter patient name, doctor, and appointment date."
            );
            return;
        }

        try {
            // Convert the submitted date
            LocalDate appointmentDate = LocalDate.parse(apptDate);

            // Get today's date using India time
            LocalDate today = LocalDate.now(
                ZoneId.of("Asia/Kolkata")
            );

            // Reject past dates
            if (appointmentDate.isBefore(today)) {
                response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Appointment date cannot be in the past. "
                    + "Please select today or a future date."
                );
                return;
            }

            // SQL query
            String sql = "INSERT INTO appointment "
                       + "(patient, doctor, appt_date) "
                       + "VALUES (?, ?, ?)";

            // Connect and save appointment
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, patient.trim());
                ps.setString(2, doctor.trim());
                ps.setDate(3, Date.valueOf(appointmentDate));

                int rowsInserted = ps.executeUpdate();

                if (rowsInserted > 0) {
                    response.sendRedirect(
                        request.getContextPath()
                        + "/today-appointments?booked=1"
                    );
                } else {
                    response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Appointment could not be saved."
                    );
                }
            }

        } catch (java.time.format.DateTimeParseException e) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid appointment date. Please select a valid date."
            );

        } catch (java.sql.SQLException e) {
            throw new ServletException(
                "Database error while booking appointment. "
                + "Check MySQL connection, credentials, and table.",
                e
            );
        }
    }
}
