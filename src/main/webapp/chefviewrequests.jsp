<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.chefproject.Day14.DBConnection" %>

<%
    Object chefIdObj = session.getAttribute("chef_uid");
    if (chefIdObj == null) {
        response.sendRedirect("Login.html");
        return;
    }
    int chefId = Integer.parseInt(chefIdObj.toString());
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Chef Request Details</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: #f0f4f8;
      padding: 30px;
    }

    h1 {
      text-align: center;
      color: #0f172a;
      margin-bottom: 30px;
    }

    .top-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .back-link {
      text-decoration: none;
      font-weight: 500;
      color: #4f46e5;
      background-color: #e0e7ff;
      padding: 8px 14px;
      border-radius: 6px;
      transition: 0.3s;
    }

    .back-link:hover {
      background-color: #c7d2fe;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: white;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }

    th, td {
      padding: 14px;
      text-align: center;
    }

    th {
      background-color: #4f46e5;
      color: white;
    }

    tr:nth-child(even) {
      background-color: #f1f5f9;
    }

    tr:hover {
      background-color: #e0e7ff;
    }

    .note-cell {
      text-align: left;
    }
  </style>
</head>
<body>

<div class="top-bar">
  <h1>🧾 Customer Request Details</h1>
  <a class="back-link" href="chefdashboard.jsp">🔙 Back to Dashboard</a>
</div>

<table>
  <tr>
    <th>Booking ID</th>
    <th>Customer Name</th>
    <th>Event Date</th>
    <th>Location</th>
    <th>Notes</th>
    <th>Status</th>
  </tr>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    con = DBConnection.connect();

    ps = con.prepareStatement(
        "SELECT b.id, b.event_date, b.location, b.notes, b.status, c.name " +
        "FROM bookings b " +
        "JOIN customer c ON b.customer_id = c.cid " +
        "WHERE b.chef_id = ?"
    );
    ps.setInt(1, chefId);
    rs = ps.executeQuery();

    while (rs.next()) {
%>
  <tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("event_date") %></td>
    <td><%= rs.getString("location") %></td>
    <td class="note-cell"><%= rs.getString("notes") %></td>
    <td><%= rs.getString("status") %></td>
  </tr>
<%
    }
} catch (Exception e) {
    out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
} finally {
    if (rs != null) try { rs.close(); } catch (Exception e) {}
    if (ps != null) try { ps.close(); } catch (Exception e) {}
    if (con != null) try { con.close(); } catch (Exception e) {}
}
%>

</table>

</body>
</html>
