/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


/**
 *
 * @author minhp
 */
public class Employees {

    private int employee_id;
    private String name;
    private String email;
    private String password;
    private String phone_number;
    private String employment_status;
    private boolean active;
    private double hourly_wage_rate;

    public Employees() {
    }
    
    public Employees(int employee_id){
        this.employee_id = employee_id;
    }
    
    public Employees(String name){
        this.name = name;
    }
    
    public Employees(int employee_id, String name){
        this.employee_id = employee_id;
        this.name = name;
    }
    
    public Employees(int employee_id, String name, String email, String password, String phone_number,String employment_status, boolean active) {
        this.employee_id = employee_id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone_number = phone_number;
        this.employment_status = employment_status;
        this.active = active;
    }

    public Employees(int employee_id, String name, String email, String password, String phone_number, String employment_status, boolean active, double hourly_wage_rate) {
        this.employee_id = employee_id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone_number = phone_number;
        this.employment_status = employment_status;
        this.active = active;
        this.hourly_wage_rate = hourly_wage_rate;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getEmployment_status() {
        return employment_status;
    }

    public void setEmployment_status(String employment_status) {
        this.employment_status = employment_status;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public double getHourly_wage_rate() {
        return hourly_wage_rate;
    }

    public void setHourly_wage_rate(double hourly_wage_rate) {
        this.hourly_wage_rate = hourly_wage_rate;
    }

    @Override
    public String toString() {
        return "Employees{" + "employee_id=" + employee_id + ", name=" + name + ", email=" + email + ", password=" + password + ", phone_number=" + phone_number + ", employment_status=" + employment_status + ", active=" + active + ", hourly_wage_rate=" + hourly_wage_rate + '}';
    }

    
    
    
}
