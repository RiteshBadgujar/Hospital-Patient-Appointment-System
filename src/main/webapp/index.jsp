
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CarePlus | Hospital Appointment</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f3f7fb;
            color: #1e293b;
        }

        header {
            background: #ffffff;
            padding: 20px 8%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 12px #0000000d;
        }

        .logo {
            color: #087f8c;
            font-size: 25px;
            font-weight: bold;
        }

        nav a {
            text-decoration: none;
            color: #334155;
            margin-left: 24px;
            font-size: 14px;
        }

        .hero {
            background: linear-gradient(120deg, #087f8c, #16a6a1);
            color: white;
            padding: 55px 8%;
        }

        .hero h1 {
            font-size: 36px;
            margin-bottom: 14px;
        }

        .hero p {
            max-width: 560px;
            line-height: 1.7;
            color: #e6fffb;
        }

        main {
            max-width: 1000px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .appointment-card {
            background: white;
            padding: 32px;
            border-radius: 16px;
            box-shadow: 0 8px 30px #0f172a0d;
        }

        .appointment-card h2 {
            margin-bottom: 10px;
            color: #0f3f50;
        }

        .subtitle {
            color: #64748b;
            margin-bottom: 28px;
            font-size: 14px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 22px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 9px;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        label {
            font-size: 14px;
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 13px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
            background: white;
        }

        input:focus, select:focus {
            outline: 2px solid #99e4df;
            border-color: #087f8c;
        }

        button {
            background: #087f8c;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 26px;
            width: 100%;
        }

        button:hover {
            background: #066874;
        }

        footer {
            text-align: center;
            padding: 25px;
            color: #64748b;
            font-size: 13px;
        }

        @media (max-width: 600px) {
            header {
                padding: 18px 5%;
            }

            nav a {
                margin-left: 10px;
                font-size: 12px;
            }

            .hero h1 {
                font-size: 28px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .full-width {
                grid-column: auto;
            }

            .appointment-card {
                padding: 22px;
            }
        }
    </style>
</head>

<body>

<header>
    <div class="logo">CarePlus</div>
    <nav>
        <a href="index.jsp">Home</a>
        <a href="todayAppointments.jsp">Today's Appointments</a>
    </nav>
</header>

<section class="hero">
    <h1>Your Health, Our Priority</h1>
    <p>
        Book your hospital appointment easily.
        Choose your doctor and preferred date to get started.
    </p>
</section>

<main>
    <section class="appointment-card">
        <h2>Book an Appointment</h2>
        <p class="subtitle">
            Enter your details below to schedule your visit.
        </p>

        <form action="book-appointment" method="post"
              onsubmit="return validate()">

            <div class="form-grid">

                <div class="form-group">
                    <label for="patient">Patient Name</label>
                    <input type="text" id="patient" name="patient"
                           placeholder="Enter full name"
                           maxlength="100" required>
                </div>

                <div class="form-group">
                    <label for="doctor">Select Doctor</label>
                    <select id="doctor" name="doctor" required>
                        <option value="">Choose a doctor</option>
                        <option value="Dr. Sharma">Dr. Sharma</option>
                        <option value="Dr. Joshi">Dr. Joshi</option>
                        <option value="Dr. Kulkarni">Dr. Kulkarni</option>
                    </select>
                </div>

                <div class="form-group full-width">
                    <label for="appt_date">Appointment Date</label>
                    <input type="date" id="appt_date"
                           name="appt_date" required>
                </div>

            </div>

            <button type="submit">Book Appointment</button>
        </form>
    </section>
</main>

<footer>
    © 2026 CarePlus Hospital Appointment System
</footer>

<script>
    // Prevent selecting past dates in the browser.
    const dateInput = document.getElementById("appt_date");
    const today = new Date();
    const localToday = [
        today.getFullYear(),
        String(today.getMonth() + 1).padStart(2, "0"),
        String(today.getDate()).padStart(2, "0")
    ].join("-");

    dateInput.min = localToday;

    function validate() {
        const patient = document.getElementById("patient").value.trim();
        const doctor = document.getElementById("doctor").value;
        const date = dateInput.value;

        if (!patient || !doctor || !date) {
            alert("Please complete all fields.");
            return false;
        }

        if (date < localToday) {
            alert("Please select today or a future date.");
            return false;
        }

        return true;
    }
</script>

</body>
</html>
