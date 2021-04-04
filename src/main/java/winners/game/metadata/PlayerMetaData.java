package winners.game.metadata;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import winners.game.connection.DBConnection;

/**
 * Servlet implementation class PlayerMetaData
 */
public class PlayerMetaData extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public String globalName;
	public String globalEmail;
	List<String> playerData;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlayerMetaData() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String email = request.getParameter("email");
		DBConnection dbconnection = new DBConnection();
		try {
			Connection con = dbconnection.getConnection();
			Statement statement = con.createStatement();
			
			String sqlQuery = "select user_name, Email, Mobile_number, user_type, profile_updated from userdata where Email='"+email+"'";
			ResultSet rs = statement.executeQuery(sqlQuery);
			while(rs.next()) {
				globalName = rs.getString(1);
				request.setAttribute("userName", globalName);
				globalEmail = rs.getString(2);
				request.setAttribute("userEmail", globalEmail);
				request.setAttribute("userNumber", rs.getString(3));
				request.setAttribute("profileUpdated", rs.getString(5));
				request.getRequestDispatcher(rs.getString(4)+".jsp").forward(request, response);
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		String contextRoot = getServletContext().getRealPath("/");
		factory.setRepository(new File(contextRoot));
		ServletFileUpload upload = new ServletFileUpload(factory);
		List<String> fileNametoDB = new ArrayList<String>();
	    try {
	        List<FileItem> items = upload.parseRequest(request);
	        System.out.println(items);
	        for (FileItem item : items) {
	            if (!item.isFormField()) {
	                String fileName = item.getName();
	                try {
	                    String uploadFolder = getServletContext().getRealPath("") + "/resources/upload-images";
	                    String filePath = uploadFolder + File.separator + globalName +"-"+fileName;
	                    fileNametoDB.add(globalName +"-"+fileName);
	                    File saveFile = new File(filePath);                        
	                    saveFile.createNewFile();
	                    item.write(saveFile);                        

	                } catch (Exception e) {
	                    e.printStackTrace();
	                }
	            }

	        }
	        
	        DBConnection dbconnection = new DBConnection();
	        List<String> playerBasicInfo = new ArrayList<String>();
			try {
				Connection con = dbconnection.getConnection();
				Statement statement = con.createStatement();
				System.out.println(globalEmail);
				String sqlQuery = "select user_name, Email, Mobile_number from userdata where Email='"+globalEmail+"'";
				ResultSet rs = statement.executeQuery(sqlQuery);
				while(rs.next()) {
					playerBasicInfo.add(rs.getString(1));
					playerBasicInfo.add(rs.getString(2));
					playerBasicInfo.add(rs.getString(3));
				}  
				con.close();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			try {
				Connection con = dbconnection.getConnection();
				Statement statement = con.createStatement();
				String sqlQuery = "Insert into playerdata values ('"+ playerBasicInfo.get(0) + "','" + playerBasicInfo.get(1) + "','" + playerBasicInfo.get(2) + "','" + playerData.get(0) + "','" + playerData.get(1) + "','" + playerData.get(2) + "','" + playerData.get(3) + "','" + playerData.get(4) + "','" + playerData.get(5) + "','" + fileNametoDB.get(0) + "','" + fileNametoDB.get(1)+"')";
				int queryResult = statement.executeUpdate(sqlQuery);
				if(queryResult>0) {
					System.out.println("Records Has been Inserted Successfully..");
					String profileUpdate = "update userdata set Profile_Updated='yes' where Email='"+globalEmail+"'";
					if(statement.executeUpdate(profileUpdate) > 0) {
						System.out.println("Profile has been updated successfully...");
						request.setAttribute("UserMail", globalEmail);
						request.getRequestDispatcher("Player.jsp").forward(request, response);
					}
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
			
	        
//	        System.out.println(fileNametoDB.get(0));
//	        System.out.println(fileNametoDB.get(1));
//	        for (int i = 0; i < playerBasicInfo.size(); i++) {
//				System.out.println(playerBasicInfo.get(i));
//			}
//	        for (int i = 0; i < playerData.size(); i++) {
//				System.out.println(playerData.get(i));
//			}
	    } catch (FileUploadException e) {
	    	//System.out.println("Servlet reached successfully");
	    	playerData = new ArrayList<String>();
	    	playerData.add(request.getParameter("sportsData"));
	    	playerData.add(request.getParameter("roleData"));
	    	playerData.add(request.getParameter("addressData"));
	    	playerData.add(request.getParameter("address2Data"));
	    	playerData.add(request.getParameter("cityData"));
	    	playerData.add(request.getParameter("zipData"));
	    }
	}

	/**
	 * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}
