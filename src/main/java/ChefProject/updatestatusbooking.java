package ChefProject;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class updatestatusbooking extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String bookingId = request.getParameter("bookingId");

        if (bookingId == null || action == null
                || bookingId.isEmpty() || action.isEmpty()) {

            response.getWriter().println("Invalid request.");
            return;
        }

        int id = Integer.parseInt(bookingId);

        try (Connection con = DBConnection.connect()) {

            String sql = "UPDATE bookings SET status = ? WHERE id = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, action.toUpperCase());
            ps.setInt(2, id);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("chefbooking.jsp");
            } else {
                response.getWriter().println("Update failed. Booking ID may not exist.");
            }

        } catch (SQLException e) {

            e.printStackTrace();

            PrintWriter out = response.getWriter();
            out.println("Error: " + e.getMessage());
        }
    }
}