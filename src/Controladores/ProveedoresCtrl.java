/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import Modelos.Proveedor;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Tiris
 */
public class ProveedoresCtrl {
    
    private Proveedor modelo;
    private Connection conexion;
    private String query;

    public ProveedoresCtrl(){
        modelo = new Proveedor();
        conexion = new Conexion().getConexion();
        query = "";
    }
    
    public ProveedoresCtrl(String nombre, String tienda, String status){
        modelo = new Proveedor(nombre, tienda, status);
        conexion = new Conexion().getConexion();
        query = "";
    }
    
    public void llenarModelo(String nombre, String tienda, String status){
        modelo.setNombre(nombre);
        modelo.setTienda(tienda);
        modelo.setStatus(status);
    }
    
    public DefaultTableModel listar(String buscar){
        DefaultTableModel modelo;
        
        String[] encabezados = {"Nombre del Proveedor", "Nombre de la Tienda", "Status"}; 
        String[] campos = new String[3];
        // totalregistros = 0;
        modelo = new DefaultTableModel(null, encabezados){
            @Override
            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return false;
            };
        };
        
        query = "SELECT * FROM proveedor WHERE nombre LIKE '%" + buscar + "%' OR  tienda LIKE '%" + buscar + "%' ORDER BY nombre";
        
        try {
            Statement st = conexion.createStatement();
            ResultSet rs = st.executeQuery(query);
            
            while (rs.next()){
                campos[0] = rs.getString("nombre");
                campos[1] = rs.getString("tienda");
                campos[2] = rs.getString("status");                
                // totalregistros++;
                modelo.addRow(campos);
            }
            return modelo;
            
        } catch (SQLException e){
            JOptionPane.showConfirmDialog(null, e);
            return null;
        }      
    }
    
    public boolean add(){
        query = "INSERT INTO proveedor SET nombre = ?, tienda = ?, status = ?";
        try {
            
            PreparedStatement pst = conexion.prepareStatement(query);
            pst.setString(1, this.modelo.getNombre());
            pst.setString(2, this.modelo.getTienda());
            pst.setString(3, this.modelo.getStatus());
            
            int resultado = pst.executeUpdate();
            
            /*/
                if (resultado > 0)
                    return true;
                else
                    return false;
                D;
            /*/
            return resultado > 0;
            
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e);
            return false;
        }        
    }
    
}
