package ChefProject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class chefregister extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String password = request.getParameter("password");
        String cuisine = request.getParameter("cuisine");
        String experience = request.getParameter("experience");

        if (name == null || email == null || contact == null
                || password == null || experience == null) {
            response.sendRedirect("Error.html");
            return;
        }

        int exp = Integer.parseInt(experience);

        String sql = "INSERT INTO chef_user "
                + "(uname, ucontact, uemail, upassword, cuisine, experience, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, 'PENDING')";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, contact);
            ps.setString(3, email);
            ps.setString(4, password);
            ps.setString(5, cuisine);
            ps.setInt(6, exp);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("Login.html");
            } else {
                response.sendRedirect("Error.html");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("Error.html");
        }
    }
}