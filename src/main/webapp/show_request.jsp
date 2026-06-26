<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.chefproject.Day14.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chef Requests | Admin Panel</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap"
	rel="stylesheet">
<style>
:root {
	--primary: #4f46e5;
	--accent: #38bdf8;
	--bg: #f1f5f9;
	--dark: #1e293b;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

body {
	display: flex;
	background: var(--bg);
	color: var(--dark);
}

.sidebar {
	width: 240px;
	background: var(--primary);
	color: #fff;
	height: 100vh;
	position: fixed;
	padding: 30px 20px;
}

.sidebar a {
	display: block;
	color: #fff;
	text-decoration: none;
	padding: 10px 14px;
	margin: 12px 0;
	border-radius: 10px;
	transition: .3s;
}

.sidebar a:hover, .sidebar a.active {
	background: rgba(255, 255, 255, .1);
}

.sidebar h2 {
	margin-bottom: 40px
}

.main {
	margin-left: 260px;
	padding: 40px 50px;
	flex: 1;
}

.table-section {
	background: #fff;
	padding: 20px;
	border-radius: 12px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, .06)
}

table {
	width: 100%;
	border-collapse: collapse;
	font-family: Arial, sans-serif;
	box-shadow: 0 4px 8px rgba(0, 0, 0, .08)
}

th, td {
	padding: 12px 15px;
	border: 1px solid #ccc;
	text-align: center
}

th {
	background: var(--primary);
	color: #fff
}

tr:nth-child(even) {
	background: #f9f9f9
}

.btn {
	padding: 6px 12px;
	border: none;
	border-radius: 6px;
	font-size: .9rem;
	color: #fff;
	cursor: pointer
}

.approve {
	background: #16a34a
}

.reject {
	background: #dc2626
}

.approved-tag {
	background: #22c55e;
	border: none;
	padding: 6px 12px;
	border-radius: 6px;
	color: white;
}

.rejected-tag {
	background: #ef4444;
	border: none;
	padding: 6px 12px;
	border-radius: 6px;
	color: white;
}

.edit-btn {
	background-color: #0ea5e9;
}
</style>
</head>
<body>

	<!-- Sidebar -->
	<div class="sidebar">
		<h2>ChefConnect</h2>
		<a href="admindashboard.jsp">🏠 Dashboard</a>
		<a href="managechefs.jsp">👨‍🍳 Manage Chefs</a>
		<a href="chefviewrequests.jsp">🧑‍💼 Customers</a>
		<a href="show_request.jsp" class="active">📅 Requests</a>
		<a href="#">⚙️ Settings</a>
		<a href="Login.html">🚪 Logout</a>
	</div>

	<!-- Main Content -->
	<div class="main">
		<h1>Chef Approval Requests</h1>

		<div class="table-section">
			<table>
				<tr>
					<th>Chef Name</th>
					<th>Email</th>
					<th>Contact</th>
					<th>Status</th>
					<th>Actions</th>
					<th>Delete</th>
				</tr>

				<%
				try {
					Connection con = DBConnection.connect();
					PreparedStatement ps = con.prepareStatement("SELECT uid, uname, uemail, ucontact, status AS chef_status FROM chef_user");

					ResultSet rs = ps.executeQuery();

					while (rs.next()) {
						String status = rs.getString("chef_status");
						int uid = rs.getInt("uid");
				%>
				<tr>
					<td><%= rs.getString("uname") %></td>
					<td><%= rs.getString("uemail") %></td>
					<td><%= rs.getString("ucontact") %></td>
					<td><%= status %></td>

					<td>
						<%
						if ("PENDING".equalsIgnoreCase(status)) {
						%>
						<form action="chefapproval" method="post" style="display:inline;">
							<input type="hidden" name="uid" value="<%= uid %>">
							<button class="btn approve" name="action" value="approve">Approve</button>
						</form>
						<form action="chefreject" method="post" style="display:inline;">
							<input type="hidden" name="uid" value="<%= uid %>">
							<button class="btn reject" name="action" value="reject">Reject</button>
						</form>
						<%
						} else if ("APPROVED".equalsIgnoreCase(status)) {
						%>
						<span class="approved-tag">Approved</span>
						<%
						} else if ("REJECTED".equalsIgnoreCase(status)) {
						%>
						<span class="rejected-tag">Rejected</span>
						<%
						}
						%>

					</td>

					<td>
						<form action="delete" method="post">
							<input type="hidden" name="uid" value="<%= uid %>">
							<button class="btn reject" type="submit">🗑 Delete</button>
						</form>
					</td>
				</tr>
				<%
					}
					rs.close();
					ps.close();
					con.close();
				} catch (Exception e) {
					out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
				}
				%>
			</table>
		</div>
	</div>

</body>
</html>
