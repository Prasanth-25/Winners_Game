package winners.game.metadata;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import winners.game.connection.DBConnection;

/**
 * Servlet implementation class ProfileData
 */
public class ProfileData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileData() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String email = request.getParameter("profileEmail");
		List<String> playerInfo = new ArrayList<String>();
		String profileType="";
		DBConnection dbconnection = new DBConnection();
		try {
			Connection con = dbconnection.getConnection();
			Statement statement = con.createStatement();
			String sqlQuery = "select User_Type from userData where Email='"+email+"'";
			ResultSet rset = statement.executeQuery(sqlQuery);
			while(rset.next()) {
				profileType = rset.getString(1);
			}
			if(profileType.equalsIgnoreCase("Player")) {
				sqlQuery = "select * from playerdata where Email='"+email+"'";
				ResultSet rs = statement.executeQuery(sqlQuery);
				while(rs.next()) {
					playerInfo.add(rs.getString(1));playerInfo.add(rs.getString(2));
					playerInfo.add(rs.getString(3));playerInfo.add(rs.getString(4));
					playerInfo.add(rs.getString(5));playerInfo.add(rs.getString(6));
					playerInfo.add(rs.getString(7));playerInfo.add(rs.getString(8));
					playerInfo.add(rs.getString(9));playerInfo.add(rs.getString(10));
					playerInfo.add(rs.getString(11));
				}
			}else {
				sqlQuery = "select * from clubdata where Email='"+email+"'";
				ResultSet rs = statement.executeQuery(sqlQuery);
				while(rs.next()) {
					playerInfo.add(rs.getString(1));playerInfo.add(rs.getString(2));
					playerInfo.add(rs.getString(3));playerInfo.add(rs.getString(4));
					playerInfo.add(rs.getString(5));playerInfo.add(rs.getString(6));
					playerInfo.add(rs.getString(7));playerInfo.add(rs.getString(8));
					playerInfo.add(rs.getString(9));playerInfo.add(rs.getString(10));
				}
			}
			String playerInfoJson = "[\"";

		    for (String s : playerInfo)
		    {
		    	playerInfoJson += s + "\",\"";
		    }
		    playerInfoJson = playerInfoJson.substring(0, playerInfoJson.length() - 2) + "]";
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write(playerInfoJson);
			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String email = request.getParameter("profileEmail");
		String status = request.getParameter("profileStatus");
		String profileType="";
		DBConnection dbconnection = new DBConnection();
		try {
			Connection con = dbconnection.getConnection();
			Statement statement = con.createStatement();
			String sqlQuery = "select User_Type from userData where Email='"+email+"'";
			ResultSet rset = statement.executeQuery(sqlQuery);
			while(rset.next()) {
				profileType = rset.getString(1);
			}
			if(profileType.equalsIgnoreCase("Player")) {
				if(status.equalsIgnoreCase("accept")) {
					String profileUpdate = "update playerdata set profileApproved='yes' where Email='"+email+"'";
					if(statement.executeUpdate(profileUpdate) > 0) {
						System.out.println("Profile has been approved successfully...");
						response.setContentType("text/html;charset=UTF-8");
				        response.getWriter().write("success");
					}
				}else if(status.equalsIgnoreCase("reject")) {
					String profiledelete = "delete from playerdata where email=?";
					PreparedStatement pS = con.prepareStatement(profiledelete);
					pS.setString(1, email);
					pS.executeUpdate();
					String profileUpdate = "update userdata set Profile_Updated='no' where Email='"+email+"'";
					if(statement.executeUpdate(profileUpdate) > 0) {
						System.out.println("Profile has been rejected successfully...");
						response.setContentType("text/html;charset=UTF-8");
				        response.getWriter().write("success");
					}
				}
			}else {
				if(status.equalsIgnoreCase("accept")) {
					String profileUpdate = "update clubdata set profileApproved='yes' where Email='"+email+"'";
					if(statement.executeUpdate(profileUpdate) > 0) {
						System.out.println("Profile has been approved successfully...");
						response.setContentType("text/html;charset=UTF-8");
				        response.getWriter().write("success");
					}
				}else if(status.equalsIgnoreCase("reject")) {
					String profiledelete = "delete from clubdata where email=?";
					PreparedStatement pS = con.prepareStatement(profiledelete);
					pS.setString(1, email);
					pS.executeUpdate();
					String profileUpdate = "update userdata set Profile_Updated='no' where Email='"+email+"'";
					if(statement.executeUpdate(profileUpdate) > 0) {
						System.out.println("Profile has been rejected successfully...");
						response.setContentType("text/html;charset=UTF-8");
				        response.getWriter().write("success");
					}
				}
			}
			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
