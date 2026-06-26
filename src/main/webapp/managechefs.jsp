<%@ page import="java.sql.*, com.chefproject.Day14.*" %> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Chefs | Admin Panel</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      padding: 30px;
      background-color: #f5f7fa;
    }

    h1 {
      color: #333;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
      background: #fff;
    }

    th, td {
      padding: 12px 15px;
      border: 1px solid #ccc;
      text-align: center;
    }

    th {
      background-color: #4f46e5;
      color: white;
    }

    a.btn {
      text-decoration: none;
      padding: 8px 12px;
      background-color: #3b82f6;
      color: white;
      border-radius: 6px;
    }

    a.btn:hover {
      background-color: #2563eb;
    }

    .add-btn {
      display: inline-block;
      background: #10b981;
      padding: 10px 14px;
      color: white;
      border-radius: 8px;
      text-decoration: none;
      margin-bottom: 20px;
    }

    .add-btn:hover {
      background: #059669;
    }
  </style>
</head>
<body>

<h1>👨‍🍳 Manage Chefs</h1>

<a class="add-btn" href="chefregister.html">➕ Register New Chef</a>
<a class="add-btn" href="admindashboard.jsp">← Go to Home page..</a>

<table>
  <tr>
    <th>ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Contact</th>
    <th>Cuisine</th>
    <th>Status</th>
    <th>Actions</th>
  </tr>

<%
  try {
    Connection con = DBConnection.connect();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM chef_user");
    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
      int id = rs.getInt("uid");
      String status = rs.getString("status"); // 🔁 Fetch updated status
%>

  <tr>
    <td><%= id %></td>
    <td><%= rs.getString("uname") %></td>
    <td><%= rs.getString("uemail") %></td>
    <td><%= rs.getString("ucontact") %></td>
    <td><%= rs.getString("cuisine") %></td>
    <td><%= status != null ? status : "PENDING" %></td>  <!-- Show status -->
    <td>
      <a class="btn" href="editchef.jsp?uid=<%= id %>">✏️ Edit</a>
      <a class="btn" href="delete?uid=<%= id %>" onclick="return confirm('Are you sure you want to delete this chef?')">🗑️ Delete</a>
    </td>
  </tr>

<%
    }

    rs.close();
    ps.close();
    con.close();
  } catch (Exception e) {
    out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
  }
%>

</table>

</body>
</html>
