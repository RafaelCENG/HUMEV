package Coding;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

public class Employee {
    Connection myConn = null;
    PreparedStatement preparedStatement = null;
    
    public static void fillEmployeeInformation(JTable table,String user){
        PreparedStatement ps;
        ResultSet rs;
        String selectQuery = "SELECT * FROM employee WHERE  employee_username='" + user + "'";
        try {
             Connection myConn = MySQLConnection.getConnection();
             ps=myConn.prepareStatement(selectQuery);
             rs = ps.executeQuery();
             DefaultTableModel tableModel =  (DefaultTableModel)table.getModel();
             
            for (int i = table.getRowCount() - 1; i >= 0; i--) {
                tableModel.removeRow(i);
            }
             Object[] row;
             while(rs.next())
                {
                
                 row = new Object[7];
                 row[0] = rs.getString(1);
                 row[1] = rs.getString(2);
                 row[2] = rs.getString(3);
                 row[3] = rs.getString(4);
                 row[4] = rs.getString(5);
                 row[5] = rs.getString(6);
                 row[6] = rs.getString(7);
                 tableModel.addRow(row);
                 }
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
        }
    }
    
    
    public static boolean editEmployee(String bio,String user) {
        PreparedStatement ps;
        String query = "UPDATE `employee` SET `employee_bio`=? WHERE `employee_username`='" + user + "'";
        try {
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            
            ps.setString(1, bio);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
    }
    
    public static boolean editPassword(String newPass,String user) {
        PreparedStatement ps;
        String query = "UPDATE `users` SET `user_password`=? WHERE `user_username`='" + user + "'";
        try {
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            
            ps.setString(1, newPass);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
    }
    
    public static String checkOldPassword(String user){
        PreparedStatement ps;
        ResultSet rs;
        String cPass = null;
        String selectQuery = "SELECT user_password FROM users WHERE user_username ='" + user + "'";
        try {
        Connection myConn = MySQLConnection.getConnection();
        ps=myConn.prepareStatement(selectQuery);
        rs = ps.executeQuery();
        if(rs.next()){
        cPass  = rs.getString(1);
        }
       }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
        }
       return cPass;
    }
    
    public static void fillEmployeeJobs(JTable table,String user){
        PreparedStatement ps;
        ResultSet rs;
        String selectQuery = "SELECT job_id,job_position FROM job INNER JOIN requestevaluation WHERE requestevaluation.jobreq = job_id and requestevaluation.emplreq='" + user + "'";
        try {
             Connection myConn = MySQLConnection.getConnection();
             ps=myConn.prepareStatement(selectQuery);
             rs = ps.executeQuery();
             DefaultTableModel tableModel =  (DefaultTableModel)table.getModel();
             
            for (int i = table.getRowCount() - 1; i >= 0; i--) {
                tableModel.removeRow(i);
            }
             Object[] row;
             while(rs.next())
                {
                 row = new Object[2];
                 row[0] = rs.getString(1);
                 row[1] = rs.getString(2);
                 tableModel.addRow(row);
                 }
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
        }
    }
    
      public static void fillEmployeeJobs2(JTable table){
        PreparedStatement ps;
        ResultSet rs;
        String selectQuery = "SELECT job_id,job_start_date,job_salary,job_position,job_edra,job_submission_date FROM job WHERE job_submission_date > NOW()";
        try {
             Connection myConn = MySQLConnection.getConnection();
             ps=myConn.prepareStatement(selectQuery);
             rs = ps.executeQuery();
             DefaultTableModel tableModel =  (DefaultTableModel)table.getModel();
             
            for (int i = table.getRowCount() - 1; i >= 0; i--) {
                tableModel.removeRow(i);
            }
             Object[] row;
             while(rs.next())
                {
                 row = new Object[6];
                 row[0] = rs.getString(1);
                 row[1] = rs.getString(2);
                 row[2] = rs.getString(3);
                 row[3] = rs.getString(4);
                 row[4] = rs.getString(5);
                 row[5] = rs.getString(6);
                 tableModel.addRow(row);
                 }
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
        }
    }
      
      public static void fillEmployeeReqs(JTable table,String user){
        PreparedStatement ps;
        ResultSet rs;
        String selectQuery = "SELECT emplreq,jobreq FROM  requestevaluation WHERE emplreq='" + user + "'";
        try {
             Connection myConn = MySQLConnection.getConnection();
             ps=myConn.prepareStatement(selectQuery);
             rs = ps.executeQuery();
             DefaultTableModel tableModel =  (DefaultTableModel)table.getModel();
             
            for (int i = table.getRowCount() - 1; i >= 0; i--) {
                tableModel.removeRow(i);
            }
             Object[] row;
             while(rs.next())
                {
                 row = new Object[2];
                 row[0] = rs.getString(1);
                 row[1] = rs.getString(2);
                 tableModel.addRow(row);
                 }
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
        }
    }
      
        public static boolean checkReq(String jobid,String user){
        PreparedStatement ps;
        ResultSet rs;
        String selectQuery = "SELECT emplreq,jobreq FROM requestevaluation WHERE emplreq ='" + user + "' AND jobreq ='" + jobid + "'";
        try {
        Connection myConn = MySQLConnection.getConnection();
        ps=myConn.prepareStatement(selectQuery);
        rs = ps.executeQuery();
        if(rs.next()){
            JOptionPane.showMessageDialog(null, "Already requested for the specific job");
        }
        else{
            reqJob(jobid,user);
            
        }
       }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
        return true;
    }
     
        public static boolean reqJob(String jobid,String user) {
        PreparedStatement ps;
        String query = "INSERT INTO `requestevaluation`  (`emplreq`,`jobreq`) VALUES(?,?)";
        try {
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            
            ps.setString(1, user);
            ps.setString(2, jobid);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
    }
    /////////////////////////////////////DELETE/////////////////////////////////////
        public static boolean checkReq2(String user,String jobid){
        PreparedStatement ps;
        ResultSet rs;
        String selectQuery = "SELECT emplreq,jobreq FROM requestevaluation WHERE emplreq ='" + user + "' AND jobreq ='" + jobid + "'";
        try {
        Connection myConn = MySQLConnection.getConnection();
        ps=myConn.prepareStatement(selectQuery);
        rs = ps.executeQuery();
        if(rs.next()){
            deleteJob(user,jobid);
        }
        else{
          JOptionPane.showMessageDialog(null, "There is no match for the given id");
        }
       }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
        return true;
    }
     
        public static boolean deleteJob(String user,String jobid) {
        PreparedStatement ps;
        try {
            String query = "DELETE FROM requestevaluation WHERE emplreq ='" + user + "' AND jobreq ='" + jobid + "'";
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            ps.executeUpdate(query);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
        
        
    }
}
