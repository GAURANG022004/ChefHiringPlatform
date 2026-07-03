package ChefProject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class customerregister extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public customerregister() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");

        try {
            Connection con = DBConnection.connect();

            String sql = "INSERT INTO customer (name, email, password, contact, address) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, contact);
            ps.setString(5, address);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("Login.html");
            } else {
                response.sendRedirect("error.html");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        
    }
}