<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.chefproject.Day14.DBConnection" %>

<%
    Object custObj = session.getAttribute("customerId");
    if (custObj == null) {
        response.sendRedirect("Login.html");
        return;
    }

    int customerId = Integer.parseInt(custObj.toString());

    String name = "", email = "", contact = "", address = "", password = "";

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DBConnection.connect();
        ps = con.prepareStatement("SELECT * FROM customer WHERE cid = ?");
        ps.setInt(1, customerId);
        rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            contact = rs.getString("contact");
            address = rs.getString("address");
            password = rs.getString("password");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (con != null) try { con.close(); } catch (Exception e) {}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit My Details</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f4f8;
            padding: 40px;
        }

        h2 {
            text-align: center;
            color: #1e40af;
            margin-bottom: 30px;
        }

        form {
            max-width: 500px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .btn {
            width: 100%;
            background: #3b82f6;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
        }

        .btn:hover {
            background: #2563eb;
        }

        .back-btn {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #4f46e5;
        }

        .back-btn:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>👤 Edit My Details</h2>

<form action="UpdateCustomerDetails" method="post">
    <input type="hidden" name="cid" value="<%= customerId %>">

    <label for="name">Name</label>
    <input type="text" id="name" name="name" required value="<%= name %>">

    <label for="email">Email</label>
    <input type="email" id="email" name="email" required value="<%= email %>">

    <label for="contact">Contact</label>
    <input type="text" id="contact" name="contact" value="<%= contact %>">

    <label for="address">Address</label>
    <textarea id="address" name="address"><%= address %></textarea>
    
    <label for="password">Password</label>
    <input type="text" id="password" name="password" value="<%= password %>">

    <button type="submit" class="btn">💾 Save Changes</button>
</form>

<a class="back-btn" href="customerdashboard.jsp">← Back to Dashboard</a>

</body>
</html>
