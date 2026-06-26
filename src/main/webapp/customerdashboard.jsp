<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
  HttpSession customerSession = request.getSession(false);
  String customerName = (String) customerSession.getAttribute("customerName");
  if (customerName == null) {
    response.sendRedirect("login.jsp"); // Redirect if not logged in
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Customer Dashboard | ChefConnect</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet" />
  <style>
    :root {
      --primary: #4f46e5;
      --accent: #38bdf8;
      --bg: #f1f5f9;
      --dark: #1e293b;
      --light: #fff;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Poppins', sans-serif;
    }

    body {
      display: flex;
      min-height: 100vh;
      background-color: var(--bg);
    }

    .sidebar {
      width: 220px;
      background: var(--primary);
      color: #fff;
      height: 100vh;
      padding: 30px 20px;
      position: fixed;
    }

    .sidebar h2 {
      font-size: 22px;
      margin-bottom: 40px;
    }

    .sidebar a {
      display: block;
      color: #fff;
      text-decoration: none;
      margin: 15px 0;
      padding: 10px 14px;
      border-radius: 10px;
      transition: background 0.3s;
    }

    .sidebar a:hover,
    .sidebar a.active {
      background-color: rgba(255, 255, 255, 0.1);
    }

    .main {
      margin-left: 240px;
      padding: 40px 50px;
      flex: 1;
    }

    .main h1 {
      font-size: 28px;
      margin-bottom: 20px;
      color: var(--primary);
    }

    .card-container {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 20px;
    }

    .card {
      background-color: var(--light);
      border-radius: 16px;
      padding: 20px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.07);
    }

    .card h3 {
      font-size: 18px;
      margin-bottom: 10px;
      color: var(--dark);
    }

    .card p {
      font-size: 14px;
      color: #555;
    }

    .logout-btn {
      display: inline-block;
      background: #ef4444;
      padding: 10px 16px;
      color: white;
      border-radius: 8px;
      text-decoration: none;
      margin-top: 30px;
    }

    .logout-btn:hover {
      background: #dc2626;
    }
  </style>
</head>
<body>

  <!-- Sidebar -->
  <div class="sidebar">
    <h2>🧑‍💼 Customer Panel</h2>
    <a href="#" class="active">🏠 Dashboard</a>
    <a href="chefbooking.jsp">📅 My Bookings</a>
    <a href="requestchef.jsp">🍽️ Request Chef</a>
    <a href="editcustomer.jsp">🔑 Change Password</a>
    <a href="Login.html">🚪 Logout</a>
  </div>

  <!-- Main Content -->
  <div class="main">
    <h1>Welcome, <%= customerName %> 👋</h1>

    <div class="card-container">
      <div class="card">
        <h3>📅 Upcoming Events</h3>
        <p>You have 2 events scheduled this month.</p>
      </div>

      <div class="card">
        <h3>🧑‍🍳 Your Requests</h3>
        <p>1 request is pending chef confirmation.</p>
      </div>

      <div class="card">
        <h3>⭐ Feedbacks</h3>
        <p>You have submitted 3 chef reviews.</p>
      </div>

      <div class="card">
        <h3>🔄 Last Booking</h3>
        <p>Chef Rahul, Italian Cuisine — on 12 July 2025</p>
      </div>
    </div>

    <a class="logout-btn" href="Login.html">Logout</a>
  </div>

</body>
</html>
