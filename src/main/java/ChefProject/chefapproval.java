package ChefProject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class chefapproval extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uid = request.getParameter("uid");

        if (uid == null || uid.trim().isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }

        int userId = Integer.parseInt(uid);

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(
                     "UPDATE chef_user SET status = 'APPROVED' WHERE uid = ?")) {

            ps.setInt(1, userId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("Chef approved successfully.");
                response.sendRedirect("show_request.jsp");
            } else {
                System.out.println("Chef approval failed.");
                response.sendRedirect("error.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}