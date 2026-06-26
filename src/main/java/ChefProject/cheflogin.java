package ChefProject;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class cheflogin extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = request.getParameter("role");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        try (Connection con = DBConnection.connect()) {

            // Admin Login
            if ("admin".equals(role)) {

                if ("admin@gmail.com".equals(email) && "1234".equals(password)) {
                    session.setAttribute("admin", "AdminUser");
                    response.sendRedirect("admindashboard.jsp");
                } else {
                    out.println("Invalid admin credentials");
                }

            }
            // Chef Login
            else if ("chef".equals(role)) {

                String sql = "SELECT * FROM chef_user WHERE uemail = ? AND upassword = ? AND status = 'APPROVED'";

                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, email);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {

                    session.setAttribute("chefName", rs.getString("uname"));
                    session.setAttribute("chef_uid", rs.getInt("uid"));

                    response.sendRedirect("chefdashboard.jsp");

                } else {

                    out.println("Invalid chef credentials or not approved yet.");
                    response.sendRedirect("Login.html");

                }

            }
            // Customer Login
            else if ("customer".equals(role)) {

                String sql = "SELECT * FROM customer WHERE email = ? AND password = ?";

                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, email);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {

                    session.setAttribute("customerName", rs.getString("name"));
                    session.setAttribute("customerId", rs.getInt("cid"));

                    response.sendRedirect("customerdashboard.jsp");

                } else {

                    out.println("Invalid customer credentials.");

                }

            } else {

                out.println("Invalid role selected.");

            }

        } catch (SQLException e) {
            e.printStackTrace(out);
        }
    }
}