/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author minhp
 */
public class Customer {
    private int customer_id;
    private String name;
    private String phone_number;

    public Customer() {
    }
    
    public Customer(String phone_number) {
        this.phone_number = phone_number;
    }
    
    public Customer(String name, String phone_number) {
        this.name = name;
        this.phone_number = phone_number;
    }

    public Customer(int customer_id, String name, String phone_number) {
        this.customer_id = customer_id;
        this.name = name;
        this.phone_number = phone_number;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    @Override
    public String toString() {
        return "Customer{" + "customer_id=" + customer_id + ", name=" + name + ", phone_number=" + phone_number + '}';
    }
    
    
}
