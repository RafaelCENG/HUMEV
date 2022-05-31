package Coding;

import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.swing.JOptionPane;


public class Administrator {
    public static boolean addJob(String start,String salary, String position,String edra, String evaluator,String announce,String submission) {
        PreparedStatement ps;
        String query = "INSERT INTO `job` (`job_start_date`,`job_salary`,`job_position`,`job_edra`,`job_evaluator`,`job_announce_date`, `job_submission_date`) VALUES(?,?,?,?,?,?,?)";
        try {
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            ps.setString(1, start);
            ps.setString(2, salary);
            ps.setString(3, position);
            ps.setString(4, edra);
            ps.setString(5, evaluator);
            ps.setString(6, announce);
            ps.setString(7, submission);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
    }
    
    public static boolean addCompany(String afm,String doy,String name,String phone,String street,String num,String city,String country) {
        PreparedStatement ps;
        String query = "INSERT INTO `company` (`AFM`,`DOY`,`name`,`phone`,`street`,`num`, `city`,`country`) VALUES(?,?,?,?,?,?,?,?)";
        try {
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            ps.setString(1, afm);
            ps.setString(2, doy);
            ps.setString(3, name);
            ps.setString(4, phone);
            ps.setString(5, street);
            ps.setString(6, num);
            ps.setString(7, city);
            ps.setString(8, country);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
    }
    
    public static boolean addItem(String title,String desc,String belong) {
        PreparedStatement ps;
        String query = "INSERT INTO `antikeim` (`antikeim_title`,`antikeim_descr`,`belongs_to`) VALUES(?,?,?)";
        try {
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            ps.setString(1, title);
            ps.setString(2, desc);
            ps.setString(3, belong);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
    }
}