package org.openshift; 

import java.sql.Connection; 
import java.sql.DriverManager; 
import java.sql.ResultSet; 
import java.sql.Statement; 
import java.sql.SQLException;


public class InsultGenerator { 
	public String generateInsult() { 
 	 String databaseUser = System.getenv("ORACLE_ELINK_USER");
     String databasePassword = System.getenv("ORACLE_ELINK_PASSWORD");
     String databaseIP =  System.getenv("ORACLE_SERVICE_IP");
     String databasePort = System.getenv("ORACLE_SERVICE_PORT");
     String databaseSID = System.getenv("ORACLE_DATABASE_SERVICE_ID");
	 
  try {
		 
	//USE DRIVER
	
        try {
		//The forName() method of Class class is used to register the driver class. This method is used to dynamically load the driver class.
        Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
                e.printStackTrace();
                System.out.println("Where is your Oracle JDBC Driver?");
                return "Where is your Oracle JDBC Driver?";
            }
                       
	//CONNECT TO DB
    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@10.105.68.72:1521:"+databaseSID,databaseUser,databasePassword);
    //DriverManager.getConnection("jdbc:oracle"+ ":" + iDatabaseDriverType + ":" + "@" + iDatabaseIP + iDatabasePort + ":" + iDatabaseSID, iDatabaseUser, iDatabasePassword);
	if (con != null){                
		//CREATE STATEMENT
		Statement stmt=con.createStatement();
		//EXECUTE QUERY
		ResultSet rs=stmt.executeQuery("select * from SLA_PENALTY"); //FOR LONGER QUERIES {}
		while(rs.next()) {
			System.out.println(rs.getInt(1)+"  "+rs.getString(2)+"  "+rs.getString(3));
		}
		//CLOSE DB CONNECTION
		rs.close();
		con.close();
	}
    else{
		return  "Connection is null!";
    }
  }  
  catch(Exception e){ 
		System.out.println(e);
		return "Failure in try";
  }
	return "Cannot reach this point";

} 
}
