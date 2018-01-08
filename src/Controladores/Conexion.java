/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import java.sql.Connection;
import java.sql.DriverManager;
import javax.swing.JOptionPane;

/**
 *
 * @author Tiris
 */
public class Conexion {
    
    private final String bd = "zapalanueva_bd_test";
    private final String server = "localhost";
    private final String link = "jdbc:mysql://" + server + "/" + bd;
    private final String user = "root";
    private final String pass = "";
    private Connection con = null;
    
    public Connection getConexion(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(this.link, this.user, this.pass);
            return con;
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
            return null;
        }
    }
}
