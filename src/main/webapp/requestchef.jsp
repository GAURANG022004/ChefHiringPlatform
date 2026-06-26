<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.chefproject.Day14.*" %>
<%
  HttpSession customerSession = request.getSession(false);
  Integer customerId = (Integer) customerSession.getAttribute("customerId");
  String customerName = (String) customerSession.getAttribute("customerName");
  if (customerId == null) {
    response.sendRedirect("login.jsp");
  }

  Connection con = DBConnection.connect();
  PreparedStatement ps = con.prepareStatement("SELECT uid, uname, cuisine, experience FROM chef_user WHERE status = 'APPROVED'");
  ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Request Chef | ChefConnect</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet" />
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: #f0f4f8;
      padding: 30px;
    }

    h2 {
      color: #4f46e5;
      text-align: center;
      margin-bottom: 20px;
    }

    .form-box {
      max-width: 700px;
      margin: 0 auto;
      background: white;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    label {
      display: block;
      margin-top: 15px;
      font-weight: 500;
    }

    select, input, textarea {
      width: 100%;
      padding: 10px 12px;
      margin-top: 6px;
      border: 1px solid #ccc;
      border-radius: 10px;
      font-size: 14px;
    }

    button {
      margin-top: 20px;
      width: 100%;
      background: #4f46e5;
      color: white;
      padding: 12px;
      font-weight: bold;
      border: none;
      border-radius: 10px;
      cursor: pointer;
    }

    button:hover {
      background: #4338ca;
    }
  </style>
</head>
<body>

  <h2>Request a Chef for Your Event</h2>
  <div class="form-box">
    <form action="requestchef" method="POST">
      <input type="hidden" name="customerId" value="<%= customerId %>" />

      <label for="chefId">Select Chef</label>
      <select id="chefId" name="chefId" required>
        <option value="">-- Choose a Chef --</option>
        <% while(rs.next()) { %>
          <option value="<%= rs.getInt("uid") %>">
            <%= rs.getString("uname") %> — <%= rs.getString("cuisine") %> (Exp: <%= rs.getInt("experience") %> yrs)
          </option>
        <% } %>
      </select>

      <label for="eventDate">Event Date</label>
      <input type="date" name="eventDate" required />

      <label for="location">Event Location</label>
      <input type="text" name="location" placeholder="e.g. Pune, Maharashtra" required />

      

      <button type="submit">Submit Booking Request</button>
    </form>
  </div>

</body>
</html>
<%
  rs.close();
  ps.close();
  con.close();
%>
