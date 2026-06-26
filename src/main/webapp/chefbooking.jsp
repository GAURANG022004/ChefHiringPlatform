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
  <title>Chef Bookings</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: #f8fafc;
      margin: 0;
      padding: 30px;
    }

    .top-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    h1 {
      color: #4f46e5;
      margin-bottom: 20px;
    }

    .back-link {
      text-decoration: none;
      font-weight: 500;
      color: #4f46e5;
      background-color: #e0e7ff;
      padding: 8px 14px;
      border-radius: 6px;
      transition: 0.3s ease;
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
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    th, td {
      padding: 14px 16px;
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

    .btn {
      padding: 6px 12px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-weight: 500;
      font-size: 0.9rem;
    }

    .approve {
      background-color: #10b981;
      color: white;
    }

    .reject {
      background-color: #ef4444;
      color: white;
    }

    .pending {
      background-color: #facc15;
      color: black;
    }
  </style>
</head>
<body>

<div class="top-bar">
  <h1>📋 My Bookings</h1>
  <a class="back-link" href="chefdashboard.jsp">🔙 Back to Dashboard</a>
</div>

<table>
  <tr>
    <th>Booking ID</th>
    <th>Customer ID</th>
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
    ps = con.prepareStatement("SELECT * FROM bookings WHERE chef_id = ?");
    ps.setInt(1, chefId);
    rs = ps.executeQuery();

    while (rs.next()) {
        int bookingId = rs.getInt("id");
        int customerId = rs.getInt("customer_id");
        String eventDate = rs.getString("event_date");
        String location = rs.getString("location");
        String notes = rs.getString("notes");
        String status = rs.getString("status");
%>
  <tr>
    <td><%= bookingId %></td>
    <td><%= customerId %></td>
    <td><%= eventDate %></td>
    <td><%= location %></td>
    <td><%= notes %></td>
    <td>
      <% if ("PENDING".equalsIgnoreCase(status)) { %>
        <form action="updatestatusbooking" method="post" style="display:inline;">
          <input type="hidden" name="bookingId" value="<%= bookingId %>">
          <button class="btn approve" name="action" value="APPROVED">Approve</button>
        </form>
        <form action="updatestatusbooking" method="post" style="display:inline;">
          <input type="hidden" name="bookingId" value="<%= bookingId %>">
          <button class="btn reject" name="action" value="REJECTED">Reject</button>
        </form>
      <% } else if ("APPROVED".equalsIgnoreCase(status)) { %>
        <span class="btn approve">Approved</span>
      <% } else { %>
        <span class="btn reject">Rejected</span>
      <% } %>
    </td>
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
