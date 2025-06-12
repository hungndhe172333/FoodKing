/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author minhp
 */
public class Table {
    private int table_id;
    private String qr_code;
    private String table_name;

    public Table() {
    }
    
    public Table(String table_name) {
        this.table_name = table_name;
    }

    public Table(int table_id, String qr_code, String table_name) {
        this.table_id = table_id;
        this.qr_code = qr_code;
        this.table_name = table_name;
    }

    public int getTable_id() {
        return table_id;
    }

    public void setTable_id(int table_id) {
        this.table_id = table_id;
    }

    public String getQr_code() {
        return qr_code;
    }

    public void setQr_code(String qr_code) {
        this.qr_code = qr_code;
    }

    public String getTable_name() {
        return table_name;
    }

    public void setTable_name(String table_name) {
        this.table_name = table_name;
    }
}
