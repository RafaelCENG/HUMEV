package Coding;


import java.sql.*;

public class MySQLConnection {
    public static Connection getConnection() throws Exception{
        String dbRoot = "jdbc:mysql://";
        String hostName = "localhost:3306/";
        String dbName = "HUMEV_DATABASE";
        String dbUrl = dbRoot+hostName+dbName;
        
        String hostUsername = "root";
        String hostPassword = "strike123";
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection myConn = (Connection)DriverManager.getConnection(dbUrl, hostUsername, hostPassword);

        return myConn;
    }
}
