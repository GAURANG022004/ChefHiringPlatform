<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.chefproject.Day14.*" %>

<%
  // Get UID from session
  Integer uid = (Integer) session.getAttribute("chef_uid");
  if (uid == null) {
    response.sendRedirect("Login.html"); // Redirect if not logged in
    return;
  } 

  int upcomingCount = 0;
  int requestCount = 0;
  String statusText = "PENDING";

  Connection con = null;
  PreparedStatement ps1 = null;
  PreparedStatement ps2 = null;
  ResultSet rs1 = null;
  ResultSet rs2 = null;

  try {
    con = DBConnection.connect();

    // ✅ Count upcoming bookings
    ps1 = con.prepareStatement("SELECT COUNT(*) FROM bookings WHERE chef_id = ? AND event_date >= CURDATE()");
    ps1.setInt(1, uid);
    rs1 = ps1.executeQuery();
    if (rs1.next()) {
      upcomingCount = rs1.getInt(1);
    }

    // ✅ Count pending requests
    ps2 = con.prepareStatement("SELECT COUNT(*) FROM bookings WHERE chef_id = ? AND status = ?");
    ps2.setInt(1, uid);
    ps2.setString(2, statusText);
    rs2 = ps2.executeQuery();
    if (rs2.next()) {
      requestCount = rs2.getInt(1);
    }

  } catch (Exception e) {
    out.println("Error: " + e.getMessage());
  } finally {
    try { if (rs1 != null) rs1.close(); } catch (Exception e) {}
    try { if (rs2 != null) rs2.close(); } catch (Exception e) {}
    try { if (ps1 != null) ps1.close(); } catch (Exception e) {}
    try { if (ps2 != null) ps2.close(); } catch (Exception e) {}
    try { if (con != null) con.close(); } catch (Exception e) {}
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Chef Dashboard | ChefConnect</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap"
	rel="stylesheet" />
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

.sidebar a, .sidebar form button {
	display: block;
	width: 100%;
	color: #fff;
	background: transparent;
	border: none;
	margin: 15px 0;
	padding: 10px 14px;
	border-radius: 10px;
	text-align: left;
	font-size: 16px;
	cursor: pointer;
	transition: background 0.3s;
}

.sidebar a:hover, .sidebar a.active, .sidebar form button:hover {
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
		<h2>👨‍🍳 Chef Panel</h2>
		<a href="#" class="active">🏠 Dashboard</a>

		<!-- Edit Profile button -->
		<form action="editchef.jsp" method="get">
			<input type="hidden" name="uid" value="<%=uid%>">
			<button type="submit">✏️ Edit Profile</button>
		</form>

		<form action="chefbooking.jsp" method="get">
			<input type="hidden" name="uid" value="<%=uid%>">
			<button type="submit">📅 My Bookings</button>
		</form>

		<form action="chefviewrequests.jsp" method="get">
			<input type="hidden" name="uid" value="<%=uid%>">
			<button type="submit">📝 Requests</button>
		</form>

		<form action="Login.html" method="get">
			<input type="hidden" name="uid" value="<%=uid%>">
			<button type="submit">🚪 Logout</button>
		</form>

	</div>

	<!-- Main Content -->
	<div class="main">
		<h1>Welcome, Chef! 👋</h1>

		<div class="card">
			<h3>📅 Upcoming Bookings</h3>
			<p>
				You have <strong><%=upcomingCount%></strong> bookings scheduled.
			</p>
		</div>

		<div class="card">
			<h3>🧾 New Requests</h3>
			<p>
				<strong><%=requestCount%></strong> clients have sent you event
				requests.
			</p>
		</div>



		<div class="card">
			<h3>👤 Profile Status</h3>
			<p>
				Your profile is <strong>APPROVED</strong>.
			</p>
		</div>


		<a class="logout-btn" href="Login.html">Logout</a>
	</div>

</body>
</html>
