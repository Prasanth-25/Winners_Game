package winners.game.login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import winners.game.connection.DBConnection;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		DBConnection dbconnection = new DBConnection();
		try {
			Connection con = dbconnection.getConnection();
			Statement statement = con.createStatement();
			
			String email = request.getParameter("loginEmail");
			String password = request.getParameter("loginPassword");
			
			String sqlQuery = "select Email, Password, User_Type from userdata";
			ResultSet rs = statement.executeQuery(sqlQuery);
			while(rs.next()) {
				if(rs.getString(1).equalsIgnoreCase(email)) {
					if(rs.getString(2).equals(password)) {
						response.sendRedirect(rs.getString(3)+".jsp");
						break;
					}else {
						System.out.println("Password Wrong");
					}
				}else {
					System.out.println("Username wrong");
				}
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
