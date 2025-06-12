/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author minhp
 */
public class Admin {
    private int admin_id;
    private String name;
    private String username;
    private String password;
    private String email;
    private TransactionHistory transactionHistory;

    public Admin() {
    }
    
    public Admin(int admin_id, String name, String username, String password, String email) {
        this.admin_id = admin_id;
        this.name = name;
        this.username = username;
        this.password = password;
        this.email = email;
    }

    public Admin(int admin_id, String name, String username, String password, String email, TransactionHistory transactionHistory) {
        this.admin_id = admin_id;
        this.name = name;
        this.username = username;
        this.password = password;
        this.email = email;
        this.transactionHistory = transactionHistory;
    }

    public int getAdmin_id() {
        return admin_id;
    }

    public void setAdmin_id(int admin_id) {
        this.admin_id = admin_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public TransactionHistory getTransactionHistory() {
        return transactionHistory;
    }

    public void setTransactionHistory(TransactionHistory transactionHistory) {
        this.transactionHistory = transactionHistory;
    }
    
    
}
