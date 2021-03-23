package winners.game.registation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import winners.game.connection.DBConnection;

/**
 * Servlet implementation class RegistrationServlet
 */
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistrationServlet() {
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
			
			String designation = request.getParameter("designationValue");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String profileName = request.getParameter("profileName");
			String mobileNumber = request.getParameter("mobileNumber");
			
			String sqlQuery = "Insert into userdata values ('"+ profileName + "','" + email + "','" + mobileNumber + "','" + password + "','" + designation + "', 'no')";
			int queryResult = statement.executeUpdate(sqlQuery);
			if(queryResult>0) {
				System.out.println("Records Has been Inserted Successfully..");
				response.sendRedirect("RegisterSuccess.html");
			}else {
				System.out.println("No Records Has been Inserted..");
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
