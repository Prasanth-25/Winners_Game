package winners.game.connection;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
	
	public Connection getConnection() throws SQLException, ClassNotFoundException, IOException {
		
	    Connection con = null;
	    InputStream s = DBConnection.class.getClassLoader().getResourceAsStream("/database.properties");  
	    
	    Properties connectionProps = new Properties();
	    connectionProps.load(s);
	    
	    String username=connectionProps.getProperty("username");
	    String password=connectionProps.getProperty("password");
	    
	    Class.forName("com.mysql.cj.jdbc.Driver"); 
	    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/winners_game",username,password);
	    System.out.println("Connected to database");
	    return con;
	    
	}
	
}
