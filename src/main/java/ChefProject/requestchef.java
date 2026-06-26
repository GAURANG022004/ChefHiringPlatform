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

public class requestchef extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            int chefId = Integer.parseInt(request.getParameter("chefId"));

            String eventDate = request.getParameter("eventDate");
            String location = request.getParameter("location");
            String notes = request.getParameter("notes");

            try (Connection con = DBConnection.connect();
                 PreparedStatement ps = con.prepareStatement(
                         "INSERT INTO bookings (customer_id, chef_id, event_date, location, notes, status) VALUES (?, ?, ?, ?, ?, ?)")) {

                ps.setInt(1, customerId);
                ps.setInt(2, chefId);
                ps.setString(3, eventDate);
                ps.setString(4, location);
                ps.setString(5, notes);
                ps.setString(6, "PENDING");

                int result = ps.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("customerdashboard.jsp");
                } else {
                    response.getWriter().println("Booking failed. Please try again.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(response.getWriter());

        } catch (NumberFormatException e) {
            PrintWriter out = response.getWriter();
            out.println(" Invalid input. Make sure all IDs are numbers.");
        }
    }
}