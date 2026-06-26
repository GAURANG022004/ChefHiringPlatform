package ChefProject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class delete extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public delete() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.getWriter()
                .append("Served at: ")
                .append(request.getContextPath());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uid = request.getParameter("uid");
        int id = Integer.parseInt(uid);

        try {
            Connection con = DBConnection.connect();

            String sql = "delete from chef_user where uid = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("admindashboard.jsp");
                System.out.println("Delete succesfully...");
            } else {
                response.sendRedirect("error.html");
                System.out.println("Delete Error...");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}