<%@ page import="java.sql.*, com.chefproject.Day14.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    response.setContentType("text/html;charset=UTF-8");
    response.setCharacterEncoding("UTF-8");

    // ✅ Get UID from URL parameter (admin edits)
    String uidParam = request.getParameter("uid");
    if (uidParam == null) {
        response.sendRedirect("managechefs.jsp");
        return;
    }

    int uid = Integer.parseInt(uidParam);
    String name = "", email = "", contact = "", cuisine = "", experience = "", status = "";

    try {
        Connection con = DBConnection.connect();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM chef_user WHERE uid = ?");
        ps.setInt(1, uid);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("uname");
            email = rs.getString("uemail");
            contact = rs.getString("ucontact");
            cuisine = rs.getString("cuisine");
            experience = rs.getString("experience");
            status = rs.getString("status");
        }

        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Edit Chef | ChefConnect Admin</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary: #4f46e5;
      --accent: #38bdf8;
      --bg: rgba(255, 255, 255, 0.15);
      --border: rgba(255, 255, 255, 0.2);
      --text-dark: #0f172a;
    }

    body {
      min-height: 100vh;
      background: url('chef-bg.jpg') no-repeat center center/cover;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
      backdrop-filter: blur(3px);
      font-family: 'Poppins', sans-serif;
    }

    .edit-form {
      background: var(--bg);
      border: 1px solid var(--border);
      backdrop-filter: blur(12px);
      padding: 40px 30px;
      border-radius: 20px;
      width: 100%;
      max-width: 500px;
      color: var(--text-dark);
      box-shadow: 0 8px 30px rgba(0,0,0,0.1);
    }

    h2 {
      text-align: center;
      margin-bottom: 28px;
      color: var(--primary);
    }

    label {
      display: block;
      margin-top: 14px;
      font-weight: 500;
    }

    input, select {
      width: 100%;
      padding: 12px 14px;
      margin-top: 6px;
      margin-bottom: 16px;
      border-radius: 10px;
      border: 1px solid #ccc;
      background: rgba(255, 255, 255, 0.5);
      font-size: 0.95rem;
    }

    input:focus, select:focus {
      border-color: var(--accent);
      background: rgba(255, 255, 255, 0.8);
      box-shadow: 0 0 0 3px rgba(56, 189, 248, 0.2);
      outline: none;
    }

    button {
      width: 100%;
      padding: 12px;
      background-color: var(--primary);
      color: white;
      font-weight: 600;
      border: none;
      border-radius: 12px;
      font-size: 1rem;
      cursor: pointer;
      margin-top: 16px;
    }

    button:hover {
      background-color: #4338ca;
    }

    .back-link {
      text-align: center;
      margin-top: 16px;
      font-size: 0.9rem;
    }

    .back-link a {
      color: var(--primary);
      text-decoration: none;
    }

    .back-link a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

  <form class="edit-form" action="UpdateChefDetails" method="POST">
    <h2>✏️ Edit Chef Details</h2>

    <!-- Hidden UID -->
    <input type="hidden" name="uid" value="<%= uid %>">

    <label for="name">Full Name</label>
    <input type="text" id="name" name="name" value="<%= name %>" required>

    <label for="email">Email</label>
    <input type="email" id="email" name="email" value="<%= email %>" required>

    <label for="contact">Contact</label>
    <input type="tel" id="contact" name="contact" value="<%= contact %>" required>

    <label for="cuisine">Cuisine Speciality</label>
    <input type="text" id="cuisine" name="cuisine" value="<%= cuisine %>" required>

    <label for="experience">Experience (Years)</label>
    <input type="number" id="experience" name="experience" min="0" value="<%= experience %>" required>

    <label for="status">Approval Status</label>
    <select id="status" name="status" required>
      <option value="PENDING" <%= "PENDING".equals(status) ? "selected" : "" %>>⏳ Pending</option>
      <option value="APPROVED" <%= "APPROVED".equals(status) ? "selected" : "" %>>✅ Approved</option>
      <option value="REJECTED" <%= "REJECTED".equals(status) ? "selected" : "" %>>❌ Rejected</option>
    </select>

    <button type="submit">Update Chef</button>

    <div class="back-link">
      <a href="managechefs.jsp">← Back to Manage Chefs</a>
    </div>
  </form>

</body>
</html>
