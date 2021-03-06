package winners.game.profile;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import winners.game.connection.DBConnection;

/**
 * Servlet implementation class UpdatePlayerServlet
 */
public class UpdatePlayerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	List<String> updatePlayerData;
	public String globalEmail;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdatePlayerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		globalEmail = request.getParameter("email");
		updatePlayerData = new ArrayList<String>();
		updatePlayerData.add(request.getParameter("nameUpdate"));
		updatePlayerData.add(request.getParameter("numberUpdate"));
		updatePlayerData.add(request.getParameter("roleUpdate"));
		updatePlayerData.add(request.getParameter("addressUpdate"));
		updatePlayerData.add(request.getParameter("address2Update"));
		updatePlayerData.add(request.getParameter("cityUpdate"));
		updatePlayerData.add(request.getParameter("zipUpdate"));
		if(request.getParameter("pwdUpdate")!=null) {
			updatePlayerData.add(request.getParameter("pwdUpdate"));
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		String contextRoot = getServletContext().getRealPath("/");
		factory.setRepository(new File(contextRoot));
		ServletFileUpload upload = new ServletFileUpload(factory);
		List<String> fileNametoDB = new ArrayList<String>();
		 try {
		        List<FileItem> items = upload.parseRequest(request);
		        //System.out.println(items);
		        for (FileItem item : items) {
		            if (!item.isFormField()) {
		                String fileName = item.getName();
		                try {
		                    String uploadFolder = getServletContext().getRealPath("") + "/resources/upload-images";
		                    String filePath = uploadFolder + File.separator + updatePlayerData.get(0) +"-"+fileName;
		                    if(fileName.equals("")) {
		                    	fileNametoDB.add(fileName);
		                    }else {
		                    fileNametoDB.add(updatePlayerData.get(0) +"-"+fileName);
		                    }
		                    File saveFile = new File(filePath);                        
		                    saveFile.createNewFile();
		                    item.write(saveFile);                        

		                } catch (Exception e) {
		                    e.printStackTrace();
		                }
		            }

		        }
		        
		        DBConnection dbconnection = new DBConnection();
				try {
					Connection con = dbconnection.getConnection();
					Statement statement = con.createStatement();
					String profileUpdate = "update playerdata set name=?, contact_number=?, role=?, address=?, addressExtended=?, city=?, zipcode=? where email=?";
					PreparedStatement pS = con.prepareStatement(profileUpdate);
					pS.setString(1, updatePlayerData.get(0));pS.setString(2, updatePlayerData.get(1));
					pS.setString(3, updatePlayerData.get(2));pS.setString(4, updatePlayerData.get(3));
					pS.setString(5, updatePlayerData.get(4));pS.setString(6, updatePlayerData.get(5));
					pS.setString(7, updatePlayerData.get(6));pS.setString(8, globalEmail);
					pS.executeUpdate();
					String userUpdate = "update userData set User_Name=?, Mobile_Number=? where Email=?";
					PreparedStatement pSt = con.prepareStatement(userUpdate);
					pSt.setString(1, updatePlayerData.get(0));pSt.setString(2, updatePlayerData.get(1));
					pSt.setString(3, globalEmail);
					pSt.executeUpdate();
					if(updatePlayerData.size() == 8) {
						String profilepwdUpdate = "update userdata set Password='"+updatePlayerData.get(7)+"' where Email='"+globalEmail+"'";
						statement.executeUpdate(profilepwdUpdate);
					}
					if(fileNametoDB.get(0).equals("") == false) {
						String profilepwdUpdate = "update playerdata set imageLocation='"+fileNametoDB.get(0)+"' where Email='"+globalEmail+"'";
						statement.executeUpdate(profilepwdUpdate);
					}
					if(fileNametoDB.get(1).equals("") == false) {
						String profilepwdUpdate = "update playerdata set docsLocation='"+fileNametoDB.get(1)+"' where Email='"+globalEmail+"'";
						statement.executeUpdate(profilepwdUpdate);
					}
					request.setAttribute("UserMail", globalEmail);
					request.getRequestDispatcher("Player.jsp").forward(request, response);
					
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				} catch (SQLException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
		    } catch (FileUploadException e) {
		    	e.printStackTrace();
		    }
	}

}
