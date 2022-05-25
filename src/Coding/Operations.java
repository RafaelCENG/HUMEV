package Coding;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

public class Operations {
    public static boolean isLogin(String username, String password, String role, JFrame frame){
        try{
            Connection myConn = MySQLConnection.getConnection();
            String mySqlQuery = 
                    "SELECT user_username, user_role, user_email FROM users WHERE user_username = '"+
                    username+
                    "' AND user_password = '"+
                    password+
                    "' AND user_role = '"+
                    role+
                    "'";
            PreparedStatement preparedStatement = myConn.prepareStatement(mySqlQuery);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            while(resultSet.next()){
                LoginSession.user_username = resultSet.getString("user_username");
                LoginSession.user_role = resultSet.getString("user_role");
                LoginSession.user_email = resultSet.getString("user_email");
                
                return true;
            }
            
        }catch (Exception exception){
            JOptionPane.showMessageDialog(frame, "Database error: " + exception.getMessage());
        }
        
        return false;
    }
}
