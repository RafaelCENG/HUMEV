package Coding;
        
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import java.sql.SQLException;
import java.sql.CallableStatement;

public  class Evaluator {
    Connection myConn = null;
    PreparedStatement preparedStatement = null;
    
     public static void fillEvaluatorInformation(JTable table,String user){
        PreparedStatement ps;
        ResultSet rs;
        String selectQuery = "SELECT * FROM evaluator WHERE  evaluator_username='" + user + "'";
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
                
                 row = new Object[3];
                 row[0] = rs.getString(1);
                 row[1] = rs.getString(2);
                 row[2] = rs.getString(3);
                 tableModel.addRow(row);
                 }
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
        }
    }
     
     public static  boolean editEvaluator(String exp_years, String firm, String user) {
        PreparedStatement ps;
        String query = "UPDATE `evaluator` SET `evaluator_exp_years`=? ,`evaluator_firm`=? WHERE `evaluator_username`=?";
        try {
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            
            ps.setString(1, exp_years);
            ps.setString(2, firm);
            ps.setString(3,user);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
    }
     
     
    public static  void fillJobInformation(JTable table){
        PreparedStatement ps;
        ResultSet rs;
        String selectQuery = "SELECT job_id,job_salary,job_position,job_announce_date,job_submission_date,job_evaluator FROM job "
                + "INNER JOIN company INNER JOIN evaluator "
                + "WHERE  job_evaluator= evaluator.evaluator_username and company.AFM = evaluator_firm;";
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
    
    public static boolean editJob(String salary, String position,String announce,String submission, String user,String id) {
        PreparedStatement ps;
        String query = "UPDATE `job` SET `job_salary`=? ,`job_position`=? ,`job_announce_date`=?, `job_submission_date`=? WHERE `job_evaluator`='" + user + "' AND `job_id`='" + id + "'";
        try {
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            
            ps.setString(1, salary);
            ps.setString(2, position);
            ps.setString(3, announce);
            ps.setString(4, submission);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
    }
    
    public static void fillAntikeimenoInformation(JTable table){
        PreparedStatement ps;
        ResultSet rs;
        String selectQuery = "SELECT * FROM antikeim;";
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
                 row = new Object[3];
                 row[0] = rs.getString(1);
                 row[1] = rs.getString(2);
                 row[2] = rs.getString(3);
                 tableModel.addRow(row);
                 }
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
        }
    }
    
    public static  boolean addJobExtra(String title, String description,String belongs) {
        PreparedStatement ps;
        String query = "INSERT INTO `antikeim`  (`antikeim_title`,`antikeim_descr`,`belongs_to`) VALUES(?,?,?)";
        try {
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, belongs);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
    }
    
        public static  boolean  addJob(String start,String salary, String position,String edra, String user,String announce,String submission) {
        PreparedStatement ps;
        String query = "INSERT INTO `job` (`job_start_date`,`job_salary`,`job_position`,`job_edra`,`job_evaluator`,`job_announce_date`, `job_submission_date`) VALUES(?,?,?,?,?,?,?)";
        try {
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            ps.setString(1, start);
            ps.setString(2, salary);
            ps.setString(3, position);
            ps.setString(4, edra);
            ps.setString(5, user);
            ps.setString(6, announce);
            ps.setString(7, submission);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
    }
        public static void fillJobInformation2(JTable table,String user){
        PreparedStatement ps;
        ResultSet rs;
        String selectQuery = "SELECT job_id,job_start_date,job_salary,job_position,job_edra,job_announce_date,job_submission_date FROM job "
                + "WHERE  job_evaluator= '" + user + "' ";
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
    
    
    public static  boolean editWatchJob(String start_date,String salary, String position,String edra,String submission_date, String user,String id) {
        PreparedStatement ps;
        String query = "UPDATE `job` SET    `job_start_date`=?, `job_salary`=? ,`job_position`=? ,`job_edra`=?, `job_submission_date`=? WHERE `job_evaluator`='" + user + "' AND `job_id`='" + id + "'";
        try {
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            
            ps.setString(1, start_date);
            ps.setString(2, salary);
            ps.setString(3, position);
            ps.setString(4, edra);
            ps.setString(5, submission_date);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
    }
    
    public static  void fillJobInformation3(JTable table,String afm){
        PreparedStatement ps;
        ResultSet rs;
        String selectQuery = "SELECT job_id,job_start_date,job_salary,job_position,job_edra,job_evaluator,job_announce_date,job_submission_date FROM job "
                + "INNER JOIN company INNER JOIN evaluator "
                + "WHERE  job_evaluator= evaluator.evaluator_username and company.AFM = '" + afm + "' and company.AFM = evaluator.evaluator_firm ";
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
                
                 row = new Object[8];
                 row[0] = rs.getString(1);
                 row[1] = rs.getString(2);
                 row[2] = rs.getString(3);
                 row[3] = rs.getString(4);
                 row[4] = rs.getString(5);
                 row[5] = rs.getString(6);
                 row[6] = rs.getString(7);
                 row[7] = rs.getString(8);
                 tableModel.addRow(row);
                 }
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
        }
    }
        public static boolean editWatchJob2(String start_date,String salary, String position,String edra,String announce_date,String submission_date, String user,String id) {
        PreparedStatement ps;
        String query = "UPDATE `job` SET    `job_start_date`=?, `job_salary`=? ,`job_position`=? ,`job_edra`=?,`job_announce_date`=?, `job_submission_date`=? WHERE `job_evaluator`='" + user + "' AND `job_id`='" + id + "'";
        try {
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            
            ps.setString(1, start_date);
            ps.setString(2, salary);
            ps.setString(3, position);
            ps.setString(4, edra);
            ps.setString(5, announce_date);
            ps.setString(6, submission_date);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
    }
        
    public static  String getAFM(String user){
        PreparedStatement ps;
        ResultSet rs;
        String afm = null;
        String selectQuery = "SELECT evaluator_firm FROM evaluator WHERE evaluator_username = '" + user + "'";
        try {
             Connection myConn = MySQLConnection.getConnection();
             ps=myConn.prepareStatement(selectQuery);
             rs = ps.executeQuery();
             if(rs.next()) {
              afm = rs.getString(1);   
             }
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
        }
        return afm;
    }
    
    public static  void fillFinal1(JTable table,String user){
        PreparedStatement ps;
        ResultSet rs;
        String selectQuery = "SELECT ID,emplusr,jobid,employees_interview,manager_report,employee_sistatikes,employee_certificates,employee_awards,employee_NumberOfProjects FROM tempresult WHERE evalusr= '" + user + "'";
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
                
                 row = new Object[9];
                 row[0] = rs.getString(1);
                 row[1] = rs.getString(2);
                 row[2] = rs.getString(3);
                 row[3] = rs.getString(4);
                 row[4] = rs.getString(5);
                 row[5] = rs.getString(6);
                 row[6] = rs.getString(7);
                 row[7] = rs.getString(8);
                 row[7] = rs.getString(9);
                 tableModel.addRow(row);
                 }
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
        }
    }
    
    public static  void fillFinal2(JTable table,String user){
        PreparedStatement ps;
        ResultSet rs;
        String selectQuery = "SELECT ID,evaluator_comments,grade1,grade2,grade3,TemporaryFinalGrade FROM tempresult WHERE evalusr='" + user + "'";
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
    
    public static  boolean editFinal(String comments,String grade1, String grade2,String grade3,String id) {
        PreparedStatement ps;
        String query = "UPDATE `tempresult` SET `evaluator_comments`=?, `grade1`=? ,`grade2`=? ,`grade3`=? WHERE `ID`='" + id + "'";
        try {
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            
            ps.setString(1, comments);
            ps.setString(2, grade1);
            ps.setString(3, grade2);
            ps.setString(4, grade3);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
    }
    
    public static  void getEvaluation(int id) throws Exception {
        String query = "{ call Done_Evaluations(?) }";
        ResultSet rs;
        try (Connection conn = MySQLConnection.getConnection();
              CallableStatement stmt = conn.prepareCall(query)) {
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    
    
     public static  void getProgress(int id,String user,JTable table) throws Exception {
        String query = "{ call IN_PROGRESS_Evaluations(?,?) }";
        ResultSet rs;
        try (Connection conn = MySQLConnection.getConnection();
              CallableStatement stmt = conn.prepareCall(query)) {
            stmt.setInt(1, id);
            stmt.setString(2, user);
            rs = stmt.executeQuery();
            
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
             catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
}
