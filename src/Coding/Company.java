package Coding;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

public class Company {
    Connection myConn = null;
    PreparedStatement preparedStatement = null;
    
    
    // create a function to edit the company
    public static boolean editCompany(String afm, String doy, String Name, int phone, String street, int num, String city, String country) {
        PreparedStatement ps;
        String query = "UPDATE `Company` SET `DOY`=? ,`name`=? ,`phone`=? ,`street`=? ,`num`=? , `city`=?, `country`=? WHERE `AFM`=?";
        try {
            Connection myConn = MySQLConnection.getConnection();
            ps=myConn.prepareStatement(query);
            
            ps.setString(1, doy);
            ps.setString(2, Name);
            ps.setInt(3, phone);
            ps.setString(4, street);
            ps.setInt(5, num);
            ps.setString(6, city);
            ps.setString(7, country);
            ps.setString(8, afm);
            return(ps.executeUpdate() > 0);
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
            return false;
        }
    }
    
    
    
    // create a function to populate the jtabel with the company information
    public static void fillCompanyJTable(JTable table){
        PreparedStatement ps;
        ResultSet rs;
        String selectQuery = "SELECT AFM,DOY,name,phone,street,num,city,country FROM company INNER JOIN manager WHERE company.AFM = manager.company_firm";
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
                 row[5] = rs.getInt(6);
                 row[6] = rs.getString(7);
                 row[7] = rs.getString(8);
                 
                 tableModel.addRow(row);
                 }
        }
        catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
        }
    }
   
}
