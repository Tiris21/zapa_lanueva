/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

/**
 *
 * @author Tiris
 */
public class Proveedor {
    
    private int id_proveedor;
    private String nombre;
    private String tienda;
    private String status;
    
    public Proveedor(){
    }

    
    public Proveedor(String nombre, String tienda, String status) {
        this.nombre = nombre;
        this.tienda = tienda;
        this.status = status;
    }
    
    public Proveedor(int id_proveedor, String nombre, String tienda, String status) {
        this.id_proveedor = id_proveedor;
        this.nombre = nombre;
        this.tienda = tienda;
        this.status = status;
    }

    public int getId_proveedor() {
        return id_proveedor;
    }

    public void setId_proveedor(int id_proveedor) {
        this.id_proveedor = id_proveedor;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTienda() {
        return tienda;
    }

    public void setTienda(String tienda) {
        this.tienda = tienda;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}
