package ChefProject;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateCustomerDetails extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        int cid = Integer.parseInt(request.getParameter("cid"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.connect();

            String sql = "UPDATE customer SET name=?, email=?, contact=?, address=? , password=? WHERE cid=?";

            ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, contact);
            ps.setString(4, address);
            ps.setString(5, password);
            ps.setInt(6, cid);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("customerdashboard.jsp");
            } else {
                response.getWriter().println(
                        "<h3 style='color:red;'>❌ Failed to update details. Please try again.</h3>");
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