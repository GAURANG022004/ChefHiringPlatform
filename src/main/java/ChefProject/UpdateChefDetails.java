package ChefProject;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateChefDetails extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int uid = Integer.parseInt(request.getParameter("uid"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String cuisine = request.getParameter("cuisine");
        String experience = request.getParameter("experience");
        String status = request.getParameter("status");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.connect();

            String sql = "UPDATE chef_user SET uname=?, uemail=?, ucontact=?, cuisine=?, experience=?, status=? WHERE uid=?";

            ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, contact);
            ps.setString(4, cuisine);
            ps.setString(5, experience);
            ps.setString(6, status);
            ps.setInt(7, uid);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("managechefs.jsp");
            } else {
                response.getWriter().println("Failed to update chef details.");
            }

        } catch (Exception e) {
            e.printStackTrace();

            PrintWriter out = response.getWriter();
            out.println("Error: " + e.getMessage());

        } finally {

            try {
                if (ps != null) {
                    ps.close();
                }

                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}